.model small
.stack 100H
.data 
max_return dw ?
a2 dw ?
b2 dw ?
t0 dw ?
main_return dw ?
a3 dw ?
b3 dw ?
c3 dw ?
d3 dw ?
e3 dw ?
f3 dw ?
i3 dw ?
t1 dw ?
t2 dw ?
t3 dw ?
t4 dw ?
t5 dw ?
t6 dw ?
t7 dw ?
t8 dw ?
t9 dw ?
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
.CODE
max PROC
	push ax
	push bx 
	push cx 
	push dx
	push a2
	push b2
	mov ax,a2
	cmp ax,b2
	jl L0
	mov t0,0
	jmp L1
L0:
	mov t0,1
L1:
	mov ax,t0
	cmp ax,0
	je L2
	mov ax,b2
	mov max_return,ax
	jmp L_Return_max
	jmp L3
L2:
	mov ax,a2
	mov max_return,ax
	jmp L_Return_max
L3:
L_Return_max:
	pop b2
	pop a2
	pop DX
	pop CX
	pop BX
	pop ax
	ret
max ENDP
main PROC
	mov ax,@DATA
	mov ds,ax 

	mov t1,3
	mov t2,2
	mov ax,t1
	add ax,t2
	mov t3,ax
	mov ax,t3
	mov a3,ax
	mov ax,a3
	call OUTDEC
	mov t4,2
	mov t5,5
	mov ax,t5
	mov BX,a3
	mul BX
	mov t6, ax
	mov ax,t4
	sub ax,t6
	mov t7,ax
	mov t8,7
	mov t9,3
	mov ax,t8
	mov BX,t9
	mov DX,0
	div BX
	mov t10, DX
	mov ax,t7
	add ax,t10
	mov t11,ax
	mov ax,t11
	mov b3,ax
	mov ax,b3
	call OUTDEC
	mov ax,c3
	mov t12,ax
	inc c3
	mov ax,c3
	call OUTDEC
	mov ax,b3
	mov t13,ax
	dec b3
	mov ax,b3
	call OUTDEC
	mov ax,b3
	cmp ax,a3
	jg L4
	mov t14,0
	jmp L5
L4:
	mov t14,1
L5:
	mov ax,c3
	cmp ax,b3
	jg L6
	mov t15,0
	jmp L7
L6:
	mov t15,1
L7:
	mov ax,t14
	cmp ax,0
	jne L9
	mov ax,t15
	cmp ax,0
	jne L9
L8:
	mov t16,0
	jmp L10
L9:
	mov t16,1
L10:
	mov ax,t16
	cmp ax,0
	je L14
	mov t17,1
	mov t18,2
	mov t19,5
	mov ax,t18
	cmp ax,0
	je L12
	mov ax,t19
	cmp ax,0
	je L12
L11:
	mov t20,1
	jmp L13
L12:
	mov t20,0
L13:
	mov ax,t17
	add ax,t20
	mov t21,ax
	mov ax,t21
	mov e3,ax
	mov ax,e3
	call OUTDEC
L14:
	mov t22,0
	mov ax,t22
	mov f3,ax
	mov t23,100
	mov ax,t23
	mov i3,ax
L17:
	mov t24,1
	mov ax,i3
	cmp ax,t24
	jge L15
	mov t25,0
	jmp L16
L15:
	mov t25,1
L16:
	mov ax,t25
	cmp ax,0
	je L18
	mov ax,f3
	mov t27,ax
	inc f3
	mov ax,i3
	mov t26,ax
	dec i3
	jmp L17
L18:
	mov ax,f3
	call OUTDEC
	mov t28,0
	mov ax,t28
	mov f3,ax
L21:
	mov t29,40
	mov ax,i3
	cmp ax,t29
	jg L19
	mov t30,0
	jmp L20
L19:
	mov t30,1
L20:
	mov ax,t30
	cmp ax,0
	je L22
	mov ax,f3
	mov t31,ax
	dec f3
	mov ax,i3
	mov t32,ax
	dec i3
	jmp L21
L22:
	mov ax,f3
	call OUTDEC
	mov t33,10
	mov t34,4
	mov ax,t33
	mov a2,ax
	mov ax,t34
	mov b2,ax
	call max
	mov ax,max_return
	mov t35,ax
	mov ax,t35
	mov f3,ax
	mov ax,f3
	call OUTDEC
L_Return_main:
	mov ah,4CH
	int 21H
OUTDEC PROC  
            push ax 
            push bx 
            push cx 
            push dx  
            cmp ax,0 
            jge BEGIN 
            push ax 
            mov DL,'-' 
            mov ah,2 
            int 21H 
            pop ax 
            neg ax 
            
            BEGIN: 
            xor cx,cx 
            mov bx,10 
            
            REPEAT: 
            xor dx,dx 
            div bx 
            push dx 
            inc cx 
            or ax,ax 
            jne REPEAT 
            mov ah,2 
            
            PRINT_LOOP: 
            pop dx 
            add DL,30H 
            int 21H 
            loop PRINT_LOOP 
            
            mov ah,2
            mov DL,10
            int 21H
            
            mov DL,13
            int 21H
        	
            pop dx 
            pop cx 
            pop bx 
            pop ax 
            ret 
OUTDEC ENDP 
END MAIN
