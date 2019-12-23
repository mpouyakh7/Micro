


;
; hw5_2_1.asm
;
; Created: 12/07/2018 3:30:26 ب.ظ
; Author : mpouya
;


; Replace with your application code


Start:	
     LDI r16,0b00000000
	 out DDRC,r16
	 out portc ,r16
      
    ldi r16, 0b00011101 ; ctc mode + toggle on output+ clk/1024 ( 4 times a secoond)
    out TCCR0, r16
	
      in r16,TIMSK
      ldi R16, 0x02    
      out TIMSK, R16
	  ;as per frequency formula of ctc we got the value of 31 for OCR0
	  ldi r16,31
	  out OCR0,r16

      ldi R16,0
	  ldi r20,0
	  ldi r21,0
     
 ocf:
	in r22, TIFR
	SBRS R22, OCF0
	JMP ocf

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
	IN R23, TIFR
	SBR R23, OCF0
	OUT TIFR, R23
	rjmp ocf

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

AssemblyCopy