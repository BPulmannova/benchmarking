.globl attribution
attribution:
    sub     sp, sp, #32
    str     w0, [sp, 12]
    ldr     w1, [sp, 12]
    str     wzr, [sp, 24]

.L1:
    ldr     w0, [sp, 24]
    add     w0, w0, 1
    add     w0, w0, 1
    add     w0, w0, 1
    str     w0, [sp, 24]
    and     w0, w0, 1
    cmp     w0, 0
    bne     .L2

    ldr     w0, [sp, 24]
    add     w0, w0, 1
    add     w0, w0, 1
    str     w0, [sp, 24]
.L2:
    ldr     w0, [sp, 24]
    add     w0, w0, 1
    add     w0, w0, 1
    str     w0, [sp, 24]
    subs    w1, w1, 1
    bne     .L2

    ldr     w0, [sp, 24]
    add    sp, sp, 32
    ret
