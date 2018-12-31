.INCLUDE "m1280def.inc" 

LDI R16, HIGH(RAMEND) 
LDI R17, LOW(RAMEND) 

OUT SPH, R16 
OUT SPL, R17 

LDI R16, 0xFF 
STS DDRK, R16 
out DDRF, R16 
CLR R20 
CLR R21 
CLR R22 
CLR R23 

MAIN_LOOP: 

    INC R20 
    CPI R20, 0x0A 
    brne CALL_SHOW 
     
    CLR R20 
    INC R21 

    CPI R21, 0x0A 
    brne CALL_SHOW 
     
    CLR R21 
    INC R22 

    CPI R22, 0x0A 
    brne CALL_SHOW 

    CLR R22 
    INC R23 

    CPI R23, 0x0A 
    brne CALL_SHOW 

    CLR R23 

    CALL_SHOW:  
    LDI R28, 0x80 
    CALL_SHOW_LOOP:  
        call SHOW 
        DEC R28 
    brne CALL_SHOW_LOOP 

    RJMP MAIN_LOOP 


SHOW: 
    MOV R16, R20 
    LDI R17, 0b10000000 
    call PUT_NUMBER 

    MOV R16, R21 
    LDI R17, 0b01000000 
    call PUT_NUMBER 

    MOV R16, R22 
    LDI R17, 0b00100000 
    call PUT_NUMBER 

    MOV R16, R23 
    LDI R17, 0b00010000 
    call PUT_NUMBER 

    ret 



;R16: value, R17: Segment Num 
PUT_NUMBER: 
    LDI ZL, LOW(data << 1) 
    LDI ZH, HIGH(data << 1) 
     
    LSL R16 

    ADD ZL, R16 
    LPM R18, Z 

    OUT PORTF, R17 

    STS PORTK, R18 
     
    call M_DELAY 

    RET 

M_DELAY: 
    LDI R24, 0x10 
ML1: LDI R25, 0xFF 
ML2: DEC R25 
    BRNE ML2 

    DEC R24 
    BRNE ML1 

    RET 

.ORG $500 
data:.dw 0b0000000011101011 
    .dw 0b0000000010001000 
    .dw 0b0000000010110011 
    .dw 0b0000000010111010 
    .dw 0b0000000011011000 
    .dw 0b0000000001111010 
    .dw 0b0000000001111011 
    .dw 0b0000000010101000 
    .dw 0b0000000011111011 
    .dw 0b0000000011111010 