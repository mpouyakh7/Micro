

;
; hw5_2_1.asm
;
; Created: 12/07/2018 5:29:46 ب.ظ
; Author : mpouya
;


; Replace with your application code

jmp  Start  
.org 0x0002
   jmp ISR;
    

Start:	
     LDI r16,0b00000000
	 out DDRC,r16
	 out portc ,r16
      
      ldi R16,(1 << CS02) | (0 << CS01) | (0 << CS00) | (0 << WGM00) | (0 << WGM01)  ; Set prescalar to 256 and 16 overflow in a second
      out TCCR0,R16 
	
      in r16,TIMSK
      ldi R16, 0x01    
      out TIMSK, R16
	
      ldi R16,0
      sei;
      RJMP LOOP
ISR:
	ldi R17,2
	out TOV0,r17
	in R18,PINc
	ldi R19,0b00000001
	eor R18,R19
	out PORTc,R18
	inc R16
	cpi R16,2
	breq eightMhz
	eight:
	inc R20
	cpi R20,4
	breq fourMhz
	four:
	inc R21
	cpi R21,8
	breq twoMhz
	two:
	reti

eightMhz:
    in R18,PINc
	ldi R19,0b00000010
	eor R18,R19
	out PORTc,R18
	ldi R16,0;
   rjmp eight;

   fourMhz:
    in R18,PINc
	ldi R19,0b00000100
	eor R18,R19
	out PORTc,R18
	ldi R20,0;
   rjmp four;

   twoMhz:
    in R18,PINc
	ldi R19,0b00001000
	eor R18,R19
	out PORTc,R18
	ldi R21,0;
    rjmp two;

LOOP:
    rjmp LOOP
AssemblyCopy