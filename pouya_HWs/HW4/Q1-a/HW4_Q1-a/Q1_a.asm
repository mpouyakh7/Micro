;
; HW4_Q1-a.asm
;
; Created: 11/21/2018 03:24:50 ب.ظ
; Author : mpouya
;


; Replace with your application code
jmp start
.org 0x004  ;INT1addr
jmp ISR1

start:
	CLI
	SBI DDRD,5 
	CBI DDRD,3 
	SBI PORTD,3     
	
	LDI r16, (1<<INT1)
	OUT GICR, r16

	LDI r16, (1 << ISC11) | (0 << ISC10) ;  10:falling edge 
	OUT MCUCR, r16
	ldi r24, 0x01
	 SEI
	
loop:
	
	rjmp loop

ISR1:
	CLI
	CPI r24,0x01
	BREQ LED_ON
	RCALL LED_OFF
	mp:
	SEI
	RETI
	
LED_ON:
	INC r24
	SBI PORTD,5
	RJMP mp
	
LED_OFF:
	DEC r24
	CBI PORTD,5
	ret