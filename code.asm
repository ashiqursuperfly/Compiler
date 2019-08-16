.MODEL SMALL
.STACK 100H
.DATA 
fib_return dw ?
n1 dw ?
a1 dw ?
b1 dw ?
c1 dw ?
i1 dw ?
t0 dw ?
t1 dw ?
t2 dw ?
t3 dw ?
t4 dw ?
t5 dw ?
t6 dw ?
t7 dw ?
main_return dw ?
t8 dw ?
.CODE
fib PROC
	PUSH AX
	PUSH BX 
	PUSH CX 
	PUSH DX
	PUSH n
	PUSH a1
	PUSH b1
	PUSH c1
	PUSH i1
	MOV t0,0
	MOV AX,t0
	MOV a1,AX
	MOV t1,1
	MOV AX,t1
	MOV b1,AX
	MOV t2,0
	MOV AX,n1
	CMP AX,t2
	JE Label0
	MOV t3,0
	JMP Label1
Label0:
	MOV t3,1
Label1:
	MOV AX,t3
	CMP AX,0
	JE Label2
	MOV AX,a1
	MOV fib_return,AX
	JMP L_Return_fib
Label2:
	MOV t4,2
	MOV AX,t4
	MOV i1,AX
Label5:
	MOV AX,i1
	CMP AX,n1
	JLE Label3
	MOV t5,0
	JMP Label4
Label3:
	MOV t5,1
Label4:
	MOV AX,t5
	CMP AX,0
	JE Label6
	MOV AX,a1
	ADD AX,b1
	MOV t7,AX
	MOV AX,t7
	MOV c1,AX
	MOV AX,b1
	MOV a1,AX
	MOV AX,c1
	MOV b1,AX
	MOV AX,i1
	MOV t6,AX
	INC i1
	JMP Label5
Label6:
	MOV AX,b1
	MOV fib_return,AX
	JMP L_Return_fib
L_Return_fib:
	POP i1
	POP c1
	POP b1
	POP a1
	POP n
	POP DX
	POP CX
	POP BX
	POP AX
	ret
fib ENDP
main PROC
    MOV AX,@DATA
	MOV DS,AX 
	MOV t8,0
	MOV AX,t8
	MOV main_return,AX
	JMP L_Return_main
L_Return_main:
	MOV AH,4CH
	INT 21H
