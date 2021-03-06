.include "m1280def.inc" 

LDI    R16, HIGH(RAMEND) 
OUT    SPH, R16 
LDI    R16, LOW(RAMEND) 
OUT SPL, R16 

START:    LDI R16, 0x01 
BEGIN:    STS PORTJ, R16 
        CALL DELAY 
        LSL R16 
        BRNE BEGIN 
        RJMP START  

DELAY: 
        IN R17, PINC 

L3:        LDI R18, 0xFF 
L2:        LDI R19, 0xFF 
L1:        NOP 
        DEC R19 
        BRNE L1 
        DEC R18 
        BRNE L2 
        DEC R17 
        BRNE L3 
        RET 
         