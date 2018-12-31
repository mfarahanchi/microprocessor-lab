/*****************************************************
This program was produced by the
CodeWizardAVR V2.04.4a Advanced
Automatic Program Generator
© Copyright 1998-2009 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 12/22/2018
Author  : NeVaDa
Company : 
Comments: 


Chip type               : ATmega32
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 512
*****************************************************/

#include <mega32.h>
#include <delay.h>
// Declare your global variables here

void main(void)
{


// Declare your local variables here
int index;
int j = 0;
char matrix[30] = {0x00, 0b01111110, 0b00010001, 0b00010001, 0b01111110, // A
                   0x00, 0b01111111, 0b01001001, 0b01001001, 0b00110110, // B
                   0x00, 0b00111110, 0b01000001, 0b01000001, 0b00100010, // C
                   0x00, 0b01111111, 0b01000001, 0b01000001, 0b00111110, // D
                   0x00, 0b01111111, 0b01001001, 0b01001001, 0b01000001, // E
                   0x00, 0b01111111, 0b00001001, 0b00001001, 0b00000001 // F  
                   };
int loopi = 0;
// Port C initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTC=0xFF;
DDRC=0xFF;

// Port D initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTD=0x00;
DDRD=0xFF;

while (1)
      {
      for(index=0; index < 31; index++)
      {                          
        for(j=0;j <9 ; j++){
            for(loopi =0; loopi<8; loopi++) {
                PORTD = (1 << loopi);
                PORTC = ~(matrix[(index + loopi) % 30]);
                delay_ms(5);
                PORTD = 0;
            }
            delay_ms(10);
        } 
      }
      index = 1;
      };
}
