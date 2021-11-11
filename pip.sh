#!/usr/bin/env bash

function checkPip(){
	pip3 --version 
}

function checkPython3(){
	 python3 --version 
}

function checkVirtualEnv(){
	virtualenv --version 
}


if checkPython3
then
	:
else
	echo "virtualenv is not installed" 
	sudo apt install python3
fi

if checkPip
then
	:
else
	echo "virtualenv is not installed"
	sudo apt-get -y install python3-pip
fi

if checkVirtualEnv
then
	:
else
	echo "virtualenv is not installed"
	pip3 install virtualenv
fi

VALID_ARGS=$(getopt -o u:,s --long url:,http_server -- "$@")
if [[ $? -ne 0 ]]; then
    exit 1;
fi


ARGS=""

eval set -- "$VALID_ARGS"
while [ : ]; do
  case "$1" in
    -u | --url)
        echo "The url is '$2'"
	ARGS="$ARGS $1 $2"
        shift 2
        ;;
    -s | --http_server)
        echo "Serving the content through http server"
	ARGS="$ARGS $1"
        shift 
        ;;
    --) shift; 
        break 
        ;;
  esac
done

echo $ARGS
virtualenv venv
source ./venv/bin/activate
pip install -r ./requirements.txt
python ./args.py $ARGS

echo "I run"
deactivate
rm -rf ./venv
