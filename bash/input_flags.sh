#http://linuxcommand.org/wss0130.php
while [ "$1" != "" ]; do
    case $1 in
        -a | --abc )           shift
                               filename=$1
                               ;;
        -b | --bcd )           do_something=1
                               ;;
        -h | --help )          usage
                               exit
                               ;;
        * )                    usage
                               exit 1
    esac
    shift
done
