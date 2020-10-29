#!/bin/bash

. install.sh


function run_bench {
    nsvcs=$1
    ndsts=$2
    echo; echo "**** BENCHMARK ${nsvcs} services - ${ndsts} destinations each ****"
    setup $nsvcs $ndsts
    sudo $HYPERFINE --warmup 5 \
        -L ipvsadm $IPVSADM_BASE,$IPVSADM_PATCHED \
        "{ipvsadm} -Ln --nosort"
}

run_bench 1000 4
run_bench 2000 2
run_bench 8000 2