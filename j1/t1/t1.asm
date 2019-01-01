.include "m1280def.inc"

ldi r16, HIGH(RAMEND)
out sph, r16
ldi r16, LOW(RAMEND)
out spl, r16

ldi r16, 0xff
sts ddrj, r16

ldi r16, 0x01
here:
sts portj, r16
call delay
lsl r16
brne here
ldi r16, 0b10000000
l: sts portj, r16
call delay
lsr r16
brne l 
ldi r16, 0x01
rjmp here


delay:
ldi r17, 0x10
p3: ldi r18, 0xff
p2: ldi r19, 0xff
p1: dec r19
brne p1
dec r18
brne p2
dec r17
brne p3
ret
