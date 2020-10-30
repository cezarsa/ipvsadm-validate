.PHONY: all test al

all: test bench

test:
	sudo ./test.sh

bench:
	sudo ./bench.sh
