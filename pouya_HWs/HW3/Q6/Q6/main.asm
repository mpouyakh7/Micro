;
; Q6.asm
;
; Created: 11/16/2018 08:36:39 ب.ظ
; Author : mpouya
;


; Replace with your application code

LDI R16, 0
	LDI R17, 0
	LDI R18, 0x50 ;
	LDI R19, 0x00 ;

	LDI r20,0b11111111;
      OUT DDRB,r20;
	  LDI r20,0b00000000;
      OUT PORTB,r20
	
     
EEWrite_ARR1:
	SBIC EECR, EEWE
	RJMP EEWrite_ARR1
	OUT EEARL, R18 ;
	OUT EEARH, R19 ;
	OUT EEDR, R16 ;
	SBI EECR, EEMWE
	SBI EECR, EEWE
	INC R16
	INC R18
	INC R17
	CPI R17,10
	BRNE EEWrite_ARR1
	
	LDI R16, 0
	LDI R17, 0
	LDI R18, 0x50 ;
	LDI R19, 0x00 ;
	
EERead_ARR1:
	SBIC EECR, EEWE
	RJMP EERead_ARR1
	OUT EEARL,R18 
	OUT EEARH,R19 

	call delay
	IN  r22,EEDR 
	SBI EECR,EERE

    OUT PORTB,r22
	INC R16
	INC R18
	CPI R16,10
	BRNE EERead_ARR1
	
	delay:
	LDI r17,4
	Delay1:
	   LDI r18,125
	Delay2:
	   LDI r19,250
	Delay3:
	   DEC r19
	   NOP
	   BRNE Delay3
	   DEC r18
	   BRNE Delay2
	   DEC r17
	   BRNE Delay1
	ret
	