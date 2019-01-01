.include "m1280def.inc"
.org 0000
rjmp begin

.org OC0Aaddr
rjmp change_select

.org OC1Aaddr
rjmp up_one

.org 500
begin:
ldi r16,high(RAMEND)
OUT SPH,R16
LDI R16,LOW(RAMEND)
OUT SPL,R16 

ldi r16, 0xff
out DDRF, r16
sts DDRK, r16

ldi r16, 0x02
out TCCR0A, r16
ldi r16, 0x05
out TCCR0B, r16
ldi r16, 0x13
out OCR0A, r16

ldi r16, 0x0d
sts TCCR1B, r16
ldi r16, 0x29
sts OCR1AH, r16
ldi r16, 0xff
sts OCR1AL, r16

ldi r16, 0x02
sts TIMSK0, r16
sts TIMSK1, r16

ldi r17, 0 ;yekan
ldi r18, 0 ;dahgan
ldi r19, 0 ;sadgan
ldi r20, 0 ;hezargan

ldi r21, 0x80
sei

loop: rjmp loop


change_select:
out PORTF, r21
ldi zh, high(2*as)
ldi zl, low(2*as)
cpi r21, 0x80
breq d_yekan
cpi r21, 0x40
breq d_dahgan
cpi r21, 0x20
breq d_sadgan
cpi r21, 0x10
breq d_hezargan
back:
lpm r22, z
sts PORTK, r22
reti

d_yekan:
add zl, r17
ldi r21, 0x40
rjmp back

d_dahgan:
add zl, r18
ldi r21, 0x20
rjmp back

d_sadgan:
add zl, r19
ldi r21, 0x10
rjmp back

d_hezargan:
add zl, r20
ldi r21, 0x80
rjmp back

up_one:
inc r17
cpi r17, 10
breq incr18
backup: reti

incr18: ldi r17, 0
inc r18
cpi r18, 10
breq incr19
rjmp backup

incr19: ldi r18, 0
inc r19
cpi r19, 10
breq incr20
rjmp backup

incr20:
ldi r17, 0 ;yekan
ldi r18, 0 ;dahgan
ldi r19, 0 ;sadgan
ldi r20, 0 ;hezargan
rjmp backup

.org 0x1000
as: .db 0b11101011, 0b10001000, 0b10110011, 0b10111010, 0b11011000, 0b01111010, 0b01111011, 0b10101000, 0b11111011, 0b11111010  
