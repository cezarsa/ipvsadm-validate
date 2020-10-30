#!/bin/bash

. install.sh


run_bench() {
    nsvcs=$1
    ndsts=$2
    echo; echo "**** BENCHMARK ${nsvcs} services - ${ndsts} destinations each ****"
    setup $nsvcs $ndsts
    $HYPERFINE --warmup 6 \
        -L ipvsadm $IPVSADM_BASE,$IPVSADM_PATCHED \
        "{ipvsadm} -Sn"
}

run_bench 1000  4
run_bench 2000  2
run_bench 8000  2
run_bench 16000 1
run_bench 100   100