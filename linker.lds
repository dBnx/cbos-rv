/*
https://sourceware.org/binutils/docs-2.23/ld/Simple-Example.html#Simple-Example
https://wiki.osdev.org/Linker_Scripts
*/

ENTRY(reset)
/* 
# linked to the beginning
STARTUP(boot.o) 
*/
/* 
OUTPUT_FORMAT(binary)
OUTPUT_FORMAT("binary")
*/
INPUT
(
    build/boot.o
    build/main.o
    build/stdlib.helper.o
    build/stdlib.io.o
/*
    stdlib.io.o
*/
)

MEMORY
{
    ROM (rx) : ORIGIN = 0, LENGTH = 64k
    RAM (wx) : org = 0x80000000, len = 8k
/*
    RAM (wx) : org = 0x80000000, len = 8M
*/
}

SECTIONS
{
 . = 0x00000000;
 . = ALIGN(4);
 .text : { *(.text) } > ROM
 . = 0x8000000;
 .data : { *(.data) } > ROM
 .bss : { *(.bss) } > RAM
 .heap : {} > RAM
}