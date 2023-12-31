#include <msp430.h> 


/**
 * main.c
 */
int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer

	//  -- Set up the ports
	P1DIR |= BIT0;              // Set LED1 to output
	P1OUT &= ~BIT0;             // Turn off LED1

	P4DIR &= ~BIT1;             // Set switch 1 to input
	P4REN |= BIT1;              // Set up pull up/down resistor
	P4OUT |= BIT1;              // Configure pull up

	PM5CTL0 &= ~LOCKLPM5;        // Turn on digital I/O

	int SW1;
	int i;

	while(1){
	    SW1 = P4IN;             // Read port 4
	    SW1 &= BIT1;            // Clear all bits except SW1

	    if(SW1 == 0){           // If switch is pressed (active low)
	        // P1OUT |= BIT0;      // Turn on LED1
	        P1OUT ^= BIT0;
	    }
	    //else{
	    //    P1OUT &= ~BIT0;
	    //}
	    for(i=0; i<10000; i++){
	        // do nothing (delay)
	    }
	}
	
}
