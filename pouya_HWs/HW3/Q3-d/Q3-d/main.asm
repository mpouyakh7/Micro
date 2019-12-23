;
; Q3-d.asm
;
; Created: 11/16/2018 06:31:40 ب.ظ
; Author : mpouya
;


; Replace with your application code
Start:
	RCALL WDTSET
	SBI DDRD,5  
	CBI DDRD,3  
	CBI DDRD,6  
	SBI PORTD,6  
	SBI PORTD,3 
		
MAIN:
	SBIS PIND,3
	SBI  PORTD,5
	SBIS PIND,6
	RCALL WDTReset
	RJMP MAIN

WDTSET:
	SBR r16,15  
	OUT WDTCR,r16
	RET
	
WDTReset:
	 WDR      
	 IN r16, WDTCR
	 ori r16, (1<<WDTOE)|(1<<WDE)
	 OUT WDTCR, r16
	 LDI r16, (0<<WDE) 
	 OUT WDTCR, r16
	 RCALL WDTSET
ret
