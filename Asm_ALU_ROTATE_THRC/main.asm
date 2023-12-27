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

main:
			mov.b	#00000001b,	R4
			clrc							; Clear the carry
			rlc.b	R4
			rlc.b	R4
			rlc.b	R4
			rlc.b	R4
			rlc.b	R4
			rlc.b	R4
			rlc.b	R4
			rlc.b	R4						; Rotate left 8 times to get it into the carry
			rlc.b	R4						; Rotate left again to make sure it does rotate around

			mov.b	#10000000b,	R4
			clrc							; Clear the carry
			rrc.b	R4
			rrc.b	R4
			rrc.b	R4
			rrc.b	R4
			rrc.b	R4
			rrc.b	R4
			rrc.b	R4
			rrc.b	R4						; Rotate right 8 times to get it into the carry
			rrc.b	R4						; Rotate right again to make sure it does rotate around

			jmp		main

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
            
