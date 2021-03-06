#!/usr/bin/env bash

echo "creating folder .go in home"

cd ~

curl -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -kL -O https://raw.githubusercontent.com/gitawego/go-version-manager/main/govm.fnc.sh

grep -qxF 'source ./govm.fnc.sh' ~/.bashrc || echo 'source ./govm.fnc.sh' >> ~/.bashrc


cd -

source ~/.bashrc

echo "don't forget to source ~/.bashrc if the govm is not found"