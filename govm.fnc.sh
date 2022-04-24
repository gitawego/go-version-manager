GO_BINARIES_URL="https://go.dev/dl"
GO_PACKAGE_URL="golang.org/dl"
GO_SDK_LOCATION=$HOME/sdk
export GOPATH=$HOME/go

function govm(){
    case $1 in
        list)
            ls -la $GOPATH/bin/
            ;;

        switch)
            go_vm_switch $2
            ;;
        remove)
            go_vm_remove $2
            ;;
        install)
            go_vm_install $2
            ;;
        *)
            echo "manage golang version
        usage: 
            install a version of golang: govm install <version>
            remove a version of golang: govm remove <version>
            list installed versions: govm list
            switch to a locally existing version: govm switch <version>
        "
            ;;
    esac
}

function go_vm_install(){
    local version=$1
    local dir=$(pwd)
    cd $HOME
    echo "downloading $folderName"
    curl -kLs "${GO_BINARIES_URL}/go${version}.linux-amd64.tar.gz" | tar xfz -
    mv $GOPATH/bin/go $GOPATH/bin/go${version}
    ln -s $GOPATH/bin/go${version} $GOPATH/bin/go
    echo "now using go version ${version}"
    cd $dir
}

function go_vm_remove(){
    local version=$1
    echo "removing folder: $GO_SDK_LOCATION/go${version}"
    rm -rf $GO_SDK_LOCATION/go${version}
    rm -f $GOPATH/bin/go${version}
    if [ -L $GOPATH/bin/go ] && [ -n "$(ls -la $GOPATH/bin/go | grep ${version})" ];then
        rm -f $GOPATH/bin/go
        echo "please switch to a new version using 'govm switch <version>'"
    fi
    echo "go version ${version} is removed"
}

function go_vm_switch(){
    local version=$1
    echo "switch to version $version"
    if [ ! -f $GOPATH/bin/go ];then
        go_vm_install $version
        return
    fi
    go install ${GO_PACKAGE_URL}/go${version}@latest
    go${version} download
    rm -f $GOPATH/bin/go || true
    ln -s $GOPATH/bin/go${version} $GOPATH/bin/go
    
}



export PATH=$PATH:$GOPATH/bin