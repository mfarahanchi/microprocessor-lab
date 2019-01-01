.org 0
.include "m1280def.inc"

ldi r16, HIGH(RAMEND)
sts sph, r16
ldi r16, LOW(RAMEND)
sts spl, r16

ldi r16, 0xff
out DDRF, r16 ;selctors
ldi r16, 0xff
sts DDRK, r16

ldi r20, 0 ;yekan
ldi r21, 0 ;dahgan
ldi r22, 0 ;sadgan
ldi r23, 0 ;hezargan


loop:
ldi r24, 15
looop:
ldi r16, 0x80
out PORTF, r16
ldi zh, high(2*as)
ldi zl, low(2*as)
add zl, r20
lpm r17, z
sts PORTK, r17
call delay1
ldi r16, 0x40
out PORTF, r16
ldi zh, high(2*as)
ldi zl, low(2*as)
add zl, r21
lpm r17, z
sts PORTK, r17
call delay1
ldi r16, 0x20
out PORTF, r16
ldi zh, high(2*as)
ldi zl, low(2*as)
add zl, r22
lpm r17, z
sts PORTK, r17
call delay1
ldi r16, 0x10
out PORTF, r16
ldi zh, high(2*as)
ldi zl, low(2*as)
add zl, r23
lpm r17, z
sts PORTK, r17
call delay1
dec r24
brne looop
inc r20
cpi r20, 10
breq incr21
rjmp loop

incr21: ldi r20, 0
inc r21
cpi r21, 10
breq incr22
rjmp loop

incr22: ldi r21, 0
inc r22
cpi r22, 10
breq incr23
rjmp loop

incr23:ldi r22,0
inc r23
cpi r23,10
breq incr24
rjmp loop

incr24:
ldi r20, 0 ;yekan
ldi r21, 0 ;dahgan
ldi r22, 0 ;sadgan
ldi r23, 0 ;hezargan
rjmp loop

delay1:
ldi r18, 0x20
l2: ldi r19, 0xff
l1: dec r19
brne l1
dec r18
brne l2
ret

.org 0x500
as: .db 0b11101011, 0b10001000, 0b10110011, 0b10111010, 0b11011000, 0b01111010, 0b01111011, 0b10101000, 0b11111011, 0b11111010  
