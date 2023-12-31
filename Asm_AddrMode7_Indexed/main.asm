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
			mov.w	#Block1,	R4			; Move the address of memory block to R4

			mov.w	0(R4),	8(R4)			; Copy contents of 0x2000 to 0x2008
			mov.w	2(R4),	10(R4)			; Copy contents of 0x2002 to 0x2010
			mov.w	4(R4),	12(R4)			; Copy contetns of 0x2004 to 0x2012
			mov.w	6(R4),	14(R4)			; Copy contents of 0x2006 to 0x2014

			jmp 	main


;-------------------------------------------------------------------------------
; Memory Allocation
;-------------------------------------------------------------------------------

			.data
			.retain

Block1:		.short	0AAAAh,	0BBBBh,	0CCCCh,	0DDDDh	; Create a block of constants
Block2:		.space	8
                                            

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
            
