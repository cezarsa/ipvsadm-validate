#!/bin/bash

. install.sh


run_bench() {
    nsvcs=$1
    ndsts=$2
    nsvcsfw=$3
    echo; echo "**** BENCHMARK ${nsvcs} services - ${ndsts} destinations each ****"
    setup $nsvcs $ndsts
    if [[ $nsvcsfw != "" ]]; then
        echo "**** WITH ${nsvcsfw} FW services - ${ndsts} destinations each ****"
        setupfw $nsvcsfw $ndsts keep
    fi
    $HYPERFINE --warmup 6 \
        -L ipvsadm $IPVSADM_BASE,$IPVSADM_PATCHED \
        "{ipvsadm} -Sn"
}

run_bench 1000  4
run_bench 2000  2
run_bench 8000  2
run_bench 16000 1
run_bench 100   100
run_bench 8000  1   8000
