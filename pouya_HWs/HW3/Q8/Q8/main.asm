;
; Q8.asm
;
; Created: 11/16/2018 10:05:55 ب.ظ
; Author : mpouya
;


; Replace with your application code
    IN R0,0x25
	SWAP R0
	MOV R16,R0
	CBR R16,3
	MOV R0,R16
	BST R0,5
	BRTS BitSet
	BRTC BitClear  

BitSet:
	LDI R16,0x80
	ST  Z,R16
	STD Z+0x10, R0
	RJMP part3

BitClear:
    LSR R0
	LDI R16, 5
	MUL R0,R16
	PUSH R0
	PUSH R1
	RJMP part3

	part3:
	LDI R17,low(RAMEND)
	LDI R18,high(RAMEND)
	OUT SPL,R17
	OUT SPH,R18
	 IN R0,0x25
	SWAP R0
	MOV R16,R0
	CBR R16,3
	MOV R0,R16
	BST R0,5
	LDI R16,0x80
	ST  Z,R16
	STD Z+0x10, R0
	PUSH R0
	LSR R0
	LDI R16, 5
	MUL R0,R16
	PUSH R0
	PUSH R1
	IN R19,SPL
	IN R20,SPH
	