.model small
.stack 100H
.data 
f_return dw ?
a2 dw ?
t0 dw ?
t1 dw ?
t2 dw ?
g_return dw ?
a3 dw ?
b3 dw ?
x3 dw ?
t3 dw ?
t4 dw ?
t5 dw ?
main_return dw ?
a4 dw ?
b4 dw ?
t6 dw ?
t7 dw ?
t8 dw ?
t9 dw ?
.CODE
f PROC
	push ax
	push bx 
	push cx 
	push dx
	push a2
	mov t0,2
	mov ax,t0
	mov BX,a2
	mul BX
	mov t1, ax
	mov ax,t1
	mov f_return,ax
	jmp L_Return_f
	mov t2,9
	mov ax,t2
	mov a2,ax
L_Return_f:
	pop a2
	pop DX
	pop CX
	pop BX
	pop ax
	ret
f ENDP
g PROC
	push ax
	push bx 
	push cx 
	push dx
	push a3
	push b3
	push x3
	mov ax,a3
	mov a2,ax
	call f
	mov ax,f_return
	mov t3,ax
	add ax,a3
	mov t4,ax
	add ax,b3
	mov t5,ax
	mov x3,ax
	mov g_return,ax
	jmp L_Return_g
L_Return_g:
	pop x3
	pop b3
	pop a3
	pop DX
	pop CX
	pop BX
	pop ax
	ret
g ENDP
main PROC
	mov ax,@DATA
	mov ds,ax 

	mov t6,1
	mov ax,t6
	mov a4,ax
	mov t7,2
	mov ax,t7
	mov b4,ax
	mov ax,a4
	mov a3,ax
	mov ax,b4
	mov b3,ax
	call g
	mov ax,g_return
	mov t8,ax
	mov a4,ax
	call OUTDEC
	mov t9,0
	mov ax,t9
	mov main_return,ax
	jmp L_Return_main
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
