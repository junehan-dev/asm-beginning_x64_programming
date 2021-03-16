07. Jumping and Looping
=======================

jump.asm
--------

jump.asm_
   A program ``cmp rax rbx`` storing value and ``jmp greater`` to special case, and ``printf`` data section format data (to ``rdi``)

``cmp``
   Is called a conditional instruction.
   compares two operands,
      - one can also be a memory operand.
      - second operand can be an immediate value.

   The size of operands must be the same.
   ``cmp`` instruction will set or clear flags in the flag register.
   flags are located in the ``rflags`` | ``eflags`` register taht can be set to 1 or cleared to 0, depending on a number of condition.

.. _jump.asm: src/jump.asm

jumploop.asm
------------

jumploop.asm_
   A Program adds all the numbers from 0 to the value in ``number`` .
   Use ``rbx`` as counter and ``rax`` to as sum accumulator.

.. _jumploop.asm: src/jumploop.asm

betterloop.asm
--------------

betterloop.asm_
   A program works same with before, but better version for register usage.
   Uses ``rcx`` as a *decreasing loop counter.*
   With every pass through the loop, rcx is decreased automatically,
   and as long as ``rcx`` is not equal to 0, the loop is executed again.

.. code-block:: bash

   time .src/jumploop.elf
   time .src/betterloop.elf 

Interesting experiment is to put 1000000000 in ``number`` and rebuild and rund as upper bash command.

.. note::

   Note that ``betterloop`` is slower than jumploop.
   Using ``loop`` instruction is convenient,
   but comes at a price in terms of execution performance.

.. _betterloop.asm: src/betterloop.asm
