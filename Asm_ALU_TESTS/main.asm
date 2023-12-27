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
			mov.b	#00010000b,	R4
			bit.b	#10000000b,	R4			; If bit 7 is a 0, then the Z flag should be 1... Z = 1
			bit.b	#00010000b,	R4			; If bit 4 is a 1, then the Z flag should be 0... Z = 0

			mov.b	#99,	R5
			cmp.b	#99,	R5				; Check to see if the value in R5 is #99... Z = 1
			cmp.b	#77,	R5				; Check to see if the value in R5 is #77...	Z = 0

			mov.b	#-99,	R6
			tst.b	R6						; See if R6 has a value of 0... Z = 0	N = 1
			mov.b	#0000h,	R7
			tst.b	R7						; See if R7 has a value of 0...	Z = 1	N = 0
			tst.b	R5						; See if R5 has a value of 0...	Z = 0	N = 0

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
            
