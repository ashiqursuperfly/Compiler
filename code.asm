.MODEL SMALL
.STACK 100H
.DATA 
main_return dw ?
x1 dw ?
t0 dw ?
t1 dw ?
.CODE
main PROC
    MOV AX,@DATA
	MOV DS,AX 
	MOV AX,x1
	MOV t0,AX
	INC x1
	MOV t1,0
	MOV AX,t1
	MOV main_return,AX
	JMP L_Return_main
L_Return_main:
	MOV AH,4CH
	INT 21H
