.globl sum
sum:
        sub     sp, sp, #32
        str     w0, [sp, 12]
        ldr     w0, [sp, 12]
        and     w0, w0, 1
        cmp     w0, 0
        bne     .L2
        ldr     w0, [sp, 12]
        str     w0, [sp, 28]
        b       .L3
.L2:
        str     wzr, [sp, 28]
.L3:
        mov     w0, 1
        str     w0, [sp, 24]
.L8:
        ldr     w1, [sp, 24]
        ldr     w0, [sp, 12]
        cmp     w1, w0
        bgt     .L4
        str     wzr, [sp, 20]
        ldr     w0, [sp, 24]
        sub     w0, w0, #1
        str     w0, [sp, 16]
.L7:
        ldr     w1, [sp, 16]
        ldr     w0, [sp, 24]
        cmp     w1, w0
        bgt     .L5
        ldr     w0, [sp, 24]
        cmp     w0, 0
        and     w0, w0, 1
        csneg   w0, w0, w0, ge
        cmp     w0, 1
        bne     .L6
        ldr     w1, [sp, 20]
        ldr     w0, [sp, 16]
        add     w0, w1, w0
        str     w0, [sp, 20]
.L6:
        ldr     w0, [sp, 16]
        add     w0, w0, 1
        str     w0, [sp, 16]
        b       .L7
.L5:
        ldr     w1, [sp, 28]
        ldr     w0, [sp, 20]
        add     w0, w1, w0
        str     w0, [sp, 28]
        ldr     w0, [sp, 24]
        add     w0, w0, 1
        str     w0, [sp, 24]
        b       .L8
.L4:
        ldr     w0, [sp, 28]
        add     sp, sp, 32
        ret
