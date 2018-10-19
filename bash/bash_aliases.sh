alias mcd='mkdir $1 && cd $1'

# alias-like functions
exists() {
  if [ -e $1 ]; then
    echo "exists" && return 0;
  else
    echo "false" && return 1;
  fi;
}
