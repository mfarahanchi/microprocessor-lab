
;CodeVisionAVR C Compiler V2.05.3 Standard
;(C) Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega1280
;Program type             : Application
;Clock frequency          : 11.059200 MHz
;Memory model             : Small
;Optimize for             : Size
;(s)printf features       : int, width
;(s)scanf features        : int, width
;External RAM size        : 0
;Data Stack size          : 2048 byte(s)
;Heap size                : 0 byte(s)
;Promote 'char' to 'int'  : Yes
;'char' is unsigned       : Yes
;8 bit enums              : Yes
;Global 'const' stored in FLASH     : No
;Enhanced function parameter passing: Yes
;Enhanced core instructions         : On
;Smart register allocation          : On
;Automatic register allocation      : On

	#pragma AVRPART ADMIN PART_NAME ATmega1280
	#pragma AVRPART MEMORY PROG_FLASH 131072
	#pragma AVRPART MEMORY EEPROM 4096
	#pragma AVRPART MEMORY INT_SRAM SIZE 8703
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x200

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU RAMPZ=0x3B
	.EQU EIND=0x3C
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU XMCRA=0x74
	.EQU XMCRB=0x75
	.EQU GPIOR0=0x1E

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0200
	.EQU __SRAM_END=0x21FF
	.EQU __DSTACK_SIZE=0x0800
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _a=R4
	.DEF _c=R5
	.DEF __lcd_x=R3
	.DEF __lcd_y=R8
	.DEF __lcd_maxx=R7

;GPIOR0 INITIALIZATION VALUE
	.EQU __GPIOR0_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G101:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G101:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x32:
	.DB  0x0,0x0
_0x2000003:
	.DB  0x80,0xC0
_0x2040060:
	.DB  0x1
_0x2040000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  0x05
	.DW  _0x32*2

	.DW  0x02
	.DW  __base_y_G100
	.DW  _0x2000003*2

	.DW  0x01
	.DW  __seed_G102
	.DW  _0x2040060*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30
	STS  XMCRA,R30
	STS  XMCRB,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	WDR
	IN   R26,MCUSR
	CBR  R26,8
	OUT  MCUSR,R26
	STS  WDTCSR,R31
	STS  WDTCSR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

	OUT  RAMPZ,R24

;GPIOR0 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0xA00

	.CSEG
;/*****************************************************
;This program was produced by the
;CodeWizardAVR V2.05.3 Standard
;Automatic Program Generator
;© Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 5/26/2018
;Author  : admin
;Company : IUST
;Comments:
;
;
;Chip type               : ATmega1280
;Program type            : Application
;AVR Core Clock frequency: 11.059200 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 2048
;*****************************************************/
;
;#include <mega1280.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif
;#include <delay.h>
;// Alphanumeric LCD functions
;#include <alcd.h>
;
;// Standard Input/Output functions
;#include <stdio.h>
;
;#include <stdlib.h>
;
;// Declare your global variables here
;unsigned char a;
;int c = 0;
;void main(void)
; 0000 0026 {

	.CSEG
_main:
; 0000 0027 // Declare your local variables here
; 0000 0028 
; 0000 0029 // Crystal Oscillator division factor: 1
; 0000 002A #pragma optsize-
; 0000 002B CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
; 0000 002C CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
; 0000 002D #ifdef _OPTIMIZE_SIZE_
; 0000 002E #pragma optsize+
; 0000 002F #endif
; 0000 0030 
; 0000 0031 // Input/Output Ports initialization
; 0000 0032 // Port A initialization
; 0000 0033 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0034 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0035 PORTA=0x00;
	OUT  0x2,R30
; 0000 0036 DDRA=0x00;
	OUT  0x1,R30
; 0000 0037 
; 0000 0038 // Port B initialization
; 0000 0039 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 003A // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 003B PORTB=0x00;
	OUT  0x5,R30
; 0000 003C DDRB=0x00;
	OUT  0x4,R30
; 0000 003D 
; 0000 003E // Port C initialization
; 0000 003F // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0040 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0041 PORTC=0x00;
	OUT  0x8,R30
; 0000 0042 DDRC=0x00;
	OUT  0x7,R30
; 0000 0043 
; 0000 0044 // Port D initialization
; 0000 0045 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0046 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0047 PORTD=0x00;
	OUT  0xB,R30
; 0000 0048 DDRD=0x00;
	OUT  0xA,R30
; 0000 0049 
; 0000 004A // Port E initialization
; 0000 004B // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 004C // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 004D PORTE=0x00;
	OUT  0xE,R30
; 0000 004E DDRE=0x00;
	OUT  0xD,R30
; 0000 004F 
; 0000 0050 // Port F initialization
; 0000 0051 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0052 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0053 PORTF=0x00;
	OUT  0x11,R30
; 0000 0054 DDRF=0x00;
	OUT  0x10,R30
; 0000 0055 
; 0000 0056 // Port G initialization
; 0000 0057 // Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0058 // State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0059 PORTG=0x00;
	OUT  0x14,R30
; 0000 005A DDRG=0x00;
	OUT  0x13,R30
; 0000 005B 
; 0000 005C // Port H initialization
; 0000 005D // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 005E // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 005F PORTH=0x00;
	STS  258,R30
; 0000 0060 DDRH=0x00;
	STS  257,R30
; 0000 0061 
; 0000 0062 // Port J initialization
; 0000 0063 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0064 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0065 PORTJ=0x00;
	STS  261,R30
; 0000 0066 DDRJ=0x00;
	STS  260,R30
; 0000 0067 
; 0000 0068 // Port K initialization
; 0000 0069 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 006A // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 006B PORTK=0x00;
	STS  264,R30
; 0000 006C DDRK=0x00;
	STS  263,R30
; 0000 006D 
; 0000 006E // Port L initialization
; 0000 006F // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0070 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0071 PORTL=0x00;
	STS  267,R30
; 0000 0072 DDRL=0x00;
	STS  266,R30
; 0000 0073 
; 0000 0074 // USART0 initialization
; 0000 0075 // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 0076 // USART0 Receiver: On
; 0000 0077 // USART0 Transmitter: Off
; 0000 0078 // USART0 Mode: Sync. Slave UCPOL=0
; 0000 0079 UCSR0A=0x00;
	STS  192,R30
; 0000 007A UCSR0B=0x10;
	LDI  R30,LOW(16)
	STS  193,R30
; 0000 007B UCSR0C=0x46;
	LDI  R30,LOW(70)
	STS  194,R30
; 0000 007C // Alphanumeric LCD initialization
; 0000 007D // Connections are specified in the
; 0000 007E // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
; 0000 007F // RS - PORTA Bit 0
; 0000 0080 // RD - PORTA Bit 1
; 0000 0081 // EN - PORTA Bit 2
; 0000 0082 // D4 - PORTA Bit 4
; 0000 0083 // D5 - PORTA Bit 5
; 0000 0084 // D6 - PORTA Bit 6
; 0000 0085 // D7 - PORTA Bit 7
; 0000 0086 // Characters/line: 16
; 0000 0087 lcd_init(16);
	LDI  R26,LOW(16)
	RCALL _lcd_init
; 0000 0088 
; 0000 0089 while (1)
_0x3:
; 0000 008A       {
; 0000 008B       // Place your code here
; 0000 008C       a = getchar();
	CALL _getchar
	MOV  R4,R30
; 0000 008D       if( c < 2 ){
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CP   R5,R30
	CPC  R6,R31
	BRLT PC+3
	JMP _0x6
; 0000 008E       switch(a){
	MOV  R30,R4
	LDI  R31,0
; 0000 008F                  case 28: lcd_putchar('a');break;
	CPI  R30,LOW(0x1C)
	LDI  R26,HIGH(0x1C)
	CPC  R31,R26
	BRNE _0xA
	LDI  R26,LOW(97)
	RJMP _0x31
; 0000 0090                  case 27: lcd_putchar('s');break;
_0xA:
	CPI  R30,LOW(0x1B)
	LDI  R26,HIGH(0x1B)
	CPC  R31,R26
	BRNE _0xB
	LDI  R26,LOW(115)
	RJMP _0x31
; 0000 0091                  case 35: lcd_putchar('d');break;
_0xB:
	CPI  R30,LOW(0x23)
	LDI  R26,HIGH(0x23)
	CPC  R31,R26
	BRNE _0xC
	LDI  R26,LOW(100)
	RJMP _0x31
; 0000 0092                  case 43: lcd_putchar('f');break;
_0xC:
	CPI  R30,LOW(0x2B)
	LDI  R26,HIGH(0x2B)
	CPC  R31,R26
	BRNE _0xD
	LDI  R26,LOW(102)
	RJMP _0x31
; 0000 0093                  case 52: lcd_putchar('g');break;
_0xD:
	CPI  R30,LOW(0x34)
	LDI  R26,HIGH(0x34)
	CPC  R31,R26
	BRNE _0xE
	LDI  R26,LOW(103)
	RJMP _0x31
; 0000 0094                  case 51: lcd_putchar('h');break;
_0xE:
	CPI  R30,LOW(0x33)
	LDI  R26,HIGH(0x33)
	CPC  R31,R26
	BRNE _0xF
	LDI  R26,LOW(104)
	RJMP _0x31
; 0000 0095                  case 59: lcd_putchar('j');break;
_0xF:
	CPI  R30,LOW(0x3B)
	LDI  R26,HIGH(0x3B)
	CPC  R31,R26
	BRNE _0x10
	LDI  R26,LOW(106)
	RJMP _0x31
; 0000 0096                  case 66: lcd_putchar('k');break;
_0x10:
	CPI  R30,LOW(0x42)
	LDI  R26,HIGH(0x42)
	CPC  R31,R26
	BRNE _0x11
	LDI  R26,LOW(107)
	RJMP _0x31
; 0000 0097                  case 75: lcd_putchar('l');break;
_0x11:
	CPI  R30,LOW(0x4B)
	LDI  R26,HIGH(0x4B)
	CPC  R31,R26
	BRNE _0x12
	LDI  R26,LOW(108)
	RJMP _0x31
; 0000 0098                  case 26: lcd_putchar('z');break;
_0x12:
	CPI  R30,LOW(0x1A)
	LDI  R26,HIGH(0x1A)
	CPC  R31,R26
	BRNE _0x13
	LDI  R26,LOW(122)
	RJMP _0x31
; 0000 0099                  case 34: lcd_putchar('x');break;
_0x13:
	CPI  R30,LOW(0x22)
	LDI  R26,HIGH(0x22)
	CPC  R31,R26
	BRNE _0x14
	LDI  R26,LOW(120)
	RJMP _0x31
; 0000 009A                  case 33: lcd_putchar('c');break;
_0x14:
	CPI  R30,LOW(0x21)
	LDI  R26,HIGH(0x21)
	CPC  R31,R26
	BRNE _0x15
	LDI  R26,LOW(99)
	RJMP _0x31
; 0000 009B                  case 42: lcd_putchar('v');break;
_0x15:
	CPI  R30,LOW(0x2A)
	LDI  R26,HIGH(0x2A)
	CPC  R31,R26
	BRNE _0x16
	LDI  R26,LOW(118)
	RJMP _0x31
; 0000 009C                  case 50: lcd_putchar('b');break;
_0x16:
	CPI  R30,LOW(0x32)
	LDI  R26,HIGH(0x32)
	CPC  R31,R26
	BRNE _0x17
	LDI  R26,LOW(98)
	RJMP _0x31
; 0000 009D                  case 49: lcd_putchar('n');break;
_0x17:
	CPI  R30,LOW(0x31)
	LDI  R26,HIGH(0x31)
	CPC  R31,R26
	BRNE _0x18
	LDI  R26,LOW(110)
	RJMP _0x31
; 0000 009E                  case 58: lcd_putchar('m');break;
_0x18:
	CPI  R30,LOW(0x3A)
	LDI  R26,HIGH(0x3A)
	CPC  R31,R26
	BRNE _0x19
	LDI  R26,LOW(109)
	RJMP _0x31
; 0000 009F                  case 21: lcd_putchar('q');break;
_0x19:
	CPI  R30,LOW(0x15)
	LDI  R26,HIGH(0x15)
	CPC  R31,R26
	BRNE _0x1A
	LDI  R26,LOW(113)
	RJMP _0x31
; 0000 00A0                  case 36: lcd_putchar('e');break;
_0x1A:
	CPI  R30,LOW(0x24)
	LDI  R26,HIGH(0x24)
	CPC  R31,R26
	BRNE _0x1B
	LDI  R26,LOW(101)
	RJMP _0x31
; 0000 00A1                  case 45: lcd_putchar('r');break;
_0x1B:
	CPI  R30,LOW(0x2D)
	LDI  R26,HIGH(0x2D)
	CPC  R31,R26
	BRNE _0x1C
	LDI  R26,LOW(114)
	RJMP _0x31
; 0000 00A2                  case 44: lcd_putchar('t');break;
_0x1C:
	CPI  R30,LOW(0x2C)
	LDI  R26,HIGH(0x2C)
	CPC  R31,R26
	BRNE _0x1D
	LDI  R26,LOW(116)
	RJMP _0x31
; 0000 00A3                  case 53: lcd_putchar('y');break;
_0x1D:
	CPI  R30,LOW(0x35)
	LDI  R26,HIGH(0x35)
	CPC  R31,R26
	BRNE _0x1E
	LDI  R26,LOW(121)
	RJMP _0x31
; 0000 00A4                  case 60: lcd_putchar('u');break;
_0x1E:
	CPI  R30,LOW(0x3C)
	LDI  R26,HIGH(0x3C)
	CPC  R31,R26
	BRNE _0x1F
	LDI  R26,LOW(117)
	RJMP _0x31
; 0000 00A5                  case 67: lcd_putchar('i');break;
_0x1F:
	CPI  R30,LOW(0x43)
	LDI  R26,HIGH(0x43)
	CPC  R31,R26
	BRNE _0x20
	LDI  R26,LOW(105)
	RJMP _0x31
; 0000 00A6                  case 68: lcd_putchar('o');break;
_0x20:
	CPI  R30,LOW(0x44)
	LDI  R26,HIGH(0x44)
	CPC  R31,R26
	BRNE _0x21
	LDI  R26,LOW(111)
	RJMP _0x31
; 0000 00A7                  case 77: lcd_putchar('p');break;
_0x21:
	CPI  R30,LOW(0x4D)
	LDI  R26,HIGH(0x4D)
	CPC  R31,R26
	BRNE _0x22
	LDI  R26,LOW(112)
	RJMP _0x31
; 0000 00A8                  case 29: lcd_putchar('w');break;
_0x22:
	CPI  R30,LOW(0x1D)
	LDI  R26,HIGH(0x1D)
	CPC  R31,R26
	BRNE _0x23
	LDI  R26,LOW(119)
	RJMP _0x31
; 0000 00A9                  case 22: lcd_putchar('1');break;
_0x23:
	CPI  R30,LOW(0x16)
	LDI  R26,HIGH(0x16)
	CPC  R31,R26
	BRNE _0x24
	LDI  R26,LOW(49)
	RJMP _0x31
; 0000 00AA                  case 30: lcd_putchar('2');break;
_0x24:
	CPI  R30,LOW(0x1E)
	LDI  R26,HIGH(0x1E)
	CPC  R31,R26
	BRNE _0x25
	LDI  R26,LOW(50)
	RJMP _0x31
; 0000 00AB                  case 38: lcd_putchar('3');break;
_0x25:
	CPI  R30,LOW(0x26)
	LDI  R26,HIGH(0x26)
	CPC  R31,R26
	BRNE _0x26
	LDI  R26,LOW(51)
	RJMP _0x31
; 0000 00AC                  case 0x25: lcd_putchar('4');break;
_0x26:
	CPI  R30,LOW(0x25)
	LDI  R26,HIGH(0x25)
	CPC  R31,R26
	BRNE _0x27
	LDI  R26,LOW(52)
	RJMP _0x31
; 0000 00AD                  case 0x2e: lcd_putchar('5');break;
_0x27:
	CPI  R30,LOW(0x2E)
	LDI  R26,HIGH(0x2E)
	CPC  R31,R26
	BRNE _0x28
	LDI  R26,LOW(53)
	RJMP _0x31
; 0000 00AE                  case 0x36: lcd_putchar('6');break;
_0x28:
	CPI  R30,LOW(0x36)
	LDI  R26,HIGH(0x36)
	CPC  R31,R26
	BRNE _0x29
	LDI  R26,LOW(54)
	RJMP _0x31
; 0000 00AF                  case 0x3d: lcd_putchar('7');break;
_0x29:
	CPI  R30,LOW(0x3D)
	LDI  R26,HIGH(0x3D)
	CPC  R31,R26
	BRNE _0x2A
	LDI  R26,LOW(55)
	RJMP _0x31
; 0000 00B0                  case 0x3e: lcd_putchar('8');break;
_0x2A:
	CPI  R30,LOW(0x3E)
	LDI  R26,HIGH(0x3E)
	CPC  R31,R26
	BRNE _0x2B
	LDI  R26,LOW(56)
	RJMP _0x31
; 0000 00B1                  case 0x46: lcd_putchar('9');break;
_0x2B:
	CPI  R30,LOW(0x46)
	LDI  R26,HIGH(0x46)
	CPC  R31,R26
	BRNE _0x2C
	LDI  R26,LOW(57)
	RJMP _0x31
; 0000 00B2                  case 0x45: lcd_putchar('0');break;
_0x2C:
	CPI  R30,LOW(0x45)
	LDI  R26,HIGH(0x45)
	CPC  R31,R26
	BRNE _0x2D
	LDI  R26,LOW(48)
	RJMP _0x31
; 0000 00B3                  case 0x29: lcd_putchar(' ');break;
_0x2D:
	CPI  R30,LOW(0x29)
	LDI  R26,HIGH(0x29)
	CPC  R31,R26
	BRNE _0x9
	LDI  R26,LOW(32)
_0x31:
	RCALL _lcd_putchar
; 0000 00B4       }
_0x9:
; 0000 00B5       c++;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	__ADDWRR 5,6,30,31
; 0000 00B6       }
; 0000 00B7       else{
	RJMP _0x2F
_0x6:
; 0000 00B8       c = 0;
	CLR  R5
	CLR  R6
; 0000 00B9       }
_0x2F:
; 0000 00BA       }
	RJMP _0x3
; 0000 00BB }
_0x30:
	RJMP _0x30
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G100:
	ST   -Y,R26
	IN   R30,0x2
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x2,R30
	__DELAY_USB 7
	SBI  0x2,2
	__DELAY_USB 18
	CBI  0x2,2
	__DELAY_USB 18
	RJMP _0x20C0001
__lcd_write_data:
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
	__DELAY_USB 184
	RJMP _0x20C0001
_lcd_gotoxy:
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G100)
	SBCI R31,HIGH(-__base_y_G100)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R3,Y+1
	LDD  R8,Y+0
	ADIW R28,2
	RET
_lcd_clear:
	LDI  R26,LOW(2)
	CALL SUBOPT_0x0
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	CALL SUBOPT_0x0
	LDI  R30,LOW(0)
	MOV  R8,R30
	MOV  R3,R30
	RET
_lcd_putchar:
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2000005
	CP   R3,R7
	BRLO _0x2000004
_0x2000005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	INC  R8
	MOV  R26,R8
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x20C0001
_0x2000004:
	INC  R3
	SBI  0x2,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x2,0
	RJMP _0x20C0001
_lcd_init:
	ST   -Y,R26
	IN   R30,0x1
	ORI  R30,LOW(0xF0)
	OUT  0x1,R30
	SBI  0x1,2
	SBI  0x1,0
	SBI  0x1,1
	CBI  0x2,2
	CBI  0x2,0
	CBI  0x2,1
	LDD  R7,Y+0
	LD   R30,Y
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G100,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G100,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	CALL SUBOPT_0x1
	CALL SUBOPT_0x1
	CALL SUBOPT_0x1
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 276
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x20C0001:
	ADIW R28,1
	RET
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif

	.CSEG
_getchar:
_0x2020003:
	LDS  R30,192
	ANDI R30,LOW(0x80)
	BREQ _0x2020003
	LDS  R30,198
	RET

	.CSEG

	.DSEG

	.CSEG

	.CSEG

	.CSEG

	.CSEG

	.DSEG
__base_y_G100:
	.BYTE 0x4
__seed_G102:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x0:
	CALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x1:
	LDI  R26,LOW(48)
	CALL __lcd_write_nibble_G100
	__DELAY_USW 276
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0xACD
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
