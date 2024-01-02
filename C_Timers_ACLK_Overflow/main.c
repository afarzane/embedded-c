#include <msp430.h> 


/**
 * main.c
 */
int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
	// Set up the ports
	P1DIR |= BIT0;              // Set LED1 as output
	P1OUT &= ~BIT0;             // Clear LED1
	PM5CTL0 &= ~LOCKLPM5;       // Initialize GPIO

	// Set up timers
	TB0CTL |= TBCLR;            // Reset timer
	TB0CTL |= TBSSEL__ACLK;     // Set ACLK as clock
	TB0CTL |= MC__CONTINUOUS;   // Set continuous mode

	// Timer TB0 overflow IRQ
	TB0CTL |= TBIE;             // Local enable
	__enable_interrupt();        // Enable maskable interrupts
	TB0CTL &= ~TBIFG;           // Clear IRQ flag

	// Main loop
	while(1){

	}

}

// Interrupt Service Routines
#pragma vector = TIMER0_B1_VECTOR;
__interrupt void ISR_TB0_Overflow(void){
    P1OUT ^= BIT0;
    TB0CTL &= ~TBIFG;
}

