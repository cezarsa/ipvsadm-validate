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
Benchmark #1: ./ipvsadm/ipvsadm-base -Ln --nosort
  Time (mean ± σ):      27.6 ms ±   0.5 ms    [User: 9.3 ms, System: 18.2 ms]
  Range (min … max):    26.5 ms …  29.2 ms    106 runs

Benchmark #2: ./ipvsadm/ipvsadm-patched -Ln --nosort
  Time (mean ± σ):      11.0 ms ±   0.2 ms    [User: 4.8 ms, System: 6.2 ms]
  Range (min … max):    10.7 ms …  11.8 ms    261 runs

Summary
  './ipvsadm/ipvsadm-patched -Ln --nosort' ran
    2.51 ± 0.06 times faster than './ipvsadm/ipvsadm-base -Ln --nosort'

**** BENCHMARK 2000 services - 2 destinations each ****
Benchmark #1: ./ipvsadm/ipvsadm-base -Ln --nosort
  Time (mean ± σ):      46.8 ms ±   0.7 ms    [User: 14.3 ms, System: 32.2 ms]
  Range (min … max):    45.6 ms …  49.0 ms    64 runs

Benchmark #2: ./ipvsadm/ipvsadm-patched -Ln --nosort
  Time (mean ± σ):      13.6 ms ±   0.3 ms    [User: 5.6 ms, System: 8.1 ms]
  Range (min … max):    13.2 ms …  14.8 ms    212 runs

Summary
  './ipvsadm/ipvsadm-patched -Ln --nosort' ran
    3.43 ± 0.08 times faster than './ipvsadm/ipvsadm-base -Ln --nosort'

**** BENCHMARK 8000 services - 2 destinations each ****
Benchmark #1: ./ipvsadm/ipvsadm-base -Ln --nosort
  Time (mean ± σ):     191.7 ms ±   2.6 ms    [User: 50.7 ms, System: 138.8 ms]
  Range (min … max):   187.0 ms … 195.3 ms    15 runs

Benchmark #2: ./ipvsadm/ipvsadm-patched -Ln --nosort
  Time (mean ± σ):      87.9 ms ±   1.6 ms    [User: 22.9 ms, System: 65.0 ms]
  Range (min … max):    85.0 ms …  91.9 ms    34 runs

Summary
  './ipvsadm/ipvsadm-patched -Ln --nosort' ran
    2.18 ± 0.05 times faster than './ipvsadm/ipvsadm-base -Ln --nosort'
```