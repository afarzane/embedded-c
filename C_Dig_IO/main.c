#include <msp430.h> 


/**
 * main.c
 */
int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	// -- Set up ports
	P1DIR |= BIT0;              // Configure P1.0 (LED1) as output
	P1OUT &= ~BIT0;             // Turn off LED1  from the get go
	PM5CTL0 &=  ~LOCKLPM5;      // Turn on GPIO s

	int i = 0;

	while(1){
	    // P1OUT |= BIT0;       // Turn LED1 on
	    // P1OUT &= ~BIT0;      // Turn LED1 off
	    P1OUT ^= BIT0;          //  Toggle LED1
	    for(i=0; i<0xFFFF; i++){
	        // do nothing (delay)
	    }
	}
}
