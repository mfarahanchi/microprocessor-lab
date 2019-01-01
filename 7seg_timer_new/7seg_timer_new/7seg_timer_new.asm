.include "m1280def.inc"

.org	0
		JMP BEGIN

.org	OC1Aaddr
		RJMP	interrupt_OC1

.org	OC0Aaddr
		RJMP	interrupt_OC0


BEGIN:

	LDI		R16,HIGH(RAMEND)
	STS		SPH,R16
	LDI		R16,LOW(RAMEND)
	STS		SPL,R16

	LDI		R16,0xFF
	STS		DDRK,R16
	OUT		DDRF,R16

	; INITALIZE TIMER 0
	LDI R16, 0x02
	STS TCCR0A, R16
	LDI R16, 0x05
	STS TCCR0B, R16
	LDI R16, 0x22
	STS OCR0A, R16
	LDI R16, 0x02
	STS TIMSK0, R16
	

	;INITIALIZE TIMER 1
;	LDI		R16,0x00
;	STS		TCCR1A,R16
;	LDI		R16,0x0D
;	STS		TCCR1B,R16
;	LDI		R16,0x2A
;	STS		OCR1AH,R16
;	LDI		R16,0x30
;	STS		OCR1AL,R16
;	LDI		R16,0x02
;	STS		TIMSK1,R16
	SEI

INIT:
	LDI		R25,0x01
	LDI 	R26,0x02
	LDI 	R27,0x03
	LDI 	R28,0x04
	LDI		R29,0x00


	
HERE :
	//CALL DELAY_2	
	/*
	MOV R17, R25
	CALL CONVERT
	//LDI R21,0x88
	LDI R17,0b10000000
	OUT		PORTF,R17
	STS		PORTK,R21
	//CALL	DELAY
	
	MOV R17, R26
	CALL CONVERT
	LDI R17,0b01000000
	OUT		PORTF,R17
	STS		PORTK,R21
	//CALL	DELAY

	MOV R17, R27
	CALL CONVERT
	LDI R17,0b00100000
	OUT		PORTF,R17
	STS		PORTK,R21
	//CALL	DELAY

	MOV R17, R28
	CALL CONVERT
	LDI R17,0b00010000
	OUT		PORTF,R17
	STS		PORTK,R21
	//CALL	DELAY

	
FIRST:
		CPI R29, 0
		BRLT HERE
		LDI	R29,0xFF
		//CALL DELAY_2
		INC R25
		CPI R25, 10
		BREQ SECOND
		RJMP HERE

SECOND:	
		LDI R25, 0x00
		INC R26
		CPI R26, 10
		BREQ THIRD
		RJMP HERE

THIRD : 
		LDI R26, 0x00
		INC R27
		CPI R27, 10
		BREQ FOURTH
		RJMP HERE

FOURTH:
		LDI R27, 0x00
		INC R28
		CPI R28, 10
		BRNE S1
		RJMP INIT
S1:		RJMP HERE

*/
			
RJMP HERE

interrupt_OC1:

	//LDI R25,0x05
	//LDI R21,0xD8
	//INC R25
	LDI R25,0x07 
	RETI

interrupt_OC0:

	FIRST_DIGIT:
		CPI R29, 1
		BRNE SECOND_DIGIT
		
		MOV R17, R25
		CALL CONVERT
		//LDI R21,0x88
		LDI R17,0b10000000
		OUT		PORTF,R17
		STS		PORTK,R21		

		LDI R29, 2
		RETI
	SECOND_DIGIT:
		CPI R29, 2
		BRNE THIRD_DIGIT

		MOV R17, R26
		CALL CONVERT
		LDI R17,0b01000000
		OUT		PORTF,R17
		STS		PORTK,R21

		LDI R29,3
		RETI
	THIRD_DIGIT:
		CPI R29, 3
		BRNE FOURTH_DIGIT

		MOV R17, R27
		CALL CONVERT
		LDI R17,0b00100000
		OUT		PORTF,R17
		STS		PORTK,R21

		LDI R29, 4
		RETI
	FOURTH_DIGIT:

		MOV R17, R28
		CALL CONVERT
		LDI R17,0b00010000
		OUT		PORTF,R17
		STS		PORTK,R21

		LDI R29, 1
		RETI

CONVERT:	
			CPI R17, 0
			BRNE	ONE
			LDI	R21,0xEB
			RET

ONE:		CPI R17, 1
			BRNE	TWO
			LDI	R21,0x88
			RET

TWO:		CPI R17, 2
			BRNE	THREE
			LDI	R21,0xB3
			RET

THREE:		CPI R17, 3
			BRNE	FOUR
			LDI	R21,0xBA
			RET

FOUR:		CPI R17, 4
			BRNE	FIVE
			LDI	R21,0xD8
			RET

FIVE:		CPI R17, 5
			BRNE	SIX
			LDI	R21,0x7A
			RET

SIX:		CPI R17, 6
			BRNE	SEVEN
			LDI	R21,0x7B
			RET

SEVEN:		CPI R17, 7
			BRNE	EIGHT
			LDI	R21,0xA8
			RET

EIGHT:		CPI R17, 8
			BRNE	NINE
			LDI	R21,0xFB
			RET

NINE:		CPI R17, 9
			LDI	R21,0xFA
RET
 	
DELAY:
		DEC R29
		LDI R18, 0x04
L2:		LDI R19, 0xFF
L1:		NOP
		DEC R19
		BRNE L1
		DEC R18
		BRNE L2
		RET

DELAY_2 :
		LDI R17, 0x01

L3_2:		LDI R18, 0x0F
L2_2:		LDI R19, 0xFF
L1_2:		NOP
			DEC R19
			BRNE L1_2
			DEC R18
			BRNE L2_2
			DEC R17
			BRNE L3_2
			RET



	
