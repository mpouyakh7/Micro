;
; 7_micro.asm
;
; Created: 01/03/2019 04:14:33 ب.ظ
; Author : mpouya
;



; Replace with your application code

rjmp Start;
.org 0x02
   jmp  EXT_INT0;
   
Start:
   ldi r16,0b11110000;
   out DDRC,r16;
   ldi r16,0b00001111;
   out PORTC,r16;

   ldi r16,0b00000000;
   out DDRD,r16;
   ldi r16,0b00000100;
   out PORTD,r16;
	
   ; Enable INT0
   ldi r16,0b01000000  
   out GICR,r16
   in r16,0b00000010 ; falling edge
   out MCUCR,r16;
	 
   ; Setup USART 
   ldi r16,(1<<RXC)|(1<<TXC)|(1<<UDRE)|(1<<FE)|(1<<DOR)|(1<<PE)|(0<<U2X)|(0<<MPCM)
   out UCSRA,r16

   ldi r16,(0<<RXCIE)|(0<<TXCIE)|(0<<UDRIE)|(1<<RXEN)|(1<<TXEN)|(1<<UCSZ2)|(1<<RXB8)|(1<<TXB8)
   out UCSRB,r16

   ldi r16,(1<<URSEL)|(0<<UMSEL)|(0<<UPM0)|(1<<UPM1)|(0<<USBS)|(1<<UCSZ1)|(1<<UCSZ0)|(0<<UCPOL)
   out UCSRC,r16

   ldi r16,0x01
   out UBRRH,r16

   ldi r16,0xA0
   out UBRRL,r16
   sei

Loop:
   rjmp Loop
    
EXT_INT0:
   call keyFind
 
   Send:
     sbis UCSRA,UDRE
     rjmp Send
     ;copy parity bit to TXB8 
     cbi UCSRB, TXB8
     sbrc R21, 0
     sbi UCSRB, TXB8
     ;copy data to UDR
     out UDR,r20
     reti;
     
keyFind:
   cli
   ldi r17,0b11111111;
   out portc,r17;

   ldi r17,(1<<PC7)|(1<<PC6)|(1<<PC5)|(0<<PC4);
   out portc,r17;
   sbis pinc,0
   ldi r16,'0'
   sbis pinc,1
   ldi r16,'1'
   sbis pinc,2
   ldi r16,'2'
   sbis pinc,3
   ldi r16,'3'
	
   ldi r17,(1<<PC7)|(1<<PC6)|(0<<PC5)|(1<<PC4);
   out portc,r17;
   sbis pinc,0
   ldi r16,'4'
   sbis pinc,1
   ldi r16,'5'
   sbis pinc,2
   ldi r16,'6'
   sbis pinc,3
   ldi r16,'7'
	
   ldi r17,(1<<PC7)|(0<<PC6)|(1<<PC5)|(1<<PC4);
   out portc,r17;
   sbis pinc,0
   ldi r16,'8'
   sbis pinc,1
   ldi r16,'9'
   sbis pinc,2
   ldi r16,'A'
   sbis pinc,3
   ldi r16,'B'
	
   ldi r17,(0<<PC7)|(1<<PC6)|(1<<PC5)|(1<<PC4);
   out portc,r17;
   sbis pinc,0
   ldi r16,'C'
   sbis pinc,1
   ldi r16,'D'
   sbis pinc,2
   ldi r16,'E'
   sbis pinc,3
   ldi r16,'F'
	
   mov r20,r16
   ldi r17,0b00001111;
   out portc,r17;
   reti