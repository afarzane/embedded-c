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
			; Bit inversion
            mov.b	#10101010b,	R4
            inv.b	R4

			; And instruction
            mov.b	#11110000b,	R5
            and.b	#00111111b,	R5	; Clear bits 6 and 7

            ; Bit masking using And
            mov.b	#00010000b,	R6	; Is bit 7 a 1 or 0??
            and.b	#10000000b,	R6	; If Z flag is activated then the bit is 0

            mov.b	#00010000b,	R7	; Is bit 4 a 1 or 0
            and.b	#00010000b,	R7	; If Z flag is activated then the bit is 0

            ; Bit masking using Or
            mov.b	#11000001b,	R8
            or.b	#00011111b,	R8	; Set lower 5 bits and perserve upper 3 bits

            ; Bit toggling using Xor
            mov.b	#01010101b, R9
            xor.b	#11110000b, R9	; Toggle
            xor.b	#00001111b,	R9	; Toggle

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
            
