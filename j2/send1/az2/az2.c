#include <mega1280.h>
#include <delay.h>

unsigned char i[] = {0, 0, 0, 0}, j[] = {0b11101011, 0b10001000, 0b10110011, 0b10111010, 0b11011000, 0b01111010, 0b01111011, 0b10101000, 0b11111011, 0b11111010};
int t = 1, k, km = 15;
void main(void)
{
DDRF=0xFF;
DDRK=0xFF;
while (1)
{
for(k = 0; k < km; k++){
PORTF = 0x80;
PORTK = j[i[0]];
delay_ms(t);
PORTF = 0x40;
PORTK = j[i[1]];
delay_ms(t);
PORTF = 0x20;
PORTK = j[i[2]];
delay_ms(t);
PORTF = 0x10;
PORTK = j[i[3]];
delay_ms(t);
}
i[0] += 1;
if(i[0] == 10){
i[0] = 0;
i[1] += 1;
}
if(i[1] == 10){
i[1] = 0;
i[2] += 1;
}
if(i[2] == 10){
i[2] = 0;
i[3] += 1;
}
if(i[3] == 10){
i[0] = 0;
i[1] = 0;
i[2] = 0;
i[3] = 0;
delay_ms(5*t);
}
}
}
