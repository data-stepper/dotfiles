# Luke's prompt script for using the dmenu

if [ $(echo "No\nYes" | dmenu -i -p "$1") = "Yes" ];then $2
fi
