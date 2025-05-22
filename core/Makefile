 CC = gcc
AS = nasm
CFLAGS = -Wall -O3 -I/usr/include/openssl -I/usr/include/torch
LDFLAGS = -L/usr/lib -lssl -lcrypto -ltorch
ASMFLAGS = -f elf64

OBJECTS = network.o logic.o autocatalysis.o recursion.o autodidactic.o \
          info_processing.o hierarchical.o merkle_verifier.o revp.o \
          polysemantic.o memory.o meta_controller.o matmul.o sha256.o

all: train

train: $(OBJECTS)
	$(CC) $(OBJECTS) $(LDFLAGS) -o train

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

matmul.o: matmul.asm
	$(AS) $(ASMFLAGS) $< -o $@

sha256.o: sha256.asm
	$(AS) $(ASMFLAGS) $< -o $@

clean:
	rm -f *.o train

test:
	$(CC) $(CFLAGS) tests/test_logic.c $(OBJECTS) $(LDFLAGS) -o test_logic
	$(CC) $(CFLAGS) tests/test_merkle.c $(OBJECTS) $(LDFLAGS) -o test_merkle
	./test_logic
	./test_merkle
