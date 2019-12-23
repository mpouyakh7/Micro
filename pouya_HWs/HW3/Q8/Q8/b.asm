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
	BRTC BitClear  

BitClear:
    LSR R0
	LDI R16, 5
	MUL R0,R16
	PUSH R0
	PUSH R1
