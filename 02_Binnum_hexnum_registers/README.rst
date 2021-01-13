2. Binary Numbers, Hexadecimal Numbers and Registers
====================================================

*omits the content of B_H_Numbers, those i aldy know*

A Short Course on Registers
---------------------------

Register
   **Registers are storage location.**
   Used by CPU, to store data, instruction or memaddress.
   Much faster than accessing memory.

16 of General-Purpose Registers
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Content of those registers::

   - ``rax~rdx``
   - ``rsi``, ``rdi``
   - ``rbp`` , ``rsp``
   - ``r8 ~ r15``

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
