#include <msp430.h> 


/**
 * main.c
 */
int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	// Set up the ports
	P1DIR |= BIT0;              // Config LED1 to output
	P1OUT &= ~BIT0;             // Turn off LED1 initially
	P4DIR &= ~BIT1;             // Config SW1 to input
	P4REN |= BIT1;              // Enable pull up/down resistor
	P4OUT |= BIT1;              // Pull up resistor
	P4IES |= BIT1;              // Makes sensitivity to H-to-L

	PM5CTL0 &= ~LOCKLPM5;       // Turn on digital I/O

	// Set up IRQ
	P4IE |= BIT1;               // Enable P4.1 IRQ
	__enable_interrupt();       // Enable Maskable IRQs
	P4IFG &= ~BIT1;             // Clear P4.1 IRQ flag


	while(1){

	}
}

// -------------- Interrupt service routines -------------- //
#pragma vector = PORT4_VECTOR;
__interrupt void ISR_Port4_S1(void){
    P1OUT ^= BIT0;              // Toggle LED1
    P4IFG &= ~BIT1;             // Clear IRQ flag
}

