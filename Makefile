.PHONY: clean
CC=gcc
CFLAGS=-Wall
BINARIES=$(addprefix bin/, $(notdir $(patsubst %.s,%,$(wildcard source/*.s))))
BENCH_OBJ=$(patsubst %.s,%.o,$(wildcard source/*.s))

all: $(BENCH_OBJ) $(BINARIES)

$(BINARIES): bin/%: source/%.o
	$(CC) $(CFLAGS) source/driver.c $< -o $@

${BENCH_OBJ}: %.o : %.s
	$(CC) -c $(CFLAGS) $< -o $@

clean:
	rm -f bin/*
	rm -f data/*
	rm -f source/*.o
