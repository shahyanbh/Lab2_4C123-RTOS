;/*****************************************************************************/
; OSasm.s: low-level OS commands, written in assembly                       */
; Runs on LM4F120/TM4C123/MSP432
; Lab 2 starter file
; February 10, 2016
;


        AREA |.text|, CODE, READONLY, ALIGN=2
        THUMB
        REQUIRE8
        PRESERVE8

        EXTERN  RunPt            ; currently running thread
        EXPORT  StartOS
        EXPORT  SysTick_Handler
        IMPORT  Scheduler


SysTick_Handler                ; 1) Saves R0-R3,R12,LR,PC,PSR
    CPSID   I                  ; 2) Prevent interrupt during switch

    CPSIE   I                  ; 9) tasks run with interrupts enabled
    BX      LR                 ; 10) restore R0-R3,R12,LR,PC,PSR

StartOS

    LDR R0, =Runpt
	LDR R1, [R0]
	LDR SP, R1
	POP {R4-R11} ;eight registers first
	POP {R0-R3} ;Four more registers loaded from stack done in even 
	POP {R12}
	ADD SP, SP, #4
	POP {LR}
	ADD SP, SP, #4
	CPSIE   I                  ; Enable interrupts at processor level
    BX      LR                 ; start first thread
	
    ALIGN
    END
