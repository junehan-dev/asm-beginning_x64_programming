ASMC			= nasm
ASMFLAGS		= -g -f elf64 -F dwarf
OBJECTS			= src/01.o
NAME			= src/01.elf
.DEFAULT_GOAL	:= all

all: $(NAME)

$(NAME): $(OBJECTS)
	gcc -o $@ $^ -no-pie

src/01.o:
	$(ASMC) $(ASMFLAGS) -o $@ src/01_hello_world.asm -l src/01.lst

clean:
	/bin/rm $(OBJECTS) src/01.elf src/01.lst
