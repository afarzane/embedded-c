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
		mov.w	#0,	R4
		mov.w	#0,	R5

while1:	; while(Var == 3)
		cmp.w	R4,	Var1					; Var1 - 3 = ?
		jz		end_while1

		inc		R4
		jmp		while1
end_while1:

while2:
		cmp.w	R5,	Var2					; Var1 - 3 = ?
		jz		end_while2

		incd	R5
		jmp		while2
end_while2:


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

 			.data
 			.retain

Var1:		.short	3
Var2:		.short	2



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
            
