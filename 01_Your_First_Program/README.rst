1. Your First Program
=====================

.. code-block:: Make

   ASMFLAGS		= -g -f elf64 -F dwarf

   $(NAME): $(OBJECTS)
       gcc -o $@ $^ -no-pie

   src/01.o:
       $(ASMC) $(ASMFLAGS) -o $@ src/01_hello_world.asm -l src/01.lst

``-l``
   tell NAMS to generate ``.lst`` file.
   used to examine the result of the assembly.


.. note::

   가끔 일어나는 일로,

   - NASM complains with number of cryptic(숨은) messages and refuses to give you an object file.
   - also complains so often that it will drive you almost insane.

   그러한 경우에, 진정하고, 커피를 한잔 마셔야한다. 그리고 코드를 리뷰하자.
   많이 할 수록, 늘게 될 것이다.

finally NASM give you an object file, this object file is then linked with a linker.

A linker
   takes your object code and searches the system for other files that are needed,
   typically system services or other object files.

최신 GCC 링커와 컴파일러는 *position-independent executables(PIEs)* 를 생성한다. by default.
이것은 해커들이 어떻게 memory가 prog에 의해서 사용되는지 알아 낼 수 없게 하여, 프로그램을 방해하는 것을 막을 것이다.
At this point, we will not build position-independent executables.::

   이것은 프로그램의 분석을 복잡하게 한다.
   그리하여, 우리는 param에 ``-no-pie`` 을 추가하였다.

**GNU linker인 ``ld`` 도 있지만, asm코드에서 C stdlib functions에 쉽게 접근하기 위해서 GCC를 사용하였다.**

Structure of an Assembly Program
--------------------------------

Main parts of ASM program::

   - section .data
   - section .bss
   - section .text

section .data
^^^^^^^^^^^^^

Data section
   **Initialized data is declared and defined.**

Syntax::

   ``<variable name>    <type>  <value>``
   ``<constant name>    equ <value>``
   ``pi equ 3.1416``

Type::

   ==== ====== ======
   TYPE Bits   Name
   ==== ====== ======
   DB   8      Byte
   DW   16     Word
   DD   32     2 Word
   DQ   64     4 Word
   ==== ====== ======

- ``variable`` memory is allocated when the source code is assembled and linked to an linked to an executable.
- The variable name refers to the start address of the variable in memory.
- ``section .data`` also contain constants with type named ``equ``

section .bss
^^^^^^^^^^^^

BSS
   Block Started by Symbol.
   It's history goes back to fifties, when it was part of asm-lang developed for IBM 704.
   **Space for uninitialized variables.**

Syntax::

   ``<variable name>    <type>  <number>``
   ``dArray resd    20``

Type::

   ==== ====== ======
   TYPE Bits   Name
   ==== ====== ======
   RESB 8      Byte
   RESW 16     Word
   RESD 32     2 Word
   RESQ 64     4 Word
   ==== ====== ======

- Variable do not contain any value, and will assigned at execution time.
- Memory places are not reserved at compile time but at execution time.::

   1. program starts executing.
   #. program asks for needed memory for OS.
   #. allocates memaddr for variables in ``section .bss`` initialized to zeros.

- If there is not enough memory availabe for ``.bss`` at execution time, then program crash.

section .text
^^^^^^^^^^^^^

section .text
   Where all action is.
   Contains the program code.

Syntax::

   .. code-block:: asm

      global
          <subroutine label>    // name export for linking.

      <subroutine label>:; // no instructions? add colon to avoid error.

- When a label on a line without anything following it, the word is best follwed by a colon.
   - Otherwise, the assembler will send you a warning.
   - When followed by instructions, colon is not needed.

- Best to make it habit to end all labels with a colon.
   - Doing so will increase readability of your code.

- The instruction ``mov`` can be used as follows::

   - ``mov <register> <immediate value>``
   - ``mov <register> <memory>``
   - ``mov <memory> <register>``
   - iligal! ``mov <memory> <memory>``

- Do not count the quotes of the string or the terminating 0.
   - if counts terminating 0, program will try to display a ``NULL`` byte, which is a bit senseless.

- To avoid error messages when the program finishes, a clean program exit is needed.
   - ``mov rax, 60// syscall exit`` , ``mov rdi, 0// exit with code 0`` , ``syscall``

Syscall
^^^^^^^

Syscall
   Syscall are used to ask the OS to do specific actions.
   We use the Linux system calls for x64 in this book.
   more detail at, http://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/

- Be aware that 32-bit syscalls differ from 64-bit syscalls.

Assembly Listing output

.. code-block:: asm

   1                                  section .data
   2                                      SYS_WRITE       EQU 1
   3                                      STDOUT_FILENO   EQU 1
   4 00000000 68656C6C6F2C20776F-         msg             DB  "hello, world", 0
   4 00000009 726C6400           
   5                                      msg_len         EQU $-msg
   6                                  
   7                                  section .bss
   8                                  section .text
   9                                      global main
   10                                  
   11                                  main:
   12 00000000 B801000000                  mov     RAX, SYS_WRITE
   13 00000005 BF01000000                  mov     RDI, STDOUT_FILENO
   14 0000000A 48BE-                       mov     RSI, msg
   14 0000000C [0000000000000000] 
   15 00000014 BA0C000000                  mov     RDX, 12
   16 00000019 0F05                        syscall    
   17                                  
   18 0000001B B83C000000                  mov     RAX, 60
   19 00000020 BF00000000                  mov     RDI, 0
   20 00000025 0F05                        syscall
   <Linenum>    <8byte-MEM_ADDR>    <MACHINE_INSTRUCTION_IN_HEX>

left side:   generated code in hex Shown
right side:  original Source Shown

- Every output equals in same condition, intel-x86-64, nasm, same source code...

**<MEM_ADDR>**

   - objectfile addr start from 0 means execution allocates to start address.
   - *0 to different sections.*
   - **section .bss part has no memory yet in object code.**

**<INSTRUCTTION_IN_HEX>**

   - ``mov rax`` is converted to ``B8``
   - ``mov rdi`` to ``BF``
   - LINE 12, first instruction: 5bytes of instruction: ``B8 01 00 00 00``
   - double zero are these for padding and memory alignment.
   - memory alignment is feature used by assemblers and compilers *to optimize code.*

Assembler mnemonic and symbolic names for mem address are quite a bit easier to remember than hex values.

First Gen language:     machine language(like ``B8`` which programmer used)
Second Gen language:    Assembly language(lang with easier to remember mnemonics)
