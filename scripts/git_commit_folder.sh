# Shell script to add everything from a folder, commit and push directly
git add *
git add .*
git commit -m "$1"
git push
