3. Program Analaysis with a Debugger: GDB
=========================================

One important remark about GDB::

   *``rip`` stores instruction address, not started.*
   To properly use GDB,
   **You must insert a function prologue and a function epilogue in your code.**

function prologue and epilogue::

   will discuss them when we talk about stack frames.

Start Debugging
---------------

ATNT syntax
^^^^^^^^^^^

.. code-block:: bash

   gdb <executable_file_name>
   $(gdb) disassemble main # defaults to att syntax
   0x0000000000401110 <+0>:	mov    eax,0x1
   0x0000000000401115 <+5>:	mov    edi,0x1
   0x000000000040111a <+10>:	movabs rsi,0x404028
   0x0000000000401124 <+20>:	mov    edx,0xc
   0x0000000000401129 <+25>:	syscall 
   0x000000000040112b <+27>:	mov    eax,0x3c
   0x0000000000401130 <+32>:	mov    edi,0x0
   0x0000000000401135 <+37>:	syscall 
   0x0000000000401137 <+39>:	nop    WORD PTR [rax+rax*1+0x0]

Intel syntax
^^^^^^^^^^^^

.. code-block:: bash

   $(gdb) set dissassembly-flavor intel # disassemble in intel syntax
   $(gdb) disassemble main
   0x0000000000401110 <+0>:	mov    $0x1,%eax
   0x0000000000401115 <+5>:	mov    $0x1,%edi
   0x000000000040111a <+10>:	movabs $0x404028,%rsi
   0x0000000000401124 <+20>:	mov    $0xc,%edx
   0x0000000000401129 <+25>:	syscall 
   0x000000000040112b <+27>:	mov    $0x3c,%eax
   0x0000000000401130 <+32>:	mov    $0x0,%edi
   0x0000000000401135 <+37>:	syscall 
   0x0000000000401137 <+39>:	nopw   0x0(%rax,%rax,1)

break_debug
^^^^^^^^^^^

.. code-block:: bash

   $(gdb) i r # shortcut ``info registers``
   rax            0x401110            4198672
   rbx            0x401140            4198720
   rcx            0x401140            4198720
   rdx            0x7fffffffddd8      140737488346584
   rsi            0x7fffffffddc8      140737488346568
   rdi            0x1                 1
   rbp            0x0                 0x0
   rsp            0x7fffffffdcd8      0x7fffffffdcd8
   r8             0x0                 0
   r9             0x7ffff7fe0d50      140737354009936
   r10            0x3                 3
   r11            0x2                 2
   r12            0x401020            4198432
   r13            0x7fffffffddc0      140737488346560
   r14            0x0                 0
   r15            0x0                 0
   rip            0x401110            0x401110 <main>
   eflags         0x246               [ PF ZF IF ]
   cs             0x33                51
   ss             0x2b                43
   ds             0x0                 0
   es             0x0                 0
   fs             0x0                 0
   $(gdb) x/s 0x404028
   0x404028 <msg>: "hello, world"
   $(gdb) x/6x 0x401110
   0x401110 <main>: 0xb8 0x01 0x00 0x00 0x00 0xbf# mov eax 1 and mov edi at last 1 byte

GDB commands
^^^^^^^^^^^^

- ``disable breakpoint <number>``
- ``enable breakpoint <number>``
- ``delete breakpoint <number>``
- ``continue``: countinue execution till next breakpoint
- ``step``:     step into cur line, jump into the called function.
- ``next``:     step over cur line, stop at next line
- ``print``:    print the value of a variable, register and so on.

   - ``print $rax``: print value of register in decimal
   - ``p/t $rax``: print in bin
   - ``p/x $rax``: print in hex
