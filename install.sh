#!/bin/bash

set -eo pipefail

mkdir -p ipvsadm

if [[ ! -d ipvsadm/base ]]; then
    pushd ipvsadm
    git clone git://git.kernel.org/pub/scm/utils/kernel/ipvsadm/ipvsadm.git base
    pushd base
    git remote add cezarsa git@github.com:cezarsa/ipvsadm.git
    git fetch -a cezarsa
    git worktree add ../patched cezarsa/dump-svc-ds
    popd
    popd
fi

pushd ipvsadm/base
make
cp ipvsadm ../ipvsadm-base
popd

pushd ipvsadm/patched
make
cp ipvsadm ../ipvsadm-patched
popd

IPVSADM_BASE="./ipvsadm/ipvsadm-base"
IPVSADM_PATCHED="./ipvsadm/ipvsadm-patched"
