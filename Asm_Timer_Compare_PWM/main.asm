;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

init:
; -- Set up the LED
			bis.b	#BIT0,	&P1DIR
			bis.b	#BIT0,	&P1OUT
			bic.b	#LOCKLPM5,	&PM5CTL0
; -- Set up timer
			bis.w	#TBCLR,	&TB0CTL
			bis.w	#TBSSEL__ACLK, &TB0CTL
			bis.w	#MC__UP,	&TB0CTL
; -- Set up the compares
            mov.w	#32768,	&TB0CCR0
            mov.w	#1638,	&TB0CCR1
; -- Set up IRQs
			bis.w	#CCIE,	&TB0CCTL0		; Set up local enable for CCR0
			bic.w	#CCIFG,	&TB0CCTL0		; Clear CCR0 Flag

			bis.w	#CCIE,	&TB0CCTL1		; Set up local enable for CCR1
			bic.w	#CCIFG,	&TB0CCTL1		; Clear CCR1 Flag

			eint							; Global enable

main:
			jmp 	main

;-------------------------------------------------------------------------------
; ISRs
;-------------------------------------------------------------------------------
ISR_TB0_CCR1:
			bic.b	#BIT0,	&P1OUT
			bic.w	#CCIFG,	&TB0CCTL1
			reti

ISR_TB0_CCR0:
			bis.b	#BIT0,	&P1OUT
			bic.w	#CCIFG,	&TB0CCTL0
			reti

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
			.sect   ".int43"
            .short  ISR_TB0_CCR0

			.sect   ".int42"
            .short  ISR_TB0_CCR1

