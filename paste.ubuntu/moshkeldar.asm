.include "m1280def.inc" 

.org    0 
    RJMP     BEGIN 

.org OC1Aaddr 
        RJMP INTERRUPT 



BEGIN:    LDI R16,HIGH(RAMEND) 
        OUT SPH,R16     
        LDI R16,LOW(RAMEND) 
        OUT SPL,R16 

        LDI    R16, 0x13 
        STS DDRJ, R16 

        ;INITIALIZE TIMER  

        LDI R16,0x00 
        STS TCCR1A,R16 
     
        LDI R16,0x0D 
        STS TCCR1B,R16 
     
        LDI R16,0x2A 
        STS OCR1AH,R16 

        LDI R16,0x30 
        STS OCR1AL,R16 

        LDI R16,0x02 
        STS TIMSK1,R16 
         
        SEI 


        LDI R17,0x01 
L1:        STS PORTJ,R17 
        RJMP L1 



INTERRUPT:     
        LSL R17 
        BREQ L2 
        RETI 
L2:        LDI     R17,0x01 
        RETI 
         