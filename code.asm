.MODEL SMALL
.STACK 100H
.DATA 
var_return dw ?
a2 dw ?
b2 dw ?
t0 dw ?
main_return dw ?
x3 dw ?
d3 dw ?
t1 dw ?
c3 dw ?
i3 dw ?
j3 dw ?
t2 dw ?
t3 dw ?
t4 dw ?
a3 dw 2 dup(?)
.CODE
var PROC
	PUSH AX
	PUSH BX 
	PUSH CX 
	PUSH DX
	PUSH a2
	PUSH b2
	MOV AX,a2
	ADD AX,b2
	MOV t0,AX
	MOV AX,t0
	MOV var_return,AX
	JMP L_Return_var
L_Return_var:
	POP b2
	POP a2
	POP DX
	POP CX
	POP BX
	POP AX
	ret
var ENDP
main PROC
    MOV AX,@DATA
	MOV DS,AX 

	MOV t1,3
	MOV AX,t1
	MOV x3,AX
	MOV t2,1
	MOV AX,
	MOV a2,AX
	MOV AX,x3
	MOV b2,AX
	CALL var
	MOV AX,var_return
	MOV t3,AX
	MOV AX,t3
	MOV x3,AX
	MOV t4,0
	MOV AX,t4
	MOV main_return,AX
	JMP L_Return_main
L_Return_main:
	MOV AH,4CH
	INT 21H
