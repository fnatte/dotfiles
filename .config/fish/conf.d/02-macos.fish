if test (uname) != "Darwin"
  exit
end

set -gx GPG_TTY (tty)

eval (ssh-agent -c) > /dev/null

set -gx PATH $PATH /usr/local/bin

