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
;--- Setup LED
			bis.b	#BIT0,	&P1DIR
			bic.b	#BIT0,	&P1OUT
			bic.b	#LOCKLPM5,	&PM5CTL0

;--- Setup Timer B0
			bis.w	#TBCLR,	&TB0CTL				; Clear TB0
			bis.w	#TBSSEL__ACLK,	&TB0CTL 	; Choose CLK TB0
			bis.w	#MC__CONTINUOUS, &TB0CTL	; Put into continuous mode

;--- Setup overflow IRQ
			bis.w	#TBIE,	&TB0CTL				; Local enable for TB0 overflow
			eint								; Enable global for maskables
			bic.w	#TBIFG,	&TB0CTL				; Clear flag for first use

main:
			jmp		main

;-------------------------------------------------------------------------------
; Interrupt Service Routine
;-------------------------------------------------------------------------------

ISR_TB0_Overflow:
			xor.b	#BIT0,	P1OUT
			bic.w	#TBIFG,	&TB0CTL
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
            
			.sect	".int42"
			.short	ISR_TB0_Overflow
