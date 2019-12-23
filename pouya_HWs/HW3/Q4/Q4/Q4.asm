;
; Q4.asm
;
; Created: 11/16/2018 07:28:51 ب.ظ
; Author : mpouya
;


; Replace with your application code
	LDI r16,0
	LDI R18, 0x50 ;
	LDI R19, 0x00 ;
	
	LOOP:
	EEPROM_WRITE:
     SBIC EECR, EEWE
      RJMP EEPROM_WRITE
	      OUT EEARL, R18 
	      OUT EEARH, R19 
		  OUT EEDR, R16

		  SBI EECR,EEMWE
		  SBI EECR, EEWE
		  
		  INC R18
		  INC r16
		 
		  CPI R17,9
	      BRNE LOOP
