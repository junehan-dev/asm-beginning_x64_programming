4. Your Next Program: Alive and Kicking!
========================================

What to look?

   - 문자열의 길이를 얻는 방법.
   - ``printf``\를 사용하여, 숫자와 부동소수점을 출력하는 방법.
   - GDB명령어에 대한 추가적인 이해.

Printing
--------

extern_printf
^^^^^^^^^^^^^

.. code-block:: asm

   ; src/extern_printf.asm
   extern   printf        ; declare the function as external

   section .data
       msg      db  "Hello World!", 0
       fmtstr   db  "This is Our string: %s", 10, 0 ; print format

   # ... go on...

Build command:
   ``gcc -o run.out src/extern_printf.asm -l src/extern_printf.lst``

Build procedure:
   1. Object file compiled with nasm. (assemble the asm code file) to binary object.
   #. compile with gcc option ``-no-pie``, other wise ``printf`` causes an error.

Build options:
   ``-no-pie``
      Don't produce a dynamically linked position independent executable.

   ``pie``
      Position independent executable to make hacker safe.

.. code-block:: asm

   section .text
       mov  rdi, fmtstr ; first arg
       mov  rdi, msg    ; second arg
       # additional arguments
       call printf      ; fin to print out to the STDOUT_FILENO

.. note::

   C's printf function requires that a string is NULL-termination.
   C's write funciton does not requires NULL-termination.

   GDB requires the NULL termination for string!

   But Termination a string with 0 is not a requirement in assembly.

printf_numbers
^^^^^^^^^^^^^^

.. code-block:: asm

   section .data
       # db messages
       radius   dd  357             ; 4byte
       pi       dq  3.14            ; 8byte
       fmtall   db  "123456789%s, %d, %lf", 10, 0   ; 9+len_str+4+8+1+1= 23+len bytes

``printf``
   - ``mov rax 1``  : working as floating point involved flag.
   - printf is not syscall but function. so using parameters.
   - printf run with string and int makes kind of error when printing int.
   - square brackets reference the address is storing value.

