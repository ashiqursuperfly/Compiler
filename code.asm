.MODEL SMALL
.STACK 100H
.DATA 
x1 dw ?
y1 dw ?
z1 dw ?
a1 dw ?
var_return dw ?
a2 dw ?
b2 dw ?
t0 dw ?
fib_return dw ?
n3 dw ?
a3 dw ?
b3 dw ?
c3 dw ?
i3 dw ?
t1 dw ?
t2 dw ?
t3 dw ?
t4 dw ?
t5 dw ?
t6 dw ?
t7 dw ?
t8 dw ?
main_return dw ?
x5 dw ?
t9 dw ?
c5 dw ?
i5 dw ?
j5 dw ?
d5 dw ?
t10 dw ?
t11 dw ?
t12 dw ?
t13 dw ?
t14 dw ?
t15 dw ?
t16 dw ?
t17 dw ?
t18 dw ?
t19 dw ?
t20 dw ?
t21 dw ?
t22 dw ?
t23 dw ?
t24 dw ?
t25 dw ?
t26 dw ?
t27 dw ?
t28 dw ?
t29 dw ?
t30 dw ?
t31 dw ?
t32 dw ?
t33 dw ?
t34 dw ?
t35 dw ?
t36 dw ?
t37 dw ?
t38 dw ?
t39 dw ?
t40 dw ?
t41 dw ?
a5 dw 2 dup(?)
.CODE
var proc
	PUSH AX
	PUSH BX 
	PUSH CX 
	PUSH DX
	PUSH a
	PUSH b
	mov AX,a2
	add AX,b2
	mov t0,AX
	mov AX,t0
	mov var_return,AX
	jmp L_Return_var
L_Return_var:
	POP b
	POP a
	POP DX
	POP CX
	POP BX
	POP AX
	ret
var ENDP
fib proc
	PUSH AX
	PUSH BX 
	PUSH CX 
	PUSH DX
	PUSH n
	PUSH a3
	PUSH b3
	PUSH c3
	PUSH i3
	mov t1,0
	mov AX,t1
	mov a3,AX
	mov t2,1
	mov AX,t2
	mov b3,AX
	mov t3,0
	mov AX,n3
	CMP AX,t3
	JE Label0
	mov t4,0
	JMP Label1
Label0:
	mov t4,1
Label1:
	mov AX,t4
	CMP AX,0
	JE Label2
	mov AX,a3
	mov fib_return,AX
	jmp L_Return_fib
Label2:
	mov t5,2
	mov AX,t5
	mov i3,AX
Label5:
	mov AX,i3
	CMP AX,n3
	JLE Label3
	mov t6,0
	JMP Label4
Label3:
	mov t6,1
Label4:
	mov AX,t6
	CMP AX,0
	JE Label6
	mov AX,a3
	add AX,b3
	mov t8,AX
	mov AX,t8
	mov c3,AX
	mov AX,b3
	mov a3,AX
	mov AX,c3
	mov b3,AX
	mov AX,i3
	mov t7,AX
	inc i3
	jmp Label5
Label6:
	mov AX,b3
	mov fib_return,AX
	jmp L_Return_fib
L_Return_fib:
	POP i3
	POP c3
	POP b3
	POP a3
	POP n
	POP DX
	POP CX
	POP BX
	POP AX
	ret
fib ENDP
main proc
    mov AX,@DATA
	mov DS,AX 

	mov AX,x5
	mov t9,AX
	inc x5
	mov t10,0
	mov BX,t10
	add BX,BX
	mov t11,1
	mov AX,t11
	mov a5[BX],AX
	mov t12,1
	mov BX,t12
	add BX,BX
	mov t13,5
	mov AX,t13
	mov a5[BX],AX
	mov t14,0
	mov BX,t14
	add BX,BX
	mov AX,a5[BX]
	mov t15,AX
	mov t16,1
	mov BX,t16
	add BX,BX
	mov AX,a5[BX]
	mov t17,AX
	mov AX,t15
	add AX,t17
	mov t18,AX
	mov AX,t18
	mov i5,AX
	mov t19,2
	mov t20,3
	mov AX,t19
	mov BX,t20
	MUL BX
	mov t21, AX
	mov t22,5
	mov t23,3
	mov AX,t22
	mov BX,t23
	mov DX,0
	DIV BX
	mov t24, DX
	mov t25,4
	mov AX,t24
	CMP AX,t25
	JL Label7
	mov t26,0
	JMP Label8
Label7:
	mov t26,1
Label8:
	mov t27,8
	mov AX,t26
	CMP AX,0
	JE Label10
	mov AX,t27
	CMP AX,0
	JE Label10
Label9:
	mov t28,1
	jmp Label11
Label10:
	mov t28,0
Label11:
	mov AX,t21
	add AX,t28
	mov t29,AX
	mov t30,2
	mov AX,t29
	CMP AX,0
	JNE Label13
	mov AX,t30
	CMP AX,0
	JNE Label13
Label12:
	mov t31,0
	jmp Label14
Label13:
	mov t31,1
Label14:
	mov AX,t31
	mov j5,AX
	mov t32,1
	mov t33,2
	mov t34,3
	mov AX,t33
	mov BX,t34
	MUL BX
	mov t35, AX
	mov AX,
	mov a,AX
	mov AX,t35
	mov b,AX
	CALL var
	mov AX,var_return
	mov t36,AX
	mov t37,3.5
	mov t38,2
	mov AX,t37
	mov BX,t38
	MUL BX
	mov t39, AX
	mov AX,t36
	add AX,t39
	mov t40,AX
	mov AX,t40
	mov d5,AX
	mov t41,0
	mov AX,t41
	mov main_return,AX
	jmp L_Return_main
L_Return_main:
	mov AH,4CH
	INT 21H
