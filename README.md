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
  Time (mean ± σ):      26.0 ms ±   0.4 ms    [User: 8.5 ms, System: 17.4 ms]
  Range (min … max):    25.2 ms …  27.2 ms    113 runs

Benchmark #2: ./ipvsadm/ipvsadm-patched -Sn
  Time (mean ± σ):       9.9 ms ±   0.2 ms    [User: 4.0 ms, System: 5.9 ms]
  Range (min … max):     9.6 ms …  10.6 ms    289 runs

Summary
  './ipvsadm/ipvsadm-patched -Sn' ran
    2.64 ± 0.06 times faster than './ipvsadm/ipvsadm-base -Sn'

**** BENCHMARK 2000 services - 2 destinations each ****
Benchmark #1: ./ipvsadm/ipvsadm-base -Sn
  Time (mean ± σ):      44.6 ms ±   0.5 ms    [User: 14.8 ms, System: 29.4 ms]
  Range (min … max):    43.6 ms …  46.2 ms    65 runs

Benchmark #2: ./ipvsadm/ipvsadm-patched -Sn
  Time (mean ± σ):      12.1 ms ±   0.2 ms    [User: 5.5 ms, System: 6.6 ms]
  Range (min … max):    11.7 ms …  12.8 ms    242 runs

Summary
  './ipvsadm/ipvsadm-patched -Sn' ran
    3.70 ± 0.07 times faster than './ipvsadm/ipvsadm-base -Sn'

**** BENCHMARK 8000 services - 2 destinations each ****
Benchmark #1: ./ipvsadm/ipvsadm-base -Sn
  Time (mean ± σ):     181.2 ms ±   2.8 ms    [User: 56.3 ms, System: 122.9 ms]
  Range (min … max):   176.9 ms … 186.1 ms    16 runs

Benchmark #2: ./ipvsadm/ipvsadm-patched -Sn
  Time (mean ± σ):      48.1 ms ±   0.7 ms    [User: 20.8 ms, System: 27.2 ms]
  Range (min … max):    47.0 ms …  49.9 ms    61 runs

Summary
  './ipvsadm/ipvsadm-patched -Sn' ran
    3.77 ± 0.08 times faster than './ipvsadm/ipvsadm-base -Sn'

**** BENCHMARK 16000 services - 1 destinations each ****
Benchmark #1: ./ipvsadm/ipvsadm-base -Sn
  Time (mean ± σ):     363.3 ms ±   5.4 ms    [User: 81.1 ms, System: 278.1 ms]
  Range (min … max):   355.6 ms … 371.4 ms    10 runs

Benchmark #2: ./ipvsadm/ipvsadm-patched -Sn
  Time (mean ± σ):      66.2 ms ±   0.7 ms    [User: 29.3 ms, System: 36.9 ms]
  Range (min … max):    65.2 ms …  68.8 ms    45 runs

Summary
  './ipvsadm/ipvsadm-patched -Sn' ran
    5.49 ± 0.10 times faster than './ipvsadm/ipvsadm-base -Sn'

**** BENCHMARK 100 services - 100 destinations each ****
Benchmark #1: ./ipvsadm/ipvsadm-base -Sn
  Time (mean ± σ):      21.1 ms ±   0.2 ms    [User: 8.6 ms, System: 12.5 ms]
  Range (min … max):    20.6 ms …  21.8 ms    136 runs

Benchmark #2: ./ipvsadm/ipvsadm-patched -Sn
  Time (mean ± σ):      19.2 ms ±   0.3 ms    [User: 7.9 ms, System: 11.2 ms]
  Range (min … max):    18.7 ms …  20.0 ms    148 runs

Summary
  './ipvsadm/ipvsadm-patched -Sn' ran
    1.10 ± 0.02 times faster than './ipvsadm/ipvsadm-base -Sn'

**** BENCHMARK 8000 services - 1 destinations each ****
**** WITH 8000 FW services - 1 destinations each ****
Benchmark #1: ./ipvsadm/ipvsadm-base -Sn
  Time (mean ± σ):     337.4 ms ±   3.3 ms    [User: 81.5 ms, System: 253.0 ms]
  Range (min … max):   333.8 ms … 343.8 ms    10 runs

Benchmark #2: ./ipvsadm/ipvsadm-patched -Sn
  Time (mean ± σ):      63.8 ms ±   1.3 ms    [User: 26.7 ms, System: 37.1 ms]
  Range (min … max):    62.3 ms …  68.8 ms    47 runs

Summary
  './ipvsadm/ipvsadm-patched -Sn' ran
    5.29 ± 0.12 times faster than './ipvsadm/ipvsadm-base -Sn'
```