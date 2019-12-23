;
; hw6_q1.asm
;
; Created: 12/17/2018 12:35:29 ب.ظ
; Author : mpouya
;
Start:
      sbi DDRD, DDD5	; set output D5
      cbi PORTD, PORTD5
      ldi r16, (1 << ACME)
      out SFIOR, r16    
      ldi r16, (0 << ADEN)
      out ADCSRA, r16
      ldi r16, (0 << MUX2 | 0 << MUX1 | 1 << MUX0)
      out ADMUX, r16
      ldi r16, (0 << ACD | 0 << ACBG | 0 << ACIS0 | 1 << ACIS1)
      sei  
Loop:
      sbic ACSR, 5
      cbi PORTD, 5
      sbis ACSR, 5
      sbi PORTD, 5
      rjmp loop

