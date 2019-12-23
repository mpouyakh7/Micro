;
; hw6_q2_jim.asm
;
; Created: 12/17/2018 11:57:19 ب.ظ
; Author : mpouya
;


; Replace with your application code
.equ	LCD_RS	= 1
.equ	LCD_RW	= 2
.equ	LCD_E	= 3

.def	temp	= r16
.def	argument= r17		;argument for calling subroutines
.def	return	= r18		;return value from subroutines

Start:
      ldi temp, low(RAMEND)
      out SPL, temp
      ldi temp, high(RAMEND)
      out SPH, temp
      ldi r16, 0xFF
      out DDRC, r16
      ldi r16, (1<<ADEN)|(1<<ADPS2)|(1<<ADPS1)|(0<<ADPS0)
      out ADCSRA, r16
      ldi r16, (1<<REFS0)| (0<<REFS1)| (1<<MUX0) | (0<<MUX1)|(0<<MUX2)|(0<<MUX3)|(0<<MUX4)
      out ADMUX, r16
      
loop:
   rcall LCD_init
   sbi  ADCSRA, ADSC       
while:
   sbic ADCSRA, ADSC       
   rjmp while
   
   in   r17, ADCL
   in   r2, ADCH
   out	PORTC,r1

	cpi r17,0x0a
	brlo DISPLAY_ON_LCD10
	cpi r17,0x14
	brlo DISPLAY_ON_LCD20
	cpi r17,0x1e
	brlo DISPLAY_ON_LCD30
	cpi r17,0x28
	brlo DISPLAY_ON_LCD40
	cpi r17,0x32
	brlo DISPLAY_ON_LCD50
	cpi r17,0x3c
	brlo DISPLAY_ON_LCD60
	cpi r17,0x46
	brlo DISPLAY_ON_LCD70
	cpi r17,0x50
	brlo DISPLAY_ON_LCD80
	cpi r17,0x64
	//brlo DISPLAY_ON_LCD90
	//cpi r17,0x64
//	brlo Display_on_lcd100
	rjmp loop

	DISPLAY_ON_LCD10:
	ldi argument,'1'
	call lcd_putchar
	ldi argument,'0'
	call lcd_putchar
	   rcall LCD_wait
	rjmp loop

DISPLAY_ON_LCD20:
	ldi argument,'2'
	call lcd_putchar
	ldi argument,'0'
	call lcd_putchar
	   rcall LCD_wait

	rjmp loop

DISPLAY_ON_LCD30:
	ldi argument,'3'
	call lcd_putchar
	ldi argument,'0'
	call lcd_putchar
	   rcall LCD_wait

	rjmp loop

DISPLAY_ON_LCD40:
	ldi argument,'4'
	call lcd_putchar
	ldi argument,'0'
	call lcd_putchar
	   rcall LCD_wait

	rjmp loop

DISPLAY_ON_LCD50:
	ldi argument,'5'
	call lcd_putchar
	ldi argument,'0'
	call lcd_putchar
	   rcall LCD_wait

	rjmp loop

DISPLAY_ON_LCD60:
	ldi argument,'6'
	call lcd_putchar
	ldi argument,'0'
	call lcd_putchar
	   rcall LCD_wait

	rjmp loop

DISPLAY_ON_LCD70:
	ldi argument,'7'
	call lcd_putchar
	ldi argument,'0'
	call lcd_putchar
	   rcall LCD_wait

	rjmp loop

DISPLAY_ON_LCD80:
	ldi argument,'8'
	call lcd_putchar
	ldi argument,'0'
	call lcd_putchar
	   rcall LCD_wait

	rjmp loop

DISPLAY_ON_LCD100:
	ldi argument,'9'
	call lcd_putchar
	ldi argument,'0'
	call lcd_putchar
	   rcall LCD_wait

	rjmp loop

lcd_command8:	;used for init (we need some 8-bit commands to switch to 4-bit mode!)
	in	temp, DDRC		;we need to set the high nibble of DDRC while leaving
					;the other bits untouched. Using temp for that.
	sbr	temp, 0b11110000	;set high nibble in temp
	out	DDRC, temp		;write value to DDRC again
	in	temp, PortC		;then get the port value
	cbr	temp, 0b11110000	;and clear the data bits
	cbr	argument, 0b00001111	;then clear the low nibble of the argument
					;so that no control line bits are overwritten
	or	temp, argument		;then set the data bits (from the argument) in the
					;Port value
	out	PortC, temp		;and write the port value.
	sbi	PortC, LCD_E		;now strobe E
	nop
	nop
	nop
	cbi	PortC, LCD_E
	in	temp, DDRC		;get DDRC to make the data lines input again
	cbr	temp, 0b11110000	;clear data line direction bits
	out	DDRC, temp		;and write to DDRC
ret

lcd_putchar:
	push	argument		;save the argmuent (it's destroyed in between)
	in	temp, DDRC		;get data direction bits
	sbr	temp, 0b11110000	;set the data lines to output
	out	DDRC, temp		;write value to DDRC
	in	temp, PortC		;then get the data from PortC
	cbr	temp, 0b11111110	;clear ALL LCD lines (data and control!)
	cbr	argument, 0b00001111	;we have to write the high nibble of our argument first
					;so mask off the low nibble
	or	temp, argument		;now set the argument bits in the Port value
	out	PortC, temp		;and write the port value
	sbi	PortC, LCD_RS		;now take RS high for LCD char data register access
	sbi	PortC, LCD_E		;strobe Enable
	nop
	nop
	nop
	cbi	PortC, LCD_E
	pop	argument		;restore the argument, we need the low nibble now...
	cbr	temp, 0b11110000	;clear the data bits of our port value
	swap	argument		;we want to write the LOW nibble of the argument to
					;the LCD data lines, which are the HIGH port nibble!
	cbr	argument, 0b00001111	;clear unused bits in argument
	or	temp, argument		;and set the required argument bits in the port value
	out	PortC, temp		;write data to port
	sbi	PortC, LCD_RS		;again, set RS
	sbi	PortC, LCD_E		;strobe Enable
	nop
	nop
	nop
	cbi	PortC, LCD_E
	cbi	PortC, LCD_RS
	in	temp, DDRC
	cbr	temp, 0b11110000	;data lines are input again
	out	DDRC, temp
ret

lcd_command:	;same as LCD_putchar, but with RS low!
	push	argument
	in	temp, DDRC
	sbr	temp, 0b11110000
	out	DDRC, temp
	in	temp, PortC
	cbr	temp, 0b11111110
	cbr	argument, 0b00001111
	or	temp, argument

	out	PortC, temp
	sbi	PortC, LCD_E
	nop
	nop
	nop
	cbi	PortC, LCD_E
	pop	argument
	cbr	temp, 0b11110000
	swap	argument
	cbr	argument, 0b00001111
	or	temp, argument
	out	PortC, temp
	sbi	PortC, LCD_E
	nop
	nop
	nop
	cbi	PortC, LCD_E
	in	temp, DDRC
	cbr	temp, 0b11110000
	out	DDRC, temp
ret

LCD_getchar:
	in	temp, DDRC		;make sure the data lines are inputs
	andi	temp, 0b00001111	;so clear their DDR bits
	out	DDRC, temp
	sbi	PortC, LCD_RS		;we want to access the char data register, so RS high
	sbi	PortC, LCD_RW		;we also want to read from the LCD -> RW high
	sbi	PortC, LCD_E		;while E is high
	nop
	in	temp, PinC		;we need to fetch the HIGH nibble
	andi	temp, 0b11110000	;mask off the control line data
	mov	return, temp		;and copy the HIGH nibble to return
	cbi	PortC, LCD_E		;now take E low again
	nop				;wait a bit before strobing E again
	nop	
	sbi	PortC, LCD_E		;same as above, now we're reading the low nibble
	nop
	in	temp, PinC		;get the data
	andi	temp, 0b11110000	;and again mask off the control line bits
	swap	temp			;temp HIGH nibble contains data LOW nibble! so swap
	or	return, temp		;and combine with previously read high nibble
	cbi	PortC, LCD_E		;take all control lines low again
	cbi	PortC, LCD_RS
	cbi	PortC, LCD_RW
ret					;the character read from the LCD is now in return

LCD_getaddr:	;works just like LCD_getchar, but with RS low, return.7 is the busy flag
	in	temp, DDRC
	andi	temp, 0b00001111
	out	DDRC, temp
	cbi	PortC, LCD_RS
	sbi	PortC, LCD_RW
	sbi	PortC, LCD_E
	nop
	in	temp, PinC
	andi	temp, 0b11110000
	mov	return, temp
	cbi	PortC, LCD_E
	nop
	nop
	sbi	PortC, LCD_E
	nop
	in	temp, PinC
	andi	temp, 0b11110000
	swap	temp
	or	return, temp
	cbi	PortC, LCD_E
	cbi	PortC, LCD_RW
ret

LCD_wait:				;read address and busy flag until busy flag cleared
	rcall	LCD_getaddr
	andi	return, 0x80
	brne	LCD_wait
	ret


LCD_delay:
	clr	r2
	LCD_delay_outer:
	clr	r3
		LCD_delay_inner:
		dec	r3
		brne	LCD_delay_inner
	dec	r2
	brne	LCD_delay_outer
ret

LCD_init:
	
	ldi	temp, 0b00001110	;control lines are output, rest is input
	out	DDRC, temp
	
	rcall	LCD_delay		;first, we'll tell the LCD that we want to use it
	ldi	argument, 0x20		;in 4-bit mode.
	rcall	LCD_command8		;LCD is still in 8-BIT MODE while writing this command!!!

	rcall	LCD_wait
	ldi	argument, 0x28		;NOW: 2 lines, 5*7 font, 4-BIT MODE!
	rcall	LCD_command		;
	
	rcall	LCD_wait
	ldi	argument, 0x0F		;now proceed as usual: Display on, cursor on, blinking
	rcall	LCD_command
	
	rcall	LCD_wait
	ldi	argument, 0x01		;clear display, cursor -> home
	rcall	LCD_command
	
	rcall	LCD_wait
	ldi	argument, 0x06		;auto-inc cursor
	rcall	LCD_command
ret
