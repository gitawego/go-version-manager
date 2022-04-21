#!/usr/bin/env bash

echo "creating folder .go in home"

mkdir -p ~/.go

cd ~

curl -kL -O https://raw.githubusercontent.com/gitawego/go-version-manager/main/go-vm.fnc.sh

echo "source ./go-vm.fnc.sh" >> ~/.bashrc