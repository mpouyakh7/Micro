;
; Q3-jim.asm
;
; Created: 11/16/2018 04:42:55 ب.ظ
; Author : mpouya
;


; Replace with your application code
    SBI DDRD,4 
	CBI DDRD,6  
	SBI PORTD,6
	NOP
program:
	SBIS PIND,6
	RJMP mp
	RJMP program	  
mp:
	LDI r16,10
	LOOP:
	      SBI PORTD,4
	      RCALL Delay
	      CBI PORTD,4
	      RCALL Delay
	      DEC r16
	      BRNE LOOP
	RJMP program
	   
DELAY:
	LDI r17,5
	Delay500ms:
	       LDI r18,100
	Delay100ms:
	       LDI r19,250
	Delay1ms:
	       DEC r19
	       NOP
	BRNE Delay1ms
	DEC r18
	BRNE Delay100ms
	DEC r17
	BRNE Delay500ms
RET