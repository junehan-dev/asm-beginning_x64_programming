8. Memory
=========

Memory is used by the processor as a storage room for data and instructions.
We have already discussed registers, which are high-speed access storage places. Slower than registers but more spaces about 16 exabytes.
(but cannot use that much memory because of practical design issues!)

Exploring Memory
----------------


stack memory
^^^^^^^^^^^^

``lea <dest> <src>;  Load Effective Address``
   Computes the effective address of the second operand(src) and store it in the first operand(dest).

   ARGUMENTS
      - ``src``
         The source operand is a *memory address* specified with one of the *processors addressing modes.*
      - ``dest``
         The dest operand is a general-purpose register.

   - Address-size of operand affect the action performed by this instruction.
   - Operand-size attribute of the instruction is determined by the chosen register.
   - Address-size attribute is determined by the attribute of the code segment.


memory.asm_
^^^^^^^^^^^

- ``lea`` to load the memory address of ``bnum`` into ``rax``
   - ``lea rax [bnum]`` is EQU to ``mov rax bum``
   - Because ``rax`` is 64-bit regitster, more bytes are loaded into rax.
   - without ``lea``, ``xor rax rax`` | ``mov al [bNum]`` should be done.
- When loading content from memory address ``text1`` into rax, note how the value in ``rax`` is in little-endian notation.

.. code-block:: asm

   mov rbp, rsp
   ; rbp    0x7fffffffe2e0
   ; rsp	0x7fffffffe2e0
   ; bnum	0x404028
   ; x/1b	0x404028
   ; 123

   ; rax 4198672
   lea	rax, [bNum]
   ; rax 4210728
   ; x/b	$rax
   ; 123

Moved 1 byte value from bnum and store to end of rax.

.. _memory.asm: srcs/memory.asm

readelf - Display information about ELF files
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Description
   *readelf* displays information about one or more ELF format object files.
   The Options control what particular information to display.

Remember that we asked NAMS to assemble using the ELF format.
*readelf* is CLI tool used to obtain information about elf file.

.. code-block:: bash

   $ readelf --file-header ./srcs/memory.elf

   ELF Header:
     Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00 
     Class:                             ELF64
     Data:                              2's complement, little endian
     Version:                           1 (current)
     OS/ABI:                            UNIX - System V
     ABI Version:                       0
     Type:                              EXEC (Executable file)
     Machine:                           Advanced Micro Devices X86-64
     Version:                           0x1
     Entry point address:               0x401020
     Start of program headers:          64 (bytes into file)
     Start of section headers:          14800 (bytes into file)
     Flags:                             0x0
     Size of this header:               64 (bytes)
     Size of program headers:           56 (bytes)
     Number of program headers:         13
     Size of section headers:           64 (bytes)
     Number of section headers:         32
     Section header string table index: 31

Entry Point Address
   Look at the Entry Point address: ``0x401020``
   This is the memory location of the start of our program.
   So, between the program entry and the start of the code,
   as shown in GDB(main and rax is equal address)::

      rax 0x401110
      rbx 0x401190
      <main> 0x401110

   So, between the Entry point with code segments, There is some overhead.
   The header provides us with addtiional information about th OS and the executable code.

.. code-block:: bash

   Entry point address:               0x401020

   $ readelf --symbols ./memory.elf | grep main
    49: 0000000000401110     0 NOTYPE  GLOBAL DEFAULT   12 main

   $ readekf --symbols ./memory.elf | grep start
     3: 0000000000000000     0 NOTYPE  WEAK   DEFAULT  UND __gmon_start__
    24: 0000000000401114     0 NOTYPE  LOCAL  DEFAULT   12 start
    31: 0000000000403e40     0 NOTYPE  LOCAL  DEFAULT   17 __init_array_start
    36: 0000000000404018     0 NOTYPE  WEAK   DEFAULT   22 data_start
    39: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND __libc_start_mai[...]
    40: 0000000000404018     0 NOTYPE  GLOBAL DEFAULT   22 __data_start
    41: 0000000000000000     0 NOTYPE  WEAK   DEFAULT  UND __gmon_start__
    47: 0000000000401020    47 FUNC    GLOBAL DEFAULT   12 _start // ENTRY
    48: 000000000040403b     0 NOTYPE  GLOBAL DEFAULT   23 __bss_start

Summary
   - The start of the Program is at some low address.
   - Stack is in high memory (rsp)
   - Executable code is at lower side of memory. (readelf)
   - Top of Executable code
      0. Entry point	: 0x401020
      1. Main point		: 0x401110
      2. section .data	: 0x404018
      3. section .bss	: 0x40403b
   - Stack(RSP) from High memory, Executable from lower Memory.
   - Stack between additional after data(bss,..) section is called heap.


