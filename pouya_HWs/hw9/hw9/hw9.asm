;
; hw9.asm
;
; Created: 01/18/2019 08:06:12 ب.ظ
; Author : mpouya
;


; Replace with your application code
;====================================================================
; Main.asm file generated by New Project wizard
;
; Created:   Tue Jan 2 2018
; Processor: ATmega16
; Compiler:  AVRASM (Proteus)
;====================================================================

;====================================================================
; DEFINITIONS
;====================================================================

;====================================================================
; VARIABLES
;====================================================================

;====================================================================
; RESET and INTERRUPT VECTORS
;====================================================================
rjmp start
.org 0x04
   jmp ISR1

    
start:
      cli
	 

     
      ldi r16, (1 << ISC11 | 0 << ISC10)
      out MCUCR, r16
      ldi r16, (1 << INT1)
      out GICR, r16
      sei
Loop:
      rjmp  Loop

SetOut:
      ldi r18, 0xFF
      out DDRA, r18
SetOut1: 
      cpi r20, 0x01
      brne SetOut2
      ldi r18, 0x06
      out PORTA, r18
SetOut2:
      cpi r20, 0x02
      brne SetOut3
      ldi r18, 0x5B
      out PORTA, r18
SetOut3:
      cpi r20, 0x04
      brne SetOut4
      ldi r18, 0x4F
      out PORTA, r18
SetOut4:
      cpi r20, 0x08
      brne SetOut5
      ldi r18, 0x66
      out PORTA, r18
SetOut5:
      cpi r20, 0x10
      brne SetOut6
      ldi r18, 0x6D
      out PORTA, r18
SetOut6:
      cpi r20, 0x20
      brne SetOut7
      ldi r18, 0xFD
      out PORTA, r18
SetOut7:
      cpi r20, 0x40
      brne SetOut8
      ldi r18, 0x07
      out PORTA, r18
SetOut8:
      cpi r20, 0x80
      brne label
      ldi r18, 0xFF
      out PORTA, r18
      label:     
      ret
  
R_INPUT:
     ; in r17, PINB
     ; cpi r17, 0x30
	  sbis PINB,PB0
	  sbic PINB,pb1
      rjmp next1
      cbi PORTB,2
	  cbi PORTB,3
	  sbi PORTB,6
      nop
	  rjmp next3
	  next1:
	 ;; cpi r17, 0xB0
	  sbis PINB,PB0
	  sbis PINB,PB1
      rjmp next2
      sbi PORTB,2
	  cbi PORTB,3
	  sbi PORTB,5
	  nop
	  rjmp next3
	  next2:
	  sbic PINB,PB0
	  sbic PINB,PB1
	  rjmp next3
      cbi PORTB,2
	  sbi PORTB,3
	  sbi PORTB,4
	  nop
	  next3:
      in r20, PINA
      com r20   
      ret

ISR1:
      cli
        ldi r16, 0x00
      out DDRA, r16
    
      ldi r16, 0x3f
      out DDRB, r16
     
      ldi r16, 0x30
      out PORTB, r16

      call R_INPUT
      call SetOut
      sei
	   
      ret
       
