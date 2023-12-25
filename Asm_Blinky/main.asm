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
			bic.w	#0001h, &PM5CTL0		; Disabled the GPIO power-on HighZ
			bis.b	#01h,	&P1DIR			; Setting the P1.0 as an output (P1.0=LED1)

main:
			xor.b	#01h,	&P1OUT			; Toggle P1.0 (LED1)

			mov.w	#0FFFFh,	R4			; Puts a big number in R4 - the 0 infront of the FFFFh is to initialize a hex value

delay:
			dec.w	R4						; Decrement R4
			jnz		delay					; If R4 is not 0 then jump back to delay - creates a loop effect

			jmp		main					; Repeat main loop forever


                                            

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
            
