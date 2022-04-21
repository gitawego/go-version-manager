function go_vm(){
    if [ "$1" == "-h" ];then
        echo "usage: go_vm <version>"
        return
    fi
    local version=$1
    local dir=$(pwd)
    cd ~/.go
    local folderName="go${version}"
    echo "downloading $folderName"
    curl -kLs "https://go.dev/dl/go${version}.linux-amd64.tar.gz" | tar xfz -
    mv go $folderName
    rm -rf current || true
    ln -s "$(pwd)/$folderName" "$(pwd)/current" 
    cd $dir
}

function go_vm_list(){
    ls -la ~/.go/
}

function go_vm_switch(){
    if [ "$1" == "-h" ];then
        echo "switch go version
        usage: go_vm_switch <version>"
        return
    fi
    local version=$1
    local folderName="go${version}"

    if [ ! -d "$folderName" ];then
        echo "no version $version found"
        return
    fi

    rm -rf ~/.go/current || true
    ln -s ~/.go/$folderName ~/.go/current
    
}

export PATH=~/.go/current/bin:$PATH