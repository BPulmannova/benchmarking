.globl f
f:
        sub     sp, sp, #320
        mov     w1, 11519 ;#20 mil
        movk    w1, 0x131, lsl 16


.L2:            

        ldr     w0, [sp, 20]
        add     w0, w0, 49
        ldr     w0, [sp, 24]
        mov     w0, 47
        
        add     w0, w0, w0
        str     w0, [sp, 28]
        subs    w1, w1, 1
        bne     .L2

        mov     w0, 0
        add     sp, sp, 320
        ret
