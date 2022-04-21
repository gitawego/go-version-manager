function govm(){
    if [ "$1" == "-h" ];then
        echo "manage golang version
        usage: 
            install a version of golang: govm <version>
            remove a version of golang: govm remove <version>
            list installed versions: govm list
            switch a version: govm switch <version>
        "
        return
    fi
    if [ "$1" == "list" ];then
        ls -la ~/.go/
        return
    fi
    if [ "$1" == "switch" ];then
        go_vm_switch $2
        return
    fi
    if [ "$1" == "remove" ];then
        go_vm_remove $2
        return
    fi
    local version=$1
    local dir=$(pwd)
    cd ~/.go
    local folderName="go${version}"
    echo "downloading $folderName"
    curl -kLs "https://go.dev/dl/go${version}.linux-amd64.tar.gz" | tar xfz -
    mv go $folderName
    rm -f current || true
    ln -s "$(pwd)/$folderName" "$(pwd)/current" 
    echo "now using go version ${version}"
    cd $dir
}

function go_vm_remove(){
    local version=$1
    echo "removing folder: ~/.go/go${version}"
    rm -rf ~/.go/go${version}
    if [ -L ~/.go/current ] && [ -n "$(ls -la ~/.go/current | grep ${version})" ];then
        rm -f ~/.go/current
        echo "please switch to a new version"
    fi
}

function go_vm_switch(){
    if [ "$1" == "-h" ];then
        echo "switch go version
        usage: go_vm_switch <version>"
        return
    fi
    local version=$1
    local folderName="go${version}"
    echo "switch to version $version"
    if [ ! -d ~/.go/$folderName ];then
        echo "no version $version found locally, installing it"
        go_vm $version
        return
    fi

    rm -f ~/.go/current || true
    ln -s ~/.go/$folderName ~/.go/current
    
}

export PATH=~/.go/current/bin:$PATH