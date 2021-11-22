# fnm is short for fast node manager. It is like nvm, it switches node versions.
if type -q fnm
  fnm env | source
else
  echo "fnm is not installed."
end

