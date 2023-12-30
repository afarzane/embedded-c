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
			bis.b	#BIT0,	&P1DIR
			bic.b	#BIT0,	&P1OUT
			bic.b	#LOCKLPM5,	&PM5CTL0

			bis.w	#TBCLR,	&TB0CTL					; Clear TB0 timer
			bis.w	#TBSSEL__ACLK,	&TB0CTL			; Set to ACLK
			bis.w	#MC__CONTINUOUS,	&TB0CTL		; Put into continuous mode
			bis.w	#CNTL_1,	&TB0CTL				; Put into 12-bit mode

			bis.w	#TBIE,	&TB0CTL					; Local enable for timer overflow
			bis.w	#GIE,	SR						; Global enable for maskables
			bic.w	#TBIFG,	&TB0CTL

main:
			jmp		main

;-------------------------------------------------------------------------------
; Interrupt Service Routine
;-------------------------------------------------------------------------------

ISR_TB0_Overflow:
			xor.b	#BIT0,	&P1OUT
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
