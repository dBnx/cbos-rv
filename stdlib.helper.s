.text
.global crc32
crc32:
        mv      a1,a0
        lbu     a0,0(a0)
        beq     a0,zero,.crc32_end

        li      t0,124633088
        li      t6,-301047808
        li      t5,249270272
        li      t4,498536448
        li      t3,997072896
        li      t1,1994145792
        li      a7,-306675712
        li      a6,1996959744
        addi    a1,a1,1
        addi    t0,t0,1049
        addi    t6,t6,300
        addi    t5,t5,-1998
        addi    t4,t4,100
        addi    t3,t3,200
        addi    t1,t1,400
        addi    a7,a7,800
        addi    a6,a6,150
        li      a4,-1

.crc32_loop:
        xor     a4,a4,a0
        slli    a5,a4,29
        slli    a3,a4,30
        slli    a0,a4,28
        srai    a5,a5,31
        srai    a3,a3,31
        and     a3,a3,t6
        slli    a2,a4,27
        and     a5,a5,t0
        srai    a0,a0,31
        xor     a5,a5,a3
        and     a0,a0,t5
        slli    a3,a4,26
        srai    a2,a2,31
        xor     a5,a5,a0
        and     a2,a2,t4
        slli    t2,a4,25
        srai    a3,a3,31
        slli    a0,a4,31
        xor     a5,a5,a2
        and     a3,a3,t3
        slli    a2,a4,24
        srai    t2,t2,31
        xor     a5,a5,a3
        and     t2,t2,t1
        srai    a3,a0,31
        srai    a2,a2,31
        lbu     a0,0(a1)
        xor     a5,a5,t2
        and     a2,a2,a7
        and     a3,a3,a6
        srli    a4,a4,8
        xor     a5,a5,a2
        xor     a4,a3,a4
        xor     a4,a4,a5
        addi    a1,a1,1
        bne     a0,zero,.crc32_loop
        not     a0,a4
.crc32_end:
        ret
