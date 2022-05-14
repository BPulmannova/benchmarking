.PHONY: clean

all:
	gcc -c source/5-ld-5-st-1-mil.s -o bin/5-ld-5-st-1-mil.o
	gcc source/driver.c bin/5-ld-5-st-1-mil.o -o bin/5-ld-5-st-1-mil

clean:
	rm -f bin/*
	rm -f data/*
	rm -f logs/*
