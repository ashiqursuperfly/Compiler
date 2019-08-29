.model small
.stack 100H
.data 
main_return dw ?
a2 dw ?
b2 dw ?
t0 dw ?
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
c2 dw 3 dup(?)
.CODE
main PROC
	mov ax,@DATA
	mov ds,ax 

	mov t0,1
	mov t1,2
	mov t2,3
	mov ax,t1
	add ax,t2
	mov t3,ax
	mov ax,t0
	mov BX,t3
	mul BX
	mov t4, ax
	mov t5,3
	mov ax,t4
	mov BX,t5
	mov DX,0
	div BX
	mov t6, DX
	mov ax,t6
	mov a2,ax
	mov t7,1
	mov t8,5
	mov ax,t7
	cmp ax,t8
	jl L0
	mov t9,0
	jmp L1
L0:
	mov t9,1
L1:
	mov ax,t9
	mov b2,ax
	mov t10,0
	mov BX,t10
	add BX,BX
	mov t11,2
	mov ax,t11
	mov c2[BX],ax
	mov ax,a2
	cmp ax,0
	je L3
	mov ax,b2
	cmp ax,0
	je L3
L2:
	mov t12,1
	jmp L4
L3:
	mov t12,0
L4:
	mov ax,t12
	cmp ax,0
	je L5
	mov ax,c2[BX]
	mov t14,ax
	mov ax,c2[BX]
	inc ax
	mov c2[BX],ax
	jmp L6
L5:
	mov t15,1
	mov BX,t15
	add BX,BX
	mov t16,0
	mov BX,t16
	add BX,BX
	mov ax,c2[BX]
	mov t17,ax
	mov ax,t17
	mov c2[BX],ax
L6:
	mov ax,a2
	call OUTDEC
	mov ax,b2
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
