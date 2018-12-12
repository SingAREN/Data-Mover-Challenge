# Singularity Setup for CentOS 7

## Pre-Requisites

**Dependency Installation**

    $ sudo yum update -y && \
        sudo yum groupinstall -y 'Development Tools' && \
        sudo yum install -y \
        openssl-devel \
        libuuid-devel \
        libseccomp-devel \
        wget \
        squashfs-tools \
        git

**Go Installation**

    $ export VERSION=1.11 OS=linux ARCH=amd64 && \
        wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz && \
        sudo tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz && \
        rm go$VERSION.$OS-$ARCH.tar.gz

**Setup Go Environment**

    $ echo 'export GOPATH=${HOME}/go' >> ~/.bashrc && \
        echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc && \
        source ~/.bashrc

**Setup Go `dep` module for Dependency Resolution**

    $ go get -u github.com/golang/dep/cmd/dep
    
## Singularity v3.0.1 Source Installation

**Download Singularity GitHub Repo with Go**

    $ go get -d github.com/sylabs/singularity
    
**Set Singularity to v3.0.1 within the Git Repo**

    $ export VERSION=v3.0.1 # or another tag or branch if you like && \
        cd $GOPATH/src/github.com/sylabs/singularity && \
        git fetch && \
        git checkout $VERSION # omit this command to install the latest bleeding edge code from master

**Compile Singularity**

    $ ./mconfig && \
        make -C ./builddir && \
        sudo make -C ./builddir install
 
By default Singularity will be installed in the `/usr/local` directory hierarchy. You can specify a custom directory with the `--prefix` flag when executing `mconfig`.
 
**Source bash Completion File**

    $ echo ". /usr/local/etc/bash_completion.d/singularity" >> ~/.bashrc
 
---
 
### Reference: 
[Sylabs Singularity 3.0 Installation Guide](https://www.sylabs.io/guides/3.0/user-guide/installation.html)
