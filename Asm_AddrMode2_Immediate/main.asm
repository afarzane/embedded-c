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

			mov.w	#1234h,		R4			; Put 1234h into R4
			mov.w	#0FACEh,	R5			; Put FACEh into R5 - Hex values require a 0 at the beginning

			mov.b	#99h,		R6			; Put 99h into R6
			mov.b	#0EEh,		R7			; Put EEh into R7

			mov.w	#371,		R8			; Put 371 into R8 - Decimal value
			mov.b	#10101010b,	R9			; Put 10101010b into R9 - Binary values have a b
			mov.b	#'B',		R10			; Put 'B' into R10 - 'B' is 42 hex (ASCII values for strings)


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
            
