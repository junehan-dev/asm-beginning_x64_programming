2. Binary Numbers, Hexadecimal Numbers and Registers
====================================================

*omits the content of B_H_Numbers, those i already know*

A Short Course on Registers
---------------------------

Register
   **Registers are storage location.**
   Used by CPU, to store data, instruction or memaddress.
   Much faster than accessing memory.

16 of General-Purpose Registers
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- Scratch registers(임의 사용 가능)

   1. ``rax``
      - SYSCALL시에 읽어야할 명령어를 저장
      - 함수 실행시 종료 값이 저장
   #. ``rcx``
      - 일반적인 용도이나, 일부 명령에서 카운터로 쓰여질 수 있다.
   #. ``rdx``
   #. ``rdi``
      -일반적인 용도이나, 함수 매개변수1 레지스터로 사용될 수 있다.
   #. ``rsi``
      -일반적인 용도이나, 함수 매개변수2 레지스터로 사용될 수 있다.
   #. ``r8 ~ r11``

- Preserved registers(사용 후 본래의 값으로 돌려놓아야 함)

   1. ``rbx``
   #. ``rbp``
         - Stack pointer
   #. ``rsp``
         - Stack base pointer
   #. ``r12 ~ r15``

Instruction Pointer Register(rip)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

RIP register
   The processor keeps track of the next instruction to be executed
   by storing the address of the next instruction in ``rip.``
   We can change it as like ``rbp`` and ``rsp`` , but..
   a safer way of changing value in ``rip`` is *by using ``jmp`` instructions.*

Flag Register(rflags)
^^^^^^^^^^^^^^^^^^^^^

========= ====== === ======================================
Name      Symbol Bit Content
========= ====== === ======================================
Carry     CF     0   Previous instruction had a carry!
Parity    PF     2   Last byte has even number of 1s!
Adjust    AF     4   BCD operations
Zero      ZF     6   Prev instrunction resulted a zero!
Sign      SF     8   Prev inst resulted in MSB eqult to 1!
Direction DF     10  String operation direction(inc or dec)
Overflow  OF     11  Prev insturction resulted overflow!
========= ====== === ======================================

There is another flag register called, ``MXCSR``
will explain later..

xmm and ymm Registers
^^^^^^^^^^^^^^^^^^^^^

xmm and ymm registers
   These registers are used for floating-point calculation
   and SIMD(single instruction, multiple data instruction).
