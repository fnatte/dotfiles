if test (uname) != "Darwin"
  exit
end

set -gx GPG_TTY (tty)
