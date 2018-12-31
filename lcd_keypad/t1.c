/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 12/28/2018
Author  : 
Company : 
Comments: 


Chip type               : ATmega32
Program type            : Application
AVR Core Clock frequency: 11.095200 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 512
*******************************************************/

#include <mega32.h>
#include <delay.h>

// Alphanumeric LCD functions
#include <alcd.h>

// Declare your global variables here

void main(void)
{
// Declare your local variables here

int i,j;
char esm[4][4] = {
{'7','8','9','/'},
{'4','5','6','*'},
{'1','2','3','-'},
{'c','0','=','+'},
};
char buttom;
// Input/Output Ports initialization
// Port A initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

// Port B initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

// Port C initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

// Port D initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (1<<DDD3) | (1<<DDD2) | (1<<DDD1) | (1<<DDD0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTD=(1<<PORTD7) | (1<<PORTD6) | (1<<PORTD5) | (1<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
DDRA=0xFF;
// Alphanumeric LCD initialization
// Connections are specified in the
// Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
// RS - PORTC Bit 0
// RD - PORTC Bit 1
// EN - PORTC Bit 2
// D4 - PORTC Bit 4
// D5 - PORTC Bit 5
// D6 - PORTC Bit 6
// D7 - PORTC Bit 7
// Characters/line: 16
lcd_init(16);
buttom='7';
while (1)
      {
      // Place your code here
        PORTD=0x01;
        if(PIND.4) {buttom='';i=0;j=0;}//7
        if(PIND.5) {buttom='';i=0;j=1;}//8
        if(PIND.6) {buttom='';i=0;j=2;}//9
        if(PIND.7) {buttom='';i=0;j=3;}// /
        delay_ms(4);
        PORTD=0x02;
        if(PIND.4) {buttom='';i=1;j=0;}//4
        if(PIND.5) {buttom='';i=1;j=1;}//5
        if(PIND.6) {buttom='';i=1;j=2;}//6
        if(PIND.7) {buttom='';i=1;j=3;}// *
        delay_ms(4);
        PORTD=0x04;
        if(PIND.4) {buttom='';i=2;j=0;}//1
        if(PIND.5) {buttom='';i=2;j=1;}//2
        if(PIND.6) {buttom='';i=2;j=2;}//3
        if(PIND.7) {buttom='';i=2;j=3;}// -
        delay_ms(4);
        PORTD=0x08;
        if(PIND.4) {buttom='';i=3;j=0;}//c
        if(PIND.5) {buttom='';i=3;j=1;}//0
        if(PIND.6) {buttom='';i=3;j=2;}//=
        if(PIND.7) {buttom='';i=3;j=3;}//+
        delay_ms(4);
        //buttom=esm[i][j];
        //lcd_putchar(buttom);
        //PORTD=0x00;
        
        PORTD=0x0F;
        if(PIND==0x0F) {
            if(buttom!=esm[i][j]){
            buttom=esm[i][j];lcd_putchar(buttom);PORTD=0x0F;PIND=0X0F; 
            if(i==3 && j==0) { lcd_clear();}
            }
        }          
      }
}
