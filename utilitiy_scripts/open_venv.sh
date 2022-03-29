# Script that launches a dmenu to choose a virtual environment.

environment_chosen=$(ls ~/envs | dmenu -i -p "Choose a virtual environment:")
directory="source $HOME/envs/$environment_chosen/bin/activate"

$(echo $directory)


