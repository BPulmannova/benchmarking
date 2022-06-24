.globl babylonian
babylonian:
        sub     sp, sp, #48
        str     d0, [sp, 24]
        str     d1, [sp, 16]
        str     w0, [sp, 12]
        str     wzr, [sp, 44]
        b       .L2
.L3:
        ldr     d0, [sp, 16]
        ldr     d1, [sp, 24]
        fdiv    d1, d1, d0
        ldr     d0, [sp, 16]
        fadd    d1, d1, d0
        fmov    d0, 2.0e+0
        fdiv    d0, d1, d0
        str     d0, [sp, 16]
        ldr     w0, [sp, 44]
        add     w0, w0, 1
        str     w0, [sp, 44]
.L2:
        ldr     w1, [sp, 44]
        ldr     w0, [sp, 12]
        cmp     w1, w0
        blt     .L3
        ldr     d0, [sp, 16]
        add     sp, sp, 48
        ret
