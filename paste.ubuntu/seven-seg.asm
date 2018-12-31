.include "m1280def.inc" 

    LDI     R16, HIGH(RAMEND) 
    STS        SPH, R16 
    LDI     R16, LOW(RAMEND) 
    STS        SPL, R16 


PORTINIT: 
    LDI        R16, 0xFF 
    STS         DDRK, R16 
    OUT     DDRF, R16  


START: 
    LDI        R16, 0x88 
    STS     PORTK, R16 
    LDI     R16, 0B0011111 
    OUT     PORTF, R16 
    CALL    DELAY 

    LDI        R16, 0xBA 
    STS     PORTK, R16 
    LDI     R16, 0B00100000 
    OUT     PORTF, R16 
    CALL     DELAY 

    LDI        R16, 0xFA 
    STS     PORTK, R16 
    LDI     R16, 0B01000000 
    OUT     PORTF, R16 
    CALL     DELAY 
     
    LDI        R16, 0xA8 
    STS     PORTK, R16 
    LDI     R16, 0B10000000 
    OUT     PORTF, R16 
    CALL     DELAY 
     

RETT: RJMP START 

DELAY: 
    LDI     R17, 0xFF 
    L1:     NOP 
            DEC R17  
            BRNE L1 
            RET 