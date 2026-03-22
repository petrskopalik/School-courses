# tools
CC = gcc
ASM = nasm
CFLAGS = -Wall -g -m64
ASMFLAGS = -f elf64

# directories
BIN_DIR = bin
OBJ_DIR = obj

# files
C_SRCS = assignment1.c tests.c
ASM_SRCS = assignment3.asm assignment4.asm assignment5.asm

C_OBJ = $(addprefix $(OBJ_DIR)/, $(C_SRCS:.c=.o))
ASM_OBJ = $(addprefix $(OBJ_DIR)/, $(ASM_SRCS:.asm=.o))

TARGET = $(BIN_DIR)/tests

# main target
all: $(TARGET)

# create bin/ and obj/
$(BIN_DIR):
	mkdir -p $(BIN_DIR)

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

# links
$(TARGET): $(C_OBJ) $(ASM_OBJ) | $(BIN_DIR)
	$(CC) $(CFLAGS) $^ -o $@

# compile .c files
$(OBJ_DIR)/%.o: %.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# compile .asm files
$(OBJ_DIR)/%.o: %.asm | $(OBJ_DIR)
	$(ASM) $(ASMFLAGS) $< -o $@

# commands and settings
run: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(C_OBJ) $(ASM_OBJ) $(TARGET)

.PHONY: all run clean