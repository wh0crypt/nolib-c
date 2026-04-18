CC = gcc
CFLAGS_STD = -Wall -Wextra -O2
CFLAGS_NOLIB = -ffreestanding -z noseparate-code -fno-stack-protector -nostdlib -static

# If no folder is provided, it will throw an error or use a default
FOLDER ?= .

SOURCES = $(wildcard $(FOLDER)/*.c)
BINS = $(patsubst $(FOLDER)/%.c, $(FOLDER)/%, $(SOURCES))

all: $(BINS)

$(FOLDER)/%: $(FOLDER)/%.c
	@mkdir -p $(dir $@)
	@echo "Compiling $<..."
	@if echo "$*" | grep -q "^nolib-"; then \
		$(CC) $(CFLAGS_NOLIB) $< -o $@; \
		echo "Mode: Freestanding (nolib)"; \
	else \
		$(CC) $(CFLAGS_STD) $< -o $@; \
		echo "Mode: Standard"; \
	fi

clean:
	@echo "Cleaning binaries and non-source files..."
	@find $(FOLDER) -type f -executable ! -name "*.c" -delete

.PHONY: all clean
