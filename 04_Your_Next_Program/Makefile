CC				= gcc
CFLAGS			= -Werror -Wall -Wextra -Iinclude -g -no-pie
NAME			= run.out
OBJECTS			= src/printf_all.o
				#src/printf_numbers.o \
				#src/printf_floats.o \
				#src/extern_printf.o \
				#src/alive.o \
				#src/alive_origin.o

.DEFAULT_GOAL	:= all

all: build
$(NAME): build

.PHONY: build
build: $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o $(NAME)

src/alive.o:
	nasm -g -f elf64 -F dwarf src/alive.asm -l src/alive.lst

src/alive_origin.o:
	nasm -g -f elf64 -F dwarf src/alive_origin.asm -l src/alive_origin.lst

src/extern_printf.o:
	nasm -g -f elf64 -F dwarf src/extern_printf.asm -l src/extern_printf.lst

src/printf_floats.o:
	nasm -g -f elf64 -F dwarf src/printf_floats.asm -l src/printf_floats.lst

src/printf_numbers.o:
	nasm -g -f elf64 -F dwarf src/printf_numbers.asm -l src/printf_numbers.lst

src/printf_all.o:
	nasm -g -f elf64 -F dwarf src/printf_all.asm -l src/printf_all.lst


clean:
	/bin/rm $(NAME) src/*.o src/*.lst
