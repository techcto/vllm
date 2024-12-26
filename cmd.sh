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
    wget https://developer.download.nvidia.com/compute/cuda/12.1.1/local_installers/cuda_12.1.1_530.30.02_linux.run
    ./cuda_12.1.1_530.30.02_linux.run
    apt install nvidia-cuda-toolkit
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