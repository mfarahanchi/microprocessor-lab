/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.3 Standard
Automatic Program Generator
© Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 5/26/2018
Author  : admin
Company : IUST
Comments: 


Chip type               : ATmega1280
Program type            : Application
AVR Core Clock frequency: 11.059200 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 2048
*****************************************************/

#include <mega1280.h>
#include <delay.h>
// Alphanumeric LCD functions
#include <alcd.h>

// Standard Input/Output functions
#include <stdio.h>

#include <stdlib.h>

// Declare your global variables here
unsigned char a;
int c = 0;
void main(void)
{
// Declare your local variables here

// Crystal Oscillator division factor: 1
#pragma optsize-
CLKPR=0x80;
CLKPR=0x00;
#ifdef _OPTIMIZE_SIZE_
#pragma optsize+
#endif

// Input/Output Ports initialization
// Port A initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTA=0x00;
DDRA=0x00;

// Port B initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTB=0x00;
DDRB=0x00;

// Port C initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTC=0x00;
DDRC=0x00;

// Port D initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTD=0x00;
DDRD=0x00;

// Port E initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTE=0x00;
DDRE=0x00;

// Port F initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTF=0x00;
DDRF=0x00;

// Port G initialization
// Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State5=T State4=T State3=T State2=T State1=T State0=T 
PORTG=0x00;
DDRG=0x00;

// Port H initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTH=0x00;
DDRH=0x00;

// Port J initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTJ=0x00;
DDRJ=0x00;

// Port K initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTK=0x00;
DDRK=0x00;

// Port L initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTL=0x00;
DDRL=0x00;

// USART0 initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART0 Receiver: On
// USART0 Transmitter: Off
// USART0 Mode: Sync. Slave UCPOL=0
UCSR0A=0x00;
UCSR0B=0x10;
UCSR0C=0x46;
// Alphanumeric LCD initialization
// Connections are specified in the
// Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
// RS - PORTA Bit 0
// RD - PORTA Bit 1
// EN - PORTA Bit 2
// D4 - PORTA Bit 4
// D5 - PORTA Bit 5
// D6 - PORTA Bit 6
// D7 - PORTA Bit 7
// Characters/line: 16
lcd_init(16);

while (1)
      {
      // Place your code here
      a = getchar();
      if( c < 2 ){
      switch(a){
                 case 0x1c: lcd_putchar('a');break;
		 case 0x32: lcd_putchar('b');break;
                 case 0x21: lcd_putchar('c');break;
                 case 0x23: lcd_putchar('d');break;
                 case 0x24: lcd_putchar('e');break;
                 case 0x2b: lcd_putchar('f');break;
                 case 0x34: lcd_putchar('g');break;
                 case 0x33: lcd_putchar('h');break;
                 case 0x43: lcd_putchar('i');break;
                 case 0x3b: lcd_putchar('j');break;
                 case 0x42: lcd_putchar('k');break;
                 case 0x4b: lcd_putchar('l');break;
                 case 0x3a: lcd_putchar('m');break;
                 case 0x31: lcd_putchar('n');break; 
                 case 0x44: lcd_putchar('o');break;
                 case 0x4d: lcd_putchar('p');break;
                 case 0x15: lcd_putchar('q');break;
                 case 0x2d: lcd_putchar('r');break;
                 case 0x1b: lcd_putchar('s');break;
                 case 0x2c: lcd_putchar('t');break;
                 case 0x3c: lcd_putchar('u');break;
                 case 0x2a: lcd_putchar('v');break;
                 case 0x1d: lcd_putchar('w');break;
                 case 0x22: lcd_putchar('x');break;
                 case 0x35: lcd_putchar('y');break;
                 case 0x1a: lcd_putchar('z');break;
                 case 0x16: lcd_putchar('1');break;
                 case 0x1e: lcd_putchar('2');break;
                 case 0x26: lcd_putchar('3');break;
                 case 0x25: lcd_putchar('4');break;
                 case 0x2e: lcd_putchar('5');break;
                 case 0x36: lcd_putchar('6');break;
                 case 0x3d: lcd_putchar('7');break;
                 case 0x3e: lcd_putchar('8');break;
                 case 0x46: lcd_putchar('9');break;
                 case 0x45: lcd_putchar('0');break;
      }
      c++;
      }
      else{
      c = 0;
      }
      }
}
