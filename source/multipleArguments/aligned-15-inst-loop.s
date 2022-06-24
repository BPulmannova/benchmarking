.globl fibonacci
fibonacci:
        sub     sp, sp, #32
        str     w0, [sp, 12]
        str     wzr, [sp, 28]
        mov     w0, 1
        str     w0, [sp, 24]
        str     wzr, [sp, 20]
.L3:
        ldr     w1, [sp, 20]
        ldr     w0, [sp, 12]
        cmp     w1, w0
        bge     .L2
        ldr     w0, [sp, 28]
        str     w0, [sp, 16]
        ldr     w1, [sp, 24]

        add     w0, w1, w0
        str     w0, [sp, 28]
        ldr     w0, [sp, 16]
        str     w0, [sp, 24]

        ldr     w0, [sp, 20]
        add     w0, w0, 1
        str     w0, [sp, 20]
        b       .L3
.L2:
        ldr     w0, [sp, 28]
        add     sp, sp, 32
        ret
