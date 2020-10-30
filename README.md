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
  Time (mean ± σ):      27.3 ms ±   0.5 ms    [User: 9.0 ms, System: 18.1 ms]
  Range (min … max):    26.4 ms …  29.6 ms    106 runs

Benchmark #2: ./ipvsadm/ipvsadm-patched -Sn
  Time (mean ± σ):      10.7 ms ±   0.2 ms    [User: 4.6 ms, System: 6.2 ms]
  Range (min … max):    10.4 ms …  11.6 ms    269 runs

Summary
  './ipvsadm/ipvsadm-patched -Sn' ran
    2.54 ± 0.06 times faster than './ipvsadm/ipvsadm-base -Sn'

**** BENCHMARK 2000 services - 2 destinations each ****
Benchmark #1: ./ipvsadm/ipvsadm-base -Sn
  Time (mean ± σ):      46.7 ms ±   0.7 ms    [User: 14.1 ms, System: 32.4 ms]
  Range (min … max):    45.6 ms …  49.0 ms    62 runs

Benchmark #2: ./ipvsadm/ipvsadm-patched -Sn
  Time (mean ± σ):      13.5 ms ±   0.3 ms    [User: 5.4 ms, System: 8.2 ms]
  Range (min … max):    13.1 ms …  14.5 ms    212 runs

Summary
  './ipvsadm/ipvsadm-patched -Sn' ran
    3.46 ± 0.09 times faster than './ipvsadm/ipvsadm-base -Sn'

**** BENCHMARK 8000 services - 2 destinations each ****
Benchmark #1: ./ipvsadm/ipvsadm-base -Sn
  Time (mean ± σ):     194.0 ms ±   2.4 ms    [User: 55.3 ms, System: 136.6 ms]
  Range (min … max):   190.6 ms … 197.9 ms    15 runs

Benchmark #2: ./ipvsadm/ipvsadm-patched -Sn
  Time (mean ± σ):      91.3 ms ±   1.5 ms    [User: 25.3 ms, System: 66.0 ms]
  Range (min … max):    88.9 ms …  95.0 ms    31 runs

Summary
  './ipvsadm/ipvsadm-patched -Sn' ran
    2.12 ± 0.04 times faster than './ipvsadm/ipvsadm-base -Sn'

**** BENCHMARK 16000 services - 1 destinations each ****
Benchmark #1: ./ipvsadm/ipvsadm-base -Sn
  Time (mean ± σ):     406.3 ms ±   6.7 ms    [User: 97.5 ms, System: 304.3 ms]
  Range (min … max):   396.4 ms … 414.6 ms    10 runs

Benchmark #2: ./ipvsadm/ipvsadm-patched -Sn
  Time (mean ± σ):     186.5 ms ±   5.1 ms    [User: 29.9 ms, System: 156.3 ms]
  Range (min … max):   179.3 ms … 195.3 ms    16 runs

Summary
  './ipvsadm/ipvsadm-patched -Sn' ran
    2.18 ± 0.07 times faster than './ipvsadm/ipvsadm-base -Sn'

**** BENCHMARK 100 services - 100 destinations each ****
Benchmark #1: ./ipvsadm/ipvsadm-base -Sn
  Time (mean ± σ):      21.0 ms ±   0.3 ms    [User: 9.0 ms, System: 12.0 ms]
  Range (min … max):    20.6 ms …  22.1 ms    140 runs

Benchmark #2: ./ipvsadm/ipvsadm-patched -Sn
  Time (mean ± σ):      20.0 ms ±   0.3 ms    [User: 9.1 ms, System: 10.9 ms]
  Range (min … max):    19.5 ms …  21.0 ms    144 runs

Summary
  './ipvsadm/ipvsadm-patched -Sn' ran
    1.05 ± 0.02 times faster than './ipvsadm/ipvsadm-base -Sn'
```