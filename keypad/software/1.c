/*****************************************************
This program was produced by the
CodeWizardAVR V2.04.4a Advanced
Automatic Program Generator
© Copyright 1998-2009 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 12/15/2018
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

// Alphanumeric LCD Module functions
#asm
   .equ __lcd_port=0x15 ;PORTC
#endasm
#include <lcd.h>
#include <delay.h>


// Declare your global variables here

void main(void)
{
// Declare your local variables here
int index_x = 0, index_y = 0;
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
// Func7=In Func6=In Func5=In Func4=In Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=T State6=T State5=T State4=T State3=0 State2=0 State1=0 State0=0 
PORTD=0x00;
DDRD=0x0F;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: Timer 0 Stopped
// Mode: Normal top=FFh
// OC0 output: Disconnected
TCCR0=0x00;
TCNT0=0x00;
OCR0=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: Timer1 Stopped
// Mode: Normal top=FFFFh
// OC1A output: Discon.
// OC1B output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=0x00;
TCCR1B=0x00;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer2 Stopped
// Mode: Normal top=FFh
// OC2 output: Disconnected
ASSR=0x00;
TCCR2=0x00;
TCNT2=0x00;
OCR2=0x00;

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
MCUCR=0x00;
MCUCSR=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x00;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;

// LCD module initialization
lcd_init(16);
lcd_clear();
lcd_gotoxy(index_x,index_y);
//lcd_putsf("hh");

while (1)
      {
      // Place your code here 
        PORTD.0 = 1;    
        delay_ms(20);
        
        if(PIND.4 == 1)
        {                 
            while(PIND.4 == 1);   
            lcd_putchar('7');
            
        }
        if(PIND.5 == 1)
        {                 
            while(PIND.5 == 1);
            lcd_putchar('8');
        }
        if(PIND.6 == 1)
        {                 
            while(PIND.6 == 1);
            lcd_putchar('9');
        }
        if(PIND.7 == 1)
        {                 
            while(PIND.7 == 1);
            lcd_putchar('/');
        }
        PORTD.0 = 0;
        delay_ms(20);
        PORTD.1 = 1;
        if(PIND.4 == 1)
        {                 
            while(PIND.4 == 1 );
            lcd_putchar('4');
        }
        if(PIND.5 == 1)
        {                 
            while(PIND.5 == 1);
            lcd_putchar('5');
        }
        if(PIND.6 == 1)
        {                 
            while(PIND.6 == 1);
            lcd_putchar('6');
        }
        if(PIND.7 == 1)
        {                 
            while(PIND.7 == 1);
            lcd_putchar('*');
        }
        PORTD.1 = 0;
        delay_ms(20);
        PORTD.2 = 1;
        if(PIND.4 == 1)
        {                 
            while(PIND.4 == 1);
            lcd_putchar('1');
        }
        if(PIND.5 == 1)
        {                 
            while(PIND.5 == 1);
            lcd_putchar('2');
        }
        if(PIND.6 == 1)
        {                 
            while(PIND.6 == 1);
            lcd_putchar('3');
        }
        if(PIND.7 == 1)
        {                 
            while(PIND.7 == 1);
            lcd_putchar('-');
        }
        PORTD.2 = 0;
        delay_ms(20);
        PORTD.3 = 1;
        if(PIND.4 == 1)
        {                 
            while(PIND.4 == 1);
            //lcd_putchar('7'); 
            lcd_clear();
            lcd_gotoxy(0,0);
        }
        if(PIND.5 == 1)
        {                 
            while(PIND.5 == 1);
            lcd_putchar('0');
        }
        if(PIND.6 == 1)
        {                 
            while(PIND.6 == 1);
            lcd_putchar('=');
        }
        if(PIND.7 == 1)
        {                 
            while(PIND.7 == 1);
            lcd_putchar('+');
        }
        PORTD.3 = 0;

      };
}
