
jmp start;
.org INT0addr
jmp  ISR0;
	

start:
	ldi r16,low(RAMEND);
	out SPL,r16;
	ldi r16,high(RAMEND);
	out SPH,r16;
	
	ldi r16,0b11110000;
	out ddrc,r16;
	ldi r16,0b00001111;
	out portc,r16;

	ldi r16,0b11111111;
	out ddrb,r16;
	ldi r16,0b00000000;
	out portb,r16;

	ldi r16,0b00000000;
	out ddrd,r16;
	ldi r16,0b00000100;
	out portd,r16;

	LDI r16, (1<<INT0)
	OUT GICR, r16
	;MCUCR
	LDI r16, (1 << ISC01) | (0 << ISC00) ;  10:falling edge 
	OUT MCUCR, r16
	
	SEI
	 
Loop:
      rjmp  Loop

ISR0:
      call KeyFind
      reti
	 
KeyFind:
	CLI
	ldi r17,0b11111111;
	out portc,r17;

	ldi r17,(1<<PC7)|(1<<PC6)|(1<<PC5)|(0<<PC4);
	out portc,r17;
	sbis pinc,0
	ldi r18,0x3F
	sbis pinc,1
	ldi r18,0x06
	sbis pinc,2
	ldi r18,0x5B
	sbis pinc,3
	ldi r18,0x4F

	ldi r17,(1<<PC7)|(1<<PC6)|(0<<PC5)|(1<<PC4);
	out portc,r17;
	sbis pinc,0
	ldi r18,0x66
	sbis pinc,1
	ldi r18,0x6D
	sbis pinc,2
	ldi r18,0x7D
	sbis pinc,3
	ldi r18,0x07

	 ldi r17,(1<<PC7)|(0<<PC6)|(1<<PC5)|(1<<PC4);
	out portc,r17;
	sbis pinc,0
	ldi r18,0x7F
	sbis pinc,1
	ldi r18,0x6F
	sbis pinc,2
	ldi r18,0x77
	sbis pinc,3
	ldi r18,0x7C

	ldi r17,(0<<PC7)|(1<<PC6)|(1<<PC5)|(1<<PC4);
	out portc,r17;
	sbis pinc,0
	ldi r18,0x61
	sbis pinc,1
	ldi r18,0x5E
	sbis pinc,2
	ldi r18,0x79
	sbis pinc,3
	ldi r18,0x71

mp:	 
	mov r0,r18
	out PORTB,r0
	ldi r17,0b00001111
	out PORTC,r17
	sei
	ret
