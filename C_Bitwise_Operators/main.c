#include <msp430.h> 


/**
 * main.c
 */
int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	int e = 0b1111111111110000;
	int f = 0x0001;

	while(1){
	    e = ~e;                 // Inverts all bits (0000000000001111)
	    e = e | BIT7;           // Set bit 7        (0000000010001111)
	    e = e & ~BIT0;          // Clear bit 0      (0000000010001110)
	    e = e ^ BIT4;           // Toggle bit 4     (0000000010011110)

	    e |= BIT6;
	    e &= ~BIT1;
	    e ^= BIT3;

	    f = f << 1;
	    f = f << 2;
	    f = f >> 1;
	}

}
