.PHONY: clean
CC=gcc
CFLAGS=-Wall
NO_ARG_FOLDER=source/noArgument/
BINARIES=$(addprefix bin/, $(notdir $(patsubst %.s,%,$(wildcard $(NO_ARG_FOLDER)*.s))))
NO_ARG_BENCHES=$(patsubst %.s,%.o,$(wildcard $(NO_ARG_FOLDER)*.s))

MULT_ARG_FOLDER=source/multipleArguments/
MULT_BINARIES=$(addprefix bin/, $(notdir $(patsubst %.s,%,$(wildcard $(MULT_ARG_FOLDER)*.s))))
MULT_ARG_BENCHES=$(patsubst %.s,%.o,$(wildcard $(MULT_ARG_FOLDER)*.s))
MULT_ARG_DRIVERS=$(patsubst %.s,%_driver.c,$(wildcard $(MULT_ARG_FOLDER)*.s))

all: $(NO_ARG_BENCHES) $(BINARIES) $(MULT_ARG_BENCHES) $(MULT_BINARIES)

$(BINARIES): bin/%: $(NO_ARG_FOLDER)%.o $(NO_ARG_FOLDER)driver.c 
	$(CC) $(CFLAGS) $(NO_ARG_FOLDER)driver.c $< -o $@

$(NO_ARG_BENCHES): %.o : %.s
	$(CC) -c $(CFLAGS) $< -o $@

$(MULT_BINARIES): bin/%: $(MULT_ARG_FOLDER)%.o $(MULT_ARG_DRIVERS)
	$(CC) $(CFLAGS) $(MULT_ARG_FOLDER)$(@F)_driver.c $< -o $@

$(MULT_ARG_BENCHES): %.o : %.s
	$(CC) -c $(CFLAGS) $< -o $@

clean:
	rm -f bin/*
	rm -f data/*
	rm -f $(NO_ARG_FOLDER)*.o
	rm -f $(MULT_ARG_FOLDER)*.o
