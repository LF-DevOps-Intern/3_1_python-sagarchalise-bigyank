#!/usr/bin/env bash

# exit when any command fails
set -e


function checkPip(){
    pip3 --version
}

function checkPython3(){
    python3 --version
}

function checkVirtualEnv(){
    virtualenv --version
}


function checkSysRequirements(){
    if checkPython3
    then
        :
    else
        echo "python 3 is not installed on the system"
        sudo apt install python3
    fi
    
    if checkPip
    then
        :
    else
        echo "pip3 is not installed on the system"
        sudo apt-get -y install python3-pip
    fi
    
    if checkVirtualEnv
    then
        :
    else
        echo "virtualenv is not installed"
        pip3 install virtualenv
    fi
}


function parseArgs(){
    unset url
    ARGS=""
    
    VALID_ARGS=$(getopt -o u:,s --long url:,http_server -- "$@")
    if [[ $? -ne 0 ]]; then
        exit 1;
    fi
    
    eval set -- "$VALID_ARGS"
    while [ : ]; do
        case "$1" in
            -u | --url)
                ARGS="$ARGS $1 $2"
                url=$1
                shift 2
            ;;
            -s | --http_server)
                ARGS="$ARGS $1"
                shift
            ;;
            --) shift;
                break
            ;;
        esac
    done
    : ${url:?Missing -h}
    echo $ARGS
}

function runPythonScript(){
    
    # start virtual env
    virtualenv venv
    source ./venv/bin/activate
    
    # install dependencies
    pip install -r ./requirements.txt
    
    # run python and pass args
    python ./args.py $@
}

function cleanup(){
    # cleanup
    deactivate
    rm -rf ./venv
}


function main(){
    checkSysRequirements
    FLAGS=$(parseArgs $@)
    echo $FLAGS
    runPythonScript $FLAGS
    cleanup
}

main $@


