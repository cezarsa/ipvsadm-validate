# ipvsadm-validate

Tests and benchmarks for a patched kernel with a patched ipvsadm

Tested code:

* kernel from https://github.com/cezarsa/linux/tree/ipvs-dump-all
* ipvsadm from https://github.com/cezarsa/ipvsadm/tree/dump-svc-ds

# Requirements

Kernel must be patched with `ipvs-dump-all` branch from https://github.com/torvalds/linux/compare/master...cezarsa:ipvs-dump-all

# Benchmark results

Benchmarks using the [hyperfine](https://github.com/sharkdp/hyperfine),
executed with `make bench`:

```
**** BENCHMARK 1000 services - 4 destinations each ****
Benchmark #1: ./ipvsadm/ipvsadm-base -Sn
  Time (mean ± σ):      26.8 ms ±   0.5 ms    [User: 8.4 ms, System: 18.2 ms]
  Range (min … max):    26.0 ms …  28.4 ms    111 runs

Benchmark #2: ./ipvsadm/ipvsadm-patched -Sn
  Time (mean ± σ):      10.2 ms ±   0.1 ms    [User: 4.1 ms, System: 6.1 ms]
  Range (min … max):    10.0 ms …  10.6 ms    283 runs

Summary
  './ipvsadm/ipvsadm-patched -Sn' ran
    2.63 ± 0.06 times faster than './ipvsadm/ipvsadm-base -Sn'

**** BENCHMARK 2000 services - 2 destinations each ****
Benchmark #1: ./ipvsadm/ipvsadm-base -Sn
  Time (mean ± σ):      45.7 ms ±   0.8 ms    [User: 11.8 ms, System: 33.5 ms]
  Range (min … max):    44.3 ms …  47.7 ms    65 runs

Benchmark #2: ./ipvsadm/ipvsadm-patched -Sn
  Time (mean ± σ):      12.4 ms ±   0.2 ms    [User: 5.3 ms, System: 7.1 ms]
  Range (min … max):    12.1 ms …  13.1 ms    238 runs

Summary
  './ipvsadm/ipvsadm-patched -Sn' ran
    3.69 ± 0.09 times faster than './ipvsadm/ipvsadm-base -Sn'

**** BENCHMARK 8000 services - 2 destinations each ****
Benchmark #1: ./ipvsadm/ipvsadm-base -Sn
  Time (mean ± σ):     189.2 ms ±   1.9 ms    [User: 54.7 ms, System: 131.9 ms]
  Range (min … max):   186.1 ms … 194.1 ms    15 runs

Benchmark #2: ./ipvsadm/ipvsadm-patched -Sn
  Time (mean ± σ):      48.6 ms ±   0.7 ms    [User: 20.8 ms, System: 27.7 ms]
  Range (min … max):    47.8 ms …  50.9 ms    60 runs

Summary
  './ipvsadm/ipvsadm-patched -Sn' ran
    3.89 ± 0.07 times faster than './ipvsadm/ipvsadm-base -Sn'

**** BENCHMARK 16000 services - 1 destinations each ****
Benchmark #1: ./ipvsadm/ipvsadm-base -Sn
  Time (mean ± σ):     377.3 ms ±   3.4 ms    [User: 90.5 ms, System: 281.8 ms]
  Range (min … max):   372.4 ms … 383.1 ms    10 runs

Benchmark #2: ./ipvsadm/ipvsadm-patched -Sn
  Time (mean ± σ):      67.2 ms ±   0.5 ms    [User: 30.3 ms, System: 36.9 ms]
  Range (min … max):    66.5 ms …  68.5 ms    44 runs

Summary
  './ipvsadm/ipvsadm-patched -Sn' ran
    5.62 ± 0.06 times faster than './ipvsadm/ipvsadm-base -Sn'

**** BENCHMARK 100 services - 100 destinations each ****
Benchmark #1: ./ipvsadm/ipvsadm-base -Sn
  Time (mean ± σ):      21.3 ms ±   0.2 ms    [User: 9.0 ms, System: 12.3 ms]
  Range (min … max):    21.0 ms …  22.3 ms    139 runs

Benchmark #2: ./ipvsadm/ipvsadm-patched -Sn
  Time (mean ± σ):      19.5 ms ±   0.2 ms    [User: 7.6 ms, System: 11.9 ms]
  Range (min … max):    19.2 ms …  20.3 ms    151 runs

Summary
  './ipvsadm/ipvsadm-patched -Sn' ran
    1.09 ± 0.02 times faster than './ipvsadm/ipvsadm-base -Sn'

**** BENCHMARK 8000 services - 1 destinations each ****
**** WITH 8000 FW services - 1 destinations each ****
Benchmark #1: ./ipvsadm/ipvsadm-base -Sn
  Time (mean ± σ):     339.1 ms ±   2.1 ms    [User: 91.0 ms, System: 243.9 ms]
  Range (min … max):   336.4 ms … 342.5 ms    10 runs

Benchmark #2: ./ipvsadm/ipvsadm-patched -Sn
  Time (mean ± σ):      63.2 ms ±   0.8 ms    [User: 23.7 ms, System: 39.5 ms]
  Range (min … max):    62.1 ms …  66.4 ms    46 runs

Summary
  './ipvsadm/ipvsadm-patched -Sn' ran
    5.36 ± 0.08 times faster than './ipvsadm/ipvsadm-base -Sn'
```