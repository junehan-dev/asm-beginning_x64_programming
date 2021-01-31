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
