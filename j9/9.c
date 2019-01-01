/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.3 Standard
Automatic Program Generator
© Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 5/19/2018
Author  : admin
Company : IUST
Comments: 


Chip type               : ATmega64A
Program type            : Application
AVR Core Clock frequency: 16.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 1024
*****************************************************/

#include <mega64a.h>
#include <delay.h>
// Graphic LCD functions
#include <glcd.h>

// Font used for displaying text
// on the graphic LCD
#include <font5x7.h>

// Function used for reading image
// data from external memory
unsigned char read_ext_memory(GLCDMEMADDR_t addr)
{
unsigned char data;
// Place your code here

return data;
}

// Function used for writing image
// data to external memory
void write_ext_memory(GLCDMEMADDR_t addr, unsigned char data)
{
// Place your code here

}

// Declare your global variables here
int i;
void main(void)
{
// Declare your local variables here
// Graphic LCD initialization data
GLCDINIT_t glcd_init_data;

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

// Graphic LCD initialization
// The KS0108 connections are specified in the
// Project|Configure|C Compiler|Libraries|Graphic LCD menu:
// DB0 - PORTD Bit 0
// DB1 - PORTD Bit 1
// DB2 - PORTD Bit 2
// DB3 - PORTD Bit 3
// DB4 - PORTD Bit 4
// DB5 - PORTD Bit 5
// DB6 - PORTD Bit 6
// DB7 - PORTD Bit 7
// E - PORTC Bit 0
// RD /WR - PORTC Bit 1
// RS - PORTC Bit 2
// /RST - PORTC Bit 3
// CS1 - PORTC Bit 4
// CS2 - PORTC Bit 5

// Specify the current font for displaying text
glcd_init_data.font=font5x7;
// No function is used for reading
// image data from external memory
glcd_init_data.readxmem=NULL;
// No function is used for writing
// image data to external memory
glcd_init_data.writexmem=NULL;

glcd_init(&glcd_init_data);

while (1)
      {
      // Place your code here
       glcd_clear();
       for(i = 0; i < 88; i++){
       glcd_circle(20 + i, 20, 20);
       delay_ms(5);
       glcd_clear();
       }
       for(i = 88; i > 0; i--){
       glcd_circle(20 + i, 20, 20);
       delay_ms(5);
       glcd_clear();
       }
       
      }
}
