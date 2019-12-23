;
; Q5.asm
;
; Created: 11/16/2018 07:58:20 ب.ظ
; Author : mpouya
;


; Replace with your application code

rjmp  Start
.cseg
   BCDTo7_Seg: .db 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D,0x5F, 0x07, 0x7F, 0x6F
   
   Start:
	ldi r16,low(BCDTo7_Seg);
	out SPL,r16;
	ldi r16,high(BCDTo7_Seg);
	out SPH,r16;
	nop
	ldi r16,0b11111111;
	out DDRB,r16;
   rjmp Start
	
