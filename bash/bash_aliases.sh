# alias-like functions
exists() {
  if [ -e $1 ]; then
    echo "exists" && return 0;
  else
    echo "false" && return 1;
  fi;
}

mcd() { mkdir -p $1 && cd $1 }
