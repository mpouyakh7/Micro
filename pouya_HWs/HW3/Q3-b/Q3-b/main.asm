;
; Q3-b.asm
;
; Created: 11/15/2018 11:05:25 ب.ظ
; Author : mpouyakh
;


; Replace with your application code
      sbi DDRD,5 ;set port D5 for output
      cbi DDRD,3 ;set port D3 for input
      sbi PORTD,3 ;set port D3 pull up     
      rjmp  Start

	  Start:
      sbic PIND,3
      CBI PORTD,5
      sbis PIND,3
      SBI PORTD,5
      rjmp  Start
