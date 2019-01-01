/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.3 Standard
Automatic Program Generator
© Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 4/21/2018
Author  : admin
Company : IUST
Comments: 


Chip type               : ATmega64
Program type            : Application
AVR Core Clock frequency: 16.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 1024
*****************************************************/

#include <mega64.h>
#include <delay.h>

// Declare your global variables here
unsigned char ds[16] = {0x3f,0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x27, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71};
unsigned char s[6] = {0, 0, 0, 0 ,0 ,0};
char st = 0;
char select = 2;

// Timer 0 output compare interrupt service routine
interrupt [TIM0_COMP] void timer0_comp_isr(void)
{
// Place your code here
      if(st == 6){
       st = 0;
       select = 2;
      }
      else{
       st++;
       select *= 2;
      }
      PORTC = select;
      PORTD = ds[s[st]]; 
}


void main(void)
{
// Declare your local variables here

// Input/Output Ports initialization
// Port A initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=In Func1=In Func0=In 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=P State1=P State0=P 
PORTA=0x07;
DDRA=0xF8;

// Port B initialization
// Func7=In Func6=In Func5=In Func4=Out Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=0 State3=T State2=T State1=T State0=T 
PORTB=0x00;
DDRB=0x10;

// Port C initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTC=0x00;
DDRC=0xFF;

// Port D initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTD=0x00;
DDRD=0xFF;

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
// Func4=In Func3=In Func2=In Func1=In Func0=In 
// State4=T State3=T State2=T State1=T State0=T 
PORTG=0x00;
DDRG=0x00;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 15.625 kHz
// Mode: CTC top=OCR0
// OC0 output: Toggle on compare match
ASSR=0x00;
TCCR0=0x1F;
TCNT0=0x00;
OCR0=0x10;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x02;

// Global enable interrupts
#asm("sei")


while (1)
      {
      // Place your code here
      PORTA = 0b10111111;
      delay_ms(30);
      if(!(PINA & 0x01)){
      s[5] = s[4];
      s[4] = s[3];
      s[3] = s[2];
      s[2] = s[1];
      s[1] = s[0];
      s[0] = 0;     
      }
      if(!(PINA & 0x02)){
      s[5] = s[4];
      s[4] = s[3];
      s[3] = s[2];
      s[2] = s[1];
      s[1] = s[0];
      s[0] = 1;     
      }
      if(!(PINA & 0x04)){
      s[5] = s[4];
      s[4] = s[3];
      s[3] = s[2];
      s[2] = s[1];
      s[1] = s[0];
      s[0] = 2;     
      }
      PORTA = 0b11011111;
      delay_ms(30);
      if(!(PINA & 0x01)){
      s[5] = s[4];
      s[4] = s[3];
      s[3] = s[2];
      s[2] = s[1];
      s[1] = s[0];
      s[0] = 3;     
      }
      if(!(PINA & 0x02)){
      s[5] = s[4];
      s[4] = s[3];
      s[3] = s[2];
      s[2] = s[1];
      s[1] = s[0];
      s[0] = 4;     
      }
      if(!(PINA & 0x04)){
      s[5] = s[4];
      s[4] = s[3];
      s[3] = s[2];
      s[2] = s[1];
      s[1] = s[0];
      s[0] = 5;     
      }
      PORTA = 0b11101111;
      delay_ms(30);
      if(!(PINA & 0x01)){
      s[5] = s[4];
      s[4] = s[3];
      s[3] = s[2];
      s[2] = s[1];
      s[1] = s[0];
      s[0] = 6;     
      }
      if(!(PINA & 0x02)){
      s[5] = s[4];
      s[4] = s[3];
      s[3] = s[2];
      s[2] = s[1];
      s[1] = s[0];
      s[0] = 7;     
      }
      if(!(PINA & 0x04)){
      s[5] = s[4];
      s[4] = s[3];
      s[3] = s[2];
      s[2] = s[1];
      s[1] = s[0];
      s[0] = 8;     
      }
      PORTA = 0b11110111;
      delay_ms(30);
      if(!(PINA & 0x01)){
      s[5] = s[4];
      s[4] = s[3];
      s[3] = s[2];
      s[2] = s[1];
      s[1] = s[0];
      s[0] = 9;     
      }
      if(!(PINA & 0x02)){
      s[5] = s[4];
      s[4] = s[3];
      s[3] = s[2];
      s[2] = s[1];
      s[1] = s[0];
      s[0] = 10;     
      }
      if(!(PINA & 0x04)){
      s[5] = s[4];
      s[4] = s[3];
      s[3] = s[2];
      s[2] = s[1];
      s[1] = s[0];
      s[0] = 11;     
      }
      
      }
}
