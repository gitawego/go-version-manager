#!/usr/bin/env bash

echo "creating folder .go in home"

mkdir -p ~/.go

cd ~

curl -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -kL -O https://raw.githubusercontent.com/gitawego/go-version-manager/main/govm.fnc.sh

grep -qxF 'source ./govm.fnc.sh' ~/.bashrc || echo 'source ./govm.fnc.sh' >> ~/.bashrc


cd -

source ~/.bashrc

echo "don't forget to source ~/.bashrc if the go_vm is not found"