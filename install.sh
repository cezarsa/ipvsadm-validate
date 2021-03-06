#!/bin/bash

set -eo pipefail

mkdir -p ipvsadm

if [[ ! -d ipvsadm/base ]]; then
    pushd ipvsadm
    git clone git://git.kernel.org/pub/scm/utils/kernel/ipvsadm/ipvsadm.git base
    pushd base
    git remote add cezarsa https://github.com/cezarsa/ipvsadm.git
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
IPVSADM_PATCHED=${IPVSADM_PATCHED:-"./ipvsadm/ipvsadm-patched"}
HYPERFINE=$(echo ./hyperfine/*/hyperfine)

if [[ ! -f $HYPERFINE ]]; then
    mkdir -p hyperfine
    pushd hyperfine
    curl -L -o hyperfine.tgz https://github.com/sharkdp/hyperfine/releases/download/v1.11.0/hyperfine-v1.11.0-x86_64-unknown-linux-gnu.tar.gz
    tar -zxf ./hyperfine.tgz
    popd
    HYPERFINE=$(echo ./hyperfine/*/hyperfine)
fi

jitter() {
    sleep $(bc <<< "$RANDOM%10 * 0.001")
}

setup() {
    local nsvcs=$1
    local ndsts=$2

    dstport=10000

    $IPVSADM_PATCHED -C

    for ((i=0;i<$nsvcs;i++)); do
        svcport=$((30000+$i))
        $IPVSADM_PATCHED -A -t 10.0.0.1:$svcport -s rr

        for ((j=0;j<$ndsts;j++)); do
            $IPVSADM_PATCHED -a -t 10.0.0.1:$svcport -r 10.0.0.1:$dstport -m
            dstport=$((${dstport}+1))
        done
    done
}

setupfw() {
    local nsvcs=$1
    local ndsts=$2

    dstport=10000

    if [[ $3 != "keep" ]]; then
        $IPVSADM_PATCHED -C
    fi

    for ((i=0;i<$nsvcs;i++)); do
        $IPVSADM_PATCHED -A -f $((1+$i)) -s rr

        for ((j=0;j<$ndsts;j++)); do
            $IPVSADM_PATCHED -a -f $((1+$i)) -r 10.0.0.1:$dstport -m
            dstport=$((${dstport}+1))
        done
    done
}
