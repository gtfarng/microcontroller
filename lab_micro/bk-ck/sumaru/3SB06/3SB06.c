#include<avr/io.h>
int main(void)
{
    DDRC=0x00;
	DDRB=0xFF;
	unsigned char SWITCH_V, DISP;
	unsigned char LOOKUPTB[]={	0b00111111, 
								0b00000110,
								0b01011011, 
								0b01001111,
								0b01100110, 
								0b01101101,
								0b01111101, 
								0b00000111,
								0b01111111, 
								0b01101111,
								0b01110111,
								0b01111100,
								0b00111001, 
								0b01011110,
								0b01111001, 
								0b01110001};
	while(1)
	{
	    SWITCH_V = PINC;
		SWITCH_V &=0x0F;
		DISP= LOOKUPTB[SWITCH_V];
		PORTB = DISP;
	}
}
