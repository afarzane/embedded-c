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
			mov.w	#371,	R4		; Put 371 decimal into R4
			mov.w	#465,	R5		; Put 465 decimal into R5
			add.w	R4,	R5			; R5 = R4 + R5

			mov.w	#0FFFEh,	R6
			add.w	#0001h,	R6		; Use immediate addressing to add 0001h to FFFEh. Dst = R6

			mov.w	#0FFFFh,	R7
			add.w	#1h,	R7		; R7 = R7 + 1

			mov.b	#255,	R8
			mov.b	#1,	R9
			add.b	R8,	R9

			mov.b	#-1,	R10
			add.b	#1,	R10

			mov.b	#127,	R11
			add.b	#127,	R11

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
            
