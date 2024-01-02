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
       TB0CTL |= MC__UP;           // Set up mode
       TB0CCR0 = 32768;
       TB0CCR1 = 1638;


       // Timer TB0 overflow IRQ
       TB0CCTL0 |= CCIE;             // Local enable
       TB0CCTL1 |= CCIE;
       __enable_interrupt();        // Enable maskable interrupts
       TB0CCTL0 &= ~CCIFG;           // Clear IRQ flag
       TB0CCTL1 &= ~CCIFG;

       // Main loop
       while(1){

       }

   }

   // Interrupt Service Routines
   #pragma vector = TIMER0_B0_VECTOR;
   __interrupt void ISR_TB0_CCR0(void){
       P1OUT |= BIT0;
       TB0CCTL0 &= ~CCIFG;
   }

    #pragma vector = TIMER0_B1_VECTOR;
   __interrupt void ISR_TB0_CCR1(void){
       P1OUT &= ~BIT0;
       TB0CCTL1 &= ~CCIFG;
   }
