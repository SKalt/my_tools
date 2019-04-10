# alias-like functions
function exists() {
  if [ -e $1 ]; then
    echo "exists" && return 0;
  else
    echo "false" && return 1;
  fi;
}

function mcd() { mkdir -p $1 && cd $1; };

function print-path() {
  echo $PATH | awk -F ':' '
  {
    for(i = 1; i <= NF; i++) {
      print $i;
    }
  }';
}
