if type -q starship
  starship init fish | source
else
  echo "Starfish was not installed."
end

