#!/bin/bash

set -eo pipefail

. install.sh

test_diff_base_vs_patched() {
    setup 100 4

    diff -u <($IPVSADM_BASE -Ln) <($IPVSADM_PATCHED -Ln)
    diff -u <($IPVSADM_BASE -Ln --nosort) <($IPVSADM_PATCHED -Ln --nosort)
    diff -u <($IPVSADM_BASE -Sn) <($IPVSADM_PATCHED -Sn)

    echo "Passed ${FUNCNAME[0]}"
}

test_add_destination_while_dump() {
    setup 500 2

    $IPVSADM_PATCHED -Ln >./old.txt
    for ((i=0;i<100;i++)); do
        (jitter; $IPVSADM_PATCHED -a -t 10.0.0.1:30001 -r 10.0.0.1:40000 -m) &
        (jitter; $IPVSADM_PATCHED -Ln >./new.txt) &
        wait
        
        set +e
        result=$(diff --normal old.txt new.txt)
        set -e

        expected=$(cat << EOF
9a10
>   -> 10.0.0.1:40000               Masq    1      0          0         
EOF
)
   
        # Diff result may be empty or a single new destination added
        if [[ "${result}" != "" ]] && \
           [[ "${result}" != "${expected}" ]]; then
           echo "Unexpected diff: Expected: \"${expected}\", Got: \"${result}\""
           exit 1
        fi

        $IPVSADM_PATCHED -d -t 10.0.0.1:30001 -r 10.0.0.1:40000
    done

    echo "Passed ${FUNCNAME[0]}"
}

test_remove_destination_while_dump() {
    setup 100 5

    $IPVSADM_PATCHED -Ln >./old.txt
    for ((i=0;i<100;i++)); do
        (jitter; $IPVSADM_PATCHED -d -t 10.0.0.1:30000 -r 10.0.0.1:10003) &
        (jitter; $IPVSADM_PATCHED -Ln >./new.txt) &
        wait
        
        set +e
        result=$(diff --normal old.txt new.txt)
        set -e

        expected=$(cat << EOF
8d7
<   -> 10.0.0.1:10003               Masq    1      0          0         
EOF
)
   
        # Diff result may be empty or a single destination removed
        if [[ "${result}" != "" ]] && \
           [[ "${result}" != "${expected}" ]]; then
           echo "Unexpected diff: Expected: \"${expected}\", Got: \"${result}\""
           exit 1
        fi

        $IPVSADM_PATCHED -a -t 10.0.0.1:30000 -r 10.0.0.1:10003 -m
    done

    echo "Passed ${FUNCNAME[0]}"
}

test_remove_service_while_dump() {
    setup 500 2

    $IPVSADM_PATCHED -Ln >./old.txt
    for ((i=0;i<200;i++)); do
        (jitter; $IPVSADM_PATCHED -D -t 10.0.0.1:30001) &
        (jitter; $IPVSADM_PATCHED -Ln >./new.txt) &
        wait
        
        set +e
        result=$(diff -u old.txt new.txt)
        set -e

        if tail -n +4 <<<${result} | grep '^+' >/dev/null; then
            echo "Unexpected diff: Expected no added lines, got: \"${result}\""
            exit 1
        fi

        $IPVSADM_PATCHED -A -t 10.0.0.1:30001 -s rr
        $IPVSADM_PATCHED -a -t 10.0.0.1:30001 -r 10.0.0.1:10002 -m
        $IPVSADM_PATCHED -a -t 10.0.0.1:30001 -r 10.0.0.1:10003 -m
    done

    echo "Passed ${FUNCNAME[0]}"
}

test_add_service_while_dump() {
    setup 500 2

    $IPVSADM_PATCHED -Ln >./old.txt
    for ((i=0;i<200;i++)); do
        (jitter; $IPVSADM_PATCHED -A -t 10.0.0.1:31000 -s rr) &
        (jitter; $IPVSADM_PATCHED -Ln >./new.txt) &
        wait
        
        set +e
        result=$(diff -u old.txt new.txt)
        set -e

        if tail -n +4 <<<${result} | grep '^-' >/dev/null; then
            echo "Unexpected diff: Expected no removed lines, got: \"${result}\""
            exit 1
        fi

        $IPVSADM_PATCHED -D -t 10.0.0.1:31000
    done

    echo "Passed ${FUNCNAME[0]}"
}

echo; echo '**** STARTING TESTS ****'; echo

test_diff_base_vs_patched
test_add_destination_while_dump
test_remove_destination_while_dump
test_add_service_while_dump
test_remove_service_while_dump
