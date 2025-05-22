CC = gcc
CFLAGS = -Wall -O3 -I../core
LDFLAGS = -L../core -lcore

all: experiment

experiment: experiment.o
	$(CC) $< $(LDFLAGS) -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f *.o experiment
