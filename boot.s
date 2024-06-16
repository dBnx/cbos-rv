# RV32I
# CBOS - Made with HART in mind

.text
.global reset
reset:
        j _start
        
        # Fill vector table with NOPs 
        .rept 7
        nop
        .endr

halt_catch_fire:
        # pause
        nop
        j halt_catch_fire

_start:
        nop
        j main

.data
test_string: .string "Hello world!"
        
#.data
#text: .byte "Hello World" 
