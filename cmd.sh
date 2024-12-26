#!/bin/bash
args=("$@")

tag(){
    VERSION="${args[1]}"
    git tag -a v${VERSION} -m "tag release"
    git push --tags
}

wsl(){
    source vllm/bin/activate
}

wsl2(){
    python3 -m venv vllm
    source vllm/bin/activate
    python3 -m pip install --upgrade pip setuptools wheel
    python3 -m ensurepip --upgrade

    apt-key del 7fa2af80
    wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
    mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/3bf863cc.pub
    add-apt-repository 'deb https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/ /'
    apt-get update
    apt-get -y install cuda

    nvcc --version
    python3 -m pip install vllm
}

init(){
    git submodule init
}

update(){
    git submodule update
}

$*