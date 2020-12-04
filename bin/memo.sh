if [ $# -eq 0 ] ; then
  filename=$(ls $HOME/memo | fzf --reverse --preview 'cat ~/memo/{}')
  if [ -n "$filename" ] ; then
    nvim "$HOME/memo/$filename"
  else
    echo "file is not selected"
  fi
elif [ $# -eq 1 ] ; then
  nvim "$HOME/memo/$1.txt"
else
  echo "Usage: memo <filename> or memo"
fi
