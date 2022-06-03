.globl f
f:
        sub     sp, sp, #400
        str     wzr, [sp, 12]
        mov     w1, 16960
        movk    w1, 0xf, lsl 16
.L2:
        ldr     w0, [sp, 272]
        add     w0, w0, 1
        str     w0, [sp, 272]
        ldr     w0, [sp, 208]
        add     w0, w0, 2
        str     w0, [sp, 208]
        ldr     w0, [sp, 144]
        add     w0, w0, 3
        str     w0, [sp, 144]
        ldr     w0, [sp, 80]
        add     w0, w0, 4
        str     w0, [sp, 80]
        ldr     w0, [sp, 16]
        add     w0, w0, 5
        str     w0, [sp, 16]
        subs    w1, w1, #1
        bne     .L2
        mov     w0, 0
        add     sp, sp, 400
        ret
