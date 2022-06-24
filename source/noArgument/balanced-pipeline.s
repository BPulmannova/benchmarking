.globl f
f:
        sub     sp, sp, #320
        mov     w1, 11519 ;#20 mil
        movk    w1, 0x131, lsl 16
        str     w1, [sp, 64]
        mov     w9, 0
        mov     w10, 0

        fmov    s0, 1.5
        fmov    s1, 2.5
        add     x11, sp, 16
        add     x12, sp, 20
        nop

.L2:
#        ldr     w9, [sp, 16]
#        add     w15, w15, 1
#        str     w10, [sp, 20]
#       ldr     w13, [sp, 32]

#        add     w14, w14, 1

        ldr     w9, [sp, 16]
        str     w9, [sp, 64]
        ldr     w9, [sp, 20]
        add     w9, w9, 1
        str     w9, [sp, 68]
#        
#        fmov    s1, 1.5
#        fmov    s2, 1.5
#        fmov    s3, 1.5
#        fmov    s4, 1.5
#        ldr     w9, [x11]
#        add     w13, w13, 1
#        fmov    s0, 2.5
#        add     w9, w9, 2     
#        ldr     w10, [x12]
        subs    w1, w1, 1
        bne     .L2
.L3:
 
        mov     w0, w9
        add     sp, sp, 320
        ret
