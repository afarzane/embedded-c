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
			bis.b	#BIT0,	&P1DIR			; Sets P1.0 to output (LED1)
			bic.b	#BIT0,	&P1OUT			; Clear LED1 initially

			bic.b	#BIT1,	&P4DIR			; Set P4.1 to input (S1
			bis.b	#BIT1,	&P4REN			; Enable pull up/down resistor
			bis.b	#BIT1,	&P4OUT			; Pull up configuration
			bis.b	#BIT1,	&P4IES			; Sensitivity is High to Low

			bic.b	#LOCKLPM5,	&PM5CTL0	; Enable digital I/O

			bic.b	#BIT1,	&P4IFG			; Clear interrupt flag for switch
			bis.b	#BIT1,	&P4IE			; Local enable for P4.1
			eint							; Enable global maskables

main:

			jmp		main

;-------------------------------------------------------------------------------
; Interrupt Service Routines
;-------------------------------------------------------------------------------

ISR_S1:
			xor.b	#BIT0,	&P1OUT			; Toggle LED1
			bic.b	#BIT1,	&P4IFG			; Clear interrupt flag
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
            
            .sect	".int22"				; Port 4 vector address
            .short	ISR_S1
