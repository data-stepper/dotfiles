# Script that launches a dmenu to choose a virtual environment.

env=$(ls ~/envs | dmenu -i -p "Choose a virtual environment:")
cmd=$(echo "source ~/envs/$env/bin/activate")
gnome-terminal -- sh -c 'echo "$cmd"|zsh -i -s; exec zsh'
