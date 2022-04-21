#!/usr/bin/env bash

echo "creating folder .go in home"

mkdir -p ~/.go

cd ~

curl -H 'Pragma: no-cache' -kL -O https://raw.githubusercontent.com/gitawego/go-version-manager/main/go-vm.fnc.sh

grep -qxF 'source ./go-vm.fnc.sh' ~/.bashrc || echo 'source ./go-vm.fnc.sh' >> ~/.bashrc


cd -

source ~/.bashrc
