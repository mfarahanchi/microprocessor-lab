
;CodeVisionAVR C Compiler V2.05.3 Standard
;(C) Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega1280
;Program type             : Application
;Clock frequency          : 10.095000 MHz
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
	.DEF _s=R4
	.DEF _d=R3

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
	JMP  _timer1_compa_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer0_compa_isr
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

_0x3:
	.DB  0xEB,0x88,0xB3,0xBA,0xD8,0x7A,0x7B,0xA8
	.DB  0xFB,0xFA
_0xD:
	.DB  0x0,0x80

__GLOBAL_INI_TBL:
	.DW  0x0A
	.DW  _j
	.DW  _0x3*2

	.DW  0x02
	.DW  0x03
	.DW  _0xD*2

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
;Date    : 3/3/2018
;Author  : admin
;Company : IUST
;Comments:
;
;
;Chip type               : ATmega1280
;Program type            : Application
;AVR Core Clock frequency: 10.095000 MHz
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
;unsigned char i[] = {0, 0, 0, 0}, j[] = {0b11101011, 0b10001000, 0b10110011, 0b10111010, 0b11011000, 0b01111010, 0b01111011, 0b10101000, 0b11111011, 0b11111010};

	.DSEG
;unsigned char s = 0x80, d = 0;
;// Timer 0 output compare A interrupt service routine
;interrupt [TIM0_COMPA] void timer0_compa_isr(void)
; 0000 001D {

	.CSEG
_timer0_compa_isr:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 001E // Place your code here
; 0000 001F PORTF = s;
	OUT  0x11,R4
; 0000 0020 PORTK = j[i[d]];
	MOV  R30,R3
	LDI  R31,0
	SUBI R30,LOW(-_i)
	SBCI R31,HIGH(-_i)
	LD   R30,Z
	LDI  R31,0
	SUBI R30,LOW(-_j)
	SBCI R31,HIGH(-_j)
	LD   R30,Z
	STS  264,R30
; 0000 0021 s /= 2;
	MOV  R26,R4
	LDI  R27,0
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CALL __DIVW21
	MOV  R4,R30
; 0000 0022 d+=1;
	INC  R3
; 0000 0023 if(s < 0x10){
	LDI  R30,LOW(16)
	CP   R4,R30
	BRSH _0x4
; 0000 0024 s = 0x80;
	LDI  R30,LOW(128)
	MOV  R4,R30
; 0000 0025 d = 0;
	CLR  R3
; 0000 0026 }
; 0000 0027 
; 0000 0028 
; 0000 0029 }
_0x4:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
;
;// Timer1 output compare A interrupt service routine
;interrupt [TIM1_COMPA] void timer1_compa_isr(void)
; 0000 002D {
_timer1_compa_isr:
	ST   -Y,R26
	ST   -Y,R30
	IN   R30,SREG
	ST   -Y,R30
; 0000 002E i[0] += 1;
	LDS  R30,_i
	SUBI R30,-LOW(1)
	STS  _i,R30
; 0000 002F if(i[0] == 10){
	LDS  R26,_i
	CPI  R26,LOW(0xA)
	BRNE _0x5
; 0000 0030 i[0] = 0;
	LDI  R30,LOW(0)
	STS  _i,R30
; 0000 0031 i[1] += 1;
	__GETB1MN _i,1
	SUBI R30,-LOW(1)
	__PUTB1MN _i,1
; 0000 0032 }
; 0000 0033 if(i[1] == 10){
_0x5:
	__GETB2MN _i,1
	CPI  R26,LOW(0xA)
	BRNE _0x6
; 0000 0034 i[1] = 0;
	LDI  R30,LOW(0)
	__PUTB1MN _i,1
; 0000 0035 i[2] += 1;
	__GETB1MN _i,2
	SUBI R30,-LOW(1)
	__PUTB1MN _i,2
; 0000 0036 }
; 0000 0037 if(i[2] == 10){
_0x6:
	__GETB2MN _i,2
	CPI  R26,LOW(0xA)
	BRNE _0x7
; 0000 0038 i[2] = 0;
	LDI  R30,LOW(0)
	__PUTB1MN _i,2
; 0000 0039 i[3] += 1;
	__GETB1MN _i,3
	SUBI R30,-LOW(1)
	__PUTB1MN _i,3
; 0000 003A }
; 0000 003B if(i[3] == 10){
_0x7:
	__GETB2MN _i,3
	CPI  R26,LOW(0xA)
	BRNE _0x8
; 0000 003C i[0] = 0;
	LDI  R30,LOW(0)
	STS  _i,R30
; 0000 003D i[1] = 0;
	__PUTB1MN _i,1
; 0000 003E i[2] = 0;
	__PUTB1MN _i,2
; 0000 003F i[3] = 0;
	__PUTB1MN _i,3
; 0000 0040 }
; 0000 0041 }
_0x8:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R30,Y+
	LD   R26,Y+
	RETI
;
;// Declare your global variables here
;
;void main(void)
; 0000 0046 {
_main:
; 0000 0047 // Declare your local variables here
; 0000 0048 
; 0000 0049 // Crystal Oscillator division factor: 1
; 0000 004A #pragma optsize-
; 0000 004B CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
; 0000 004C CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
; 0000 004D #ifdef _OPTIMIZE_SIZE_
; 0000 004E #pragma optsize+
; 0000 004F #endif
; 0000 0050 
; 0000 0051 // Input/Output Ports initialization
; 0000 0052 // Port A initialization
; 0000 0053 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0054 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0055 PORTA=0x00;
	OUT  0x2,R30
; 0000 0056 DDRA=0x00;
	OUT  0x1,R30
; 0000 0057 
; 0000 0058 // Port B initialization
; 0000 0059 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 005A // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 005B PORTB=0x00;
	OUT  0x5,R30
; 0000 005C DDRB=0x00;
	OUT  0x4,R30
; 0000 005D 
; 0000 005E // Port C initialization
; 0000 005F // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0060 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0061 PORTC=0x00;
	OUT  0x8,R30
; 0000 0062 DDRC=0x00;
	OUT  0x7,R30
; 0000 0063 
; 0000 0064 // Port D initialization
; 0000 0065 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0066 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0067 PORTD=0x00;
	OUT  0xB,R30
; 0000 0068 DDRD=0x00;
	OUT  0xA,R30
; 0000 0069 
; 0000 006A // Port E initialization
; 0000 006B // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 006C // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 006D PORTE=0x00;
	OUT  0xE,R30
; 0000 006E DDRE=0x00;
	OUT  0xD,R30
; 0000 006F 
; 0000 0070 // Port F initialization
; 0000 0071 // Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out
; 0000 0072 // State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0
; 0000 0073 PORTF=0x00;
	OUT  0x11,R30
; 0000 0074 DDRF=0xFF;
	LDI  R30,LOW(255)
	OUT  0x10,R30
; 0000 0075 
; 0000 0076 // Port G initialization
; 0000 0077 // Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0078 // State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0079 PORTG=0x00;
	LDI  R30,LOW(0)
	OUT  0x14,R30
; 0000 007A DDRG=0x00;
	OUT  0x13,R30
; 0000 007B 
; 0000 007C // Port H initialization
; 0000 007D // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 007E // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 007F PORTH=0x00;
	STS  258,R30
; 0000 0080 DDRH=0x00;
	STS  257,R30
; 0000 0081 
; 0000 0082 // Port J initialization
; 0000 0083 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0084 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0085 PORTJ=0x00;
	STS  261,R30
; 0000 0086 DDRJ=0x00;
	STS  260,R30
; 0000 0087 
; 0000 0088 // Port K initialization
; 0000 0089 // Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out
; 0000 008A // State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0
; 0000 008B PORTK=0x00;
	STS  264,R30
; 0000 008C DDRK=0xFF;
	LDI  R30,LOW(255)
	STS  263,R30
; 0000 008D 
; 0000 008E // Port L initialization
; 0000 008F // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0090 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0091 PORTL=0x00;
	LDI  R30,LOW(0)
	STS  267,R30
; 0000 0092 DDRL=0x00;
	STS  266,R30
; 0000 0093 
; 0000 0094 // Timer/Counter 0 initialization
; 0000 0095 // Clock source: System Clock
; 0000 0096 // Clock value: 9.858 kHz
; 0000 0097 // Mode: CTC top=OCR0A
; 0000 0098 // OC0A output: Disconnected
; 0000 0099 // OC0B output: Disconnected
; 0000 009A TCCR0A=0x02;
	LDI  R30,LOW(2)
	OUT  0x24,R30
; 0000 009B TCCR0B=0x05;
	LDI  R30,LOW(5)
	OUT  0x25,R30
; 0000 009C TCNT0=0x00;
	LDI  R30,LOW(0)
	OUT  0x26,R30
; 0000 009D OCR0A=0x13;
	LDI  R30,LOW(19)
	OUT  0x27,R30
; 0000 009E OCR0B=0x00;
	LDI  R30,LOW(0)
	OUT  0x28,R30
; 0000 009F 
; 0000 00A0 // Timer/Counter 1 initialization
; 0000 00A1 // Clock source: System Clock
; 0000 00A2 // Clock value: 9.858 kHz
; 0000 00A3 // Mode: CTC top=OCR1A
; 0000 00A4 // OC1A output: Discon.
; 0000 00A5 // OC1B output: Discon.
; 0000 00A6 // OC1C output: Discon.
; 0000 00A7 // Noise Canceler: Off
; 0000 00A8 // Input Capture on Falling Edge
; 0000 00A9 // Timer1 Overflow Interrupt: Off
; 0000 00AA // Input Capture Interrupt: Off
; 0000 00AB // Compare A Match Interrupt: On
; 0000 00AC // Compare B Match Interrupt: Off
; 0000 00AD // Compare C Match Interrupt: Off
; 0000 00AE TCCR1A=0x00;
	STS  128,R30
; 0000 00AF TCCR1B=0x0D;
	LDI  R30,LOW(13)
	STS  129,R30
; 0000 00B0 TCNT1H=0x00;
	LDI  R30,LOW(0)
	STS  133,R30
; 0000 00B1 TCNT1L=0x00;
	STS  132,R30
; 0000 00B2 ICR1H=0x00;
	STS  135,R30
; 0000 00B3 ICR1L=0x00;
	STS  134,R30
; 0000 00B4 OCR1AH=0x29;
	LDI  R30,LOW(41)
	STS  137,R30
; 0000 00B5 OCR1AL=0xff;
	LDI  R30,LOW(255)
	STS  136,R30
; 0000 00B6 OCR1BH=0x00;
	LDI  R30,LOW(0)
	STS  139,R30
; 0000 00B7 OCR1BL=0x00;
	STS  138,R30
; 0000 00B8 OCR1CH=0x00;
	STS  141,R30
; 0000 00B9 OCR1CL=0x00;
	STS  140,R30
; 0000 00BA 
; 0000 00BB // Timer/Counter 2 initialization
; 0000 00BC // Clock source: System Clock
; 0000 00BD // Clock value: Timer2 Stopped
; 0000 00BE // Mode: Normal top=0xFF
; 0000 00BF // OC2A output: Disconnected
; 0000 00C0 // OC2B output: Disconnected
; 0000 00C1 ASSR=0x00;
	STS  182,R30
; 0000 00C2 TCCR2A=0x00;
	STS  176,R30
; 0000 00C3 TCCR2B=0x00;
	STS  177,R30
; 0000 00C4 TCNT2=0x00;
	STS  178,R30
; 0000 00C5 OCR2A=0x00;
	STS  179,R30
; 0000 00C6 OCR2B=0x00;
	STS  180,R30
; 0000 00C7 
; 0000 00C8 // Timer/Counter 3 initialization
; 0000 00C9 // Clock source: System Clock
; 0000 00CA // Clock value: Timer3 Stopped
; 0000 00CB // Mode: Normal top=0xFFFF
; 0000 00CC // OC3A output: Discon.
; 0000 00CD // OC3B output: Discon.
; 0000 00CE // OC3C output: Discon.
; 0000 00CF // Noise Canceler: Off
; 0000 00D0 // Input Capture on Falling Edge
; 0000 00D1 // Timer3 Overflow Interrupt: Off
; 0000 00D2 // Input Capture Interrupt: Off
; 0000 00D3 // Compare A Match Interrupt: Off
; 0000 00D4 // Compare B Match Interrupt: Off
; 0000 00D5 // Compare C Match Interrupt: Off
; 0000 00D6 TCCR3A=0x00;
	STS  144,R30
; 0000 00D7 TCCR3B=0x00;
	STS  145,R30
; 0000 00D8 TCNT3H=0x00;
	STS  149,R30
; 0000 00D9 TCNT3L=0x00;
	STS  148,R30
; 0000 00DA ICR3H=0x00;
	STS  151,R30
; 0000 00DB ICR3L=0x00;
	STS  150,R30
; 0000 00DC OCR3AH=0x00;
	STS  153,R30
; 0000 00DD OCR3AL=0x00;
	STS  152,R30
; 0000 00DE OCR3BH=0x00;
	STS  155,R30
; 0000 00DF OCR3BL=0x00;
	STS  154,R30
; 0000 00E0 OCR3CH=0x00;
	STS  157,R30
; 0000 00E1 OCR3CL=0x00;
	STS  156,R30
; 0000 00E2 
; 0000 00E3 // Timer/Counter 4 initialization
; 0000 00E4 // Clock source: System Clock
; 0000 00E5 // Clock value: Timer4 Stopped
; 0000 00E6 // Mode: Normal top=0xFFFF
; 0000 00E7 // OC4A output: Discon.
; 0000 00E8 // OC4B output: Discon.
; 0000 00E9 // OC4C output: Discon.
; 0000 00EA // Noise Canceler: Off
; 0000 00EB // Input Capture on Falling Edge
; 0000 00EC // Timer4 Overflow Interrupt: Off
; 0000 00ED // Input Capture Interrupt: Off
; 0000 00EE // Compare A Match Interrupt: Off
; 0000 00EF // Compare B Match Interrupt: Off
; 0000 00F0 // Compare C Match Interrupt: Off
; 0000 00F1 TCCR4A=0x00;
	STS  160,R30
; 0000 00F2 TCCR4B=0x00;
	STS  161,R30
; 0000 00F3 TCNT4H=0x00;
	STS  165,R30
; 0000 00F4 TCNT4L=0x00;
	STS  164,R30
; 0000 00F5 ICR4H=0x00;
	STS  167,R30
; 0000 00F6 ICR4L=0x00;
	STS  166,R30
; 0000 00F7 OCR4AH=0x00;
	STS  169,R30
; 0000 00F8 OCR4AL=0x00;
	STS  168,R30
; 0000 00F9 OCR4BH=0x00;
	STS  171,R30
; 0000 00FA OCR4BL=0x00;
	STS  170,R30
; 0000 00FB OCR4CH=0x00;
	STS  173,R30
; 0000 00FC OCR4CL=0x00;
	STS  172,R30
; 0000 00FD 
; 0000 00FE // Timer/Counter 5 initialization
; 0000 00FF // Clock source: System Clock
; 0000 0100 // Clock value: Timer5 Stopped
; 0000 0101 // Mode: Normal top=0xFFFF
; 0000 0102 // OC5A output: Discon.
; 0000 0103 // OC5B output: Discon.
; 0000 0104 // OC5C output: Discon.
; 0000 0105 // Noise Canceler: Off
; 0000 0106 // Input Capture on Falling Edge
; 0000 0107 // Timer5 Overflow Interrupt: Off
; 0000 0108 // Input Capture Interrupt: Off
; 0000 0109 // Compare A Match Interrupt: Off
; 0000 010A // Compare B Match Interrupt: Off
; 0000 010B // Compare C Match Interrupt: Off
; 0000 010C TCCR5A=0x00;
	STS  288,R30
; 0000 010D TCCR5B=0x00;
	STS  289,R30
; 0000 010E TCNT5H=0x00;
	STS  293,R30
; 0000 010F TCNT5L=0x00;
	STS  292,R30
; 0000 0110 ICR5H=0x00;
	STS  295,R30
; 0000 0111 ICR5L=0x00;
	STS  294,R30
; 0000 0112 OCR5AH=0x00;
	STS  297,R30
; 0000 0113 OCR5AL=0x00;
	STS  296,R30
; 0000 0114 OCR5BH=0x00;
	STS  299,R30
; 0000 0115 OCR5BL=0x00;
	STS  298,R30
; 0000 0116 OCR5CH=0x00;
	STS  301,R30
; 0000 0117 OCR5CL=0x00;
	STS  300,R30
; 0000 0118 
; 0000 0119 // External Interrupt(s) initialization
; 0000 011A // INT0: Off
; 0000 011B // INT1: Off
; 0000 011C // INT2: Off
; 0000 011D // INT3: Off
; 0000 011E // INT4: Off
; 0000 011F // INT5: Off
; 0000 0120 // INT6: Off
; 0000 0121 // INT7: Off
; 0000 0122 EICRA=0x00;
	STS  105,R30
; 0000 0123 EICRB=0x00;
	STS  106,R30
; 0000 0124 EIMSK=0x00;
	OUT  0x1D,R30
; 0000 0125 // PCINT0 interrupt: Off
; 0000 0126 // PCINT1 interrupt: Off
; 0000 0127 // PCINT2 interrupt: Off
; 0000 0128 // PCINT3 interrupt: Off
; 0000 0129 // PCINT4 interrupt: Off
; 0000 012A // PCINT5 interrupt: Off
; 0000 012B // PCINT6 interrupt: Off
; 0000 012C // PCINT7 interrupt: Off
; 0000 012D // PCINT8 interrupt: Off
; 0000 012E // PCINT9 interrupt: Off
; 0000 012F // PCINT10 interrupt: Off
; 0000 0130 // PCINT11 interrupt: Off
; 0000 0131 // PCINT12 interrupt: Off
; 0000 0132 // PCINT13 interrupt: Off
; 0000 0133 // PCINT14 interrupt: Off
; 0000 0134 // PCINT15 interrupt: Off
; 0000 0135 // PCINT16 interrupt: Off
; 0000 0136 // PCINT17 interrupt: Off
; 0000 0137 // PCINT18 interrupt: Off
; 0000 0138 // PCINT19 interrupt: Off
; 0000 0139 // PCINT20 interrupt: Off
; 0000 013A // PCINT21 interrupt: Off
; 0000 013B // PCINT22 interrupt: Off
; 0000 013C // PCINT23 interrupt: Off
; 0000 013D PCMSK0=0x00;
	STS  107,R30
; 0000 013E PCMSK1=0x00;
	STS  108,R30
; 0000 013F PCMSK2=0x00;
	STS  109,R30
; 0000 0140 PCICR=0x00;
	STS  104,R30
; 0000 0141 
; 0000 0142 // Timer/Counter 0 Interrupt(s) initialization
; 0000 0143 TIMSK0=0x02;
	LDI  R30,LOW(2)
	STS  110,R30
; 0000 0144 
; 0000 0145 // Timer/Counter 1 Interrupt(s) initialization
; 0000 0146 TIMSK1=0x02;
	STS  111,R30
; 0000 0147 
; 0000 0148 // Timer/Counter 2 Interrupt(s) initialization
; 0000 0149 TIMSK2=0x00;
	LDI  R30,LOW(0)
	STS  112,R30
; 0000 014A 
; 0000 014B // Timer/Counter 3 Interrupt(s) initialization
; 0000 014C TIMSK3=0x00;
	STS  113,R30
; 0000 014D 
; 0000 014E // Timer/Counter 4 Interrupt(s) initialization
; 0000 014F TIMSK4=0x00;
	STS  114,R30
; 0000 0150 
; 0000 0151 // Timer/Counter 5 Interrupt(s) initialization
; 0000 0152 TIMSK5=0x00;
	STS  115,R30
; 0000 0153 
; 0000 0154 // USART0 initialization
; 0000 0155 // USART0 disabled
; 0000 0156 UCSR0B=0x00;
	STS  193,R30
; 0000 0157 
; 0000 0158 // USART1 initialization
; 0000 0159 // USART1 disabled
; 0000 015A UCSR1B=0x00;
	STS  201,R30
; 0000 015B 
; 0000 015C // USART2 initialization
; 0000 015D // USART2 disabled
; 0000 015E UCSR2B=0x00;
	STS  209,R30
; 0000 015F 
; 0000 0160 // USART3 initialization
; 0000 0161 // USART3 disabled
; 0000 0162 UCSR3B=0x00;
	STS  305,R30
; 0000 0163 
; 0000 0164 // Analog Comparator initialization
; 0000 0165 // Analog Comparator: Off
; 0000 0166 // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 0167 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x30,R30
; 0000 0168 ADCSRB=0x00;
	LDI  R30,LOW(0)
	STS  123,R30
; 0000 0169 DIDR1=0x00;
	STS  127,R30
; 0000 016A 
; 0000 016B // ADC initialization
; 0000 016C // ADC disabled
; 0000 016D ADCSRA=0x00;
	STS  122,R30
; 0000 016E 
; 0000 016F // SPI initialization
; 0000 0170 // SPI disabled
; 0000 0171 SPCR=0x00;
	OUT  0x2C,R30
; 0000 0172 
; 0000 0173 // TWI initialization
; 0000 0174 // TWI disabled
; 0000 0175 TWCR=0x00;
	STS  188,R30
; 0000 0176 
; 0000 0177 // Global enable interrupts
; 0000 0178 #asm("sei")
	sei
; 0000 0179 
; 0000 017A while (1)
_0x9:
; 0000 017B       {
; 0000 017C       // Place your code here
; 0000 017D 
; 0000 017E       }
	RJMP _0x9
; 0000 017F }
_0xC:
	RJMP _0xC

	.DSEG
_i:
	.BYTE 0x4
_j:
	.BYTE 0xA

	.CSEG

	.CSEG
__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

;END OF CODE MARKER
__END_OF_CODE:
