#!/usr/bin/env python
import sys, json
from typing import Any, Dict, List, Optional

from kitty.key_encoding import EventType, KeyEvent
from kitty.remote_control import encode_send, create_basic_command
from kitty.utils import ScreenSize

from kittens.tui.handler import Handler
from kittens.tui.loop import Loop
from kittens.tui.operations import styled

class Navigation(Handler):
    print_on_fail: Optional[str] = None

    def __init__(self):
        self.tabs = []
        self.selected = 0

    def initialize(self) -> None:
        self.original_size = self.screen_size
        self.cmd.set_cursor_visible(False)
        self.cmd.set_line_wrapping(False)
        self.request_tabs()
        self.draw_screen()

    def request_tabs(self) -> List[Dict[str, Any]]:
        cmd = create_basic_command('ls')
        self.write(encode_send(cmd))

    def on_kitty_cmd_response(self, response: Dict[str, Any]) -> None:
        if not response.get('ok'):
            err = response['error']
            if response.get('tb'):
                err += '\n' + response['tb']
            self.print_on_fail = err
            self.quit_loop(1)
            return
        data = response.get('data')
        parsed_data = json.loads(data)

        # Make sure we have a list of tabs
        if not isinstance(parsed_data, list) or len(parsed_data) == 0:
            return

        self.tabs = parsed_data[0].get('tabs')

        # Set the selected tab to the currently focused tab
        for idx, tab in enumerate(self.tabs):
            if tab['is_focused']:
                self.selected = idx
                break

        self.draw_screen()

    def on_text(self, text: str, in_bracketed_paste: bool = False) -> None:
        text = text.upper()
        if text == 'K':
            self.selected = (self.selected - 1) % len(self.tabs)
            self.draw_screen()
        elif text == 'J':
            self.selected = (self.selected + 1) % len(self.tabs)
            self.draw_screen()
        elif text == 'Q':
            self.quit_loop(0)

    def on_key(self, key_event: KeyEvent) -> None:
        if key_event.type is EventType.RELEASE:
            return

        if key_event.matches('esc'):
            self.quit_loop(0)
        elif key_event.matches('enter'):
            tab = self.tabs[self.selected]
            payload = { 'match': f'id:{tab["id"]}' }
            cmd = create_basic_command('focus_tab', payload, no_response=True)
            self.write(encode_send(cmd))
            self.quit_loop(0)

    def on_resize(self, new_size: ScreenSize) -> None:
        self.draw_screen()

    def draw_screen(self) -> None:
        self.cmd.clear_screen()
        print = self.print

        for idx, tab in enumerate(self.tabs or []):
            text = f"Tab #{tab['id']}: {tab['title']}"
            if idx == self.selected:
                text = styled(text, bg='blue', fg='white', fg_intense=True)
            print(text)

def main(args: List[str]) -> None:
    loop = Loop()
    handler = Navigation()
    loop.loop(handler)
    if handler.print_on_fail:
        print(handler.print_on_fail, file=sys.stderr)
        input('Press Enter to quit')
    raise SystemExit(loop.return_code)

