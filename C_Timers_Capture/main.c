#include <msp430.h> 

int WhatICaptured = 0;
/**
 * main.c
 */
int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	
    // Set up the ports
       P1DIR |= BIT0;              // Set LED1 as output
       P1OUT &= ~BIT0;             // Clear LED1

       P4DIR &= ~BIT1;
       P4REN |= BIT1;
       P4OUT |= BIT1;
       P4IES |= BIT1;              // Setting up switch 1 and its interrupt

       PM5CTL0 &= ~LOCKLPM5;       // Initialize GPIO

       // Set up timers
       TB0CTL |= TBCLR;            // Reset timer
       TB0CTL |= TBSSEL__ACLK;     // Set ACLK as clock
       TB0CTL |= ID__8;            // Divide by 8
       TB0CTL |= MC__CONTINUOUS;   // Set continuous mode


       // IRQ
       P4IE |= BIT1;
       P4IFG &= ~BIT1;
       TB0CCTL0 |= CAP;             // Local enable
       TB0CCTL0 |= CM__BOTH;         // Sensetive to both edges
       TB0CCTL0 |= CCIS__GND;
       __enable_interrupt();        // Enable maskable interrupts


       // Main loop
       while(1){

       }

   }

   // Interrupt Service Routines
#pragma vector = PORT4_VECTOR;
   __interrupt void ISR_PORT4_SW1(void){
       P1OUT ^= BIT0;
       TB0CCTL0 ^= CCIS0;           // Switch between GND and VCC
       WhatICaptured = TB0CCR0;
       P4IFG &= ~BIT1;
   }
