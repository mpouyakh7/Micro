
;
; hw5_2_1.asm
;
; Created: 12/07/2018 7:24:46 ب.ظ
; Author : mpouya
;


; Replace with your application code

      rjmp  Start

Start:
	SBI DDRB,3 ;set b3 for output
	CBI DDRD,6 ;set d6 for input
	CBI DDRD,7 ;set d7 for input
	SBI PORTD,6 ; d6 pullup
	SBI PORTD,7 ; d7 pullup    
	LDI R16,0b01100101 ; pwm with correct phase(WGM01:0=01)+ NonInverting(COM01:0=10) + clk/1024(CS02:0=101)
	OUT TCCR0,R16
	LDI R16,250
	OUT OCR0,R16
	
LOOP:
	SBIS PIND,7
	CALL SlowMode
	SBIS PIND,6
	CALL FastMode
RJMP LOOP
	
FastMode:
	LDI R16,250
	OUT OCR0,R16
	RET
	
SlowMode:
	LDI R16,125
	OUT OCR0,R16
	RET

;====================================================================

AssemblyCopy