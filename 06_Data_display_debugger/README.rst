06. Data Display Debugger
=========================

Data Display Debbugger (DDD) is debugging tool with
graphical user interface for Linux install it now::

   ``sudo apt install ddd``

because we wil use it later in this chapter.

The Program we will write in this chpater has no output,
we will be invetigating the code execution and
register the content with DDD

Working with DDD
----------------

save the source file like move.asm_, and build as elf and run it.
expects not displaying anything.
type the following::

   ``ddd move``

.. _move.asm: src/move.asm

Unexpected behavior
^^^^^^^^^^^^^^^^^^^

.. code-block:: asm

   mov  rax, -1
   mov  eax, dword [dNum] ; cur rax = 0xffffffffffffffff

*unlike i expected, movs 4bytes data to ``eax``, also controls ``$rax`` either, as it was work to mov rax 8bytes data.*

.. important::

   - Move 4bytes value to 8-byte register, higher bits will be cleared.
   - **When move value to ``eax``, then upper bits of ``rax`` will cleared.**

register to .data in-memory
^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: asm

   mov qword [qNum2], rax   ; moves value from register to qNum2

``[qNum2]``
   Square brackets to tell the assembler that ``qNum2`` is an address in memory.

