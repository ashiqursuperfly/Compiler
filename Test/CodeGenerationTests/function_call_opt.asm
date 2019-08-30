.model small
.stack 100H
.data 
fact_return dw ?
n2 dw ?
f2 dw ?
i2 dw ?
t0 dw ?
t1 dw ?
t2 dw ?
t3 dw ?
t4 dw ?
main_return dw ?
n4 dw ?
f4 dw ?
t5 dw ?
t6 dw ?
t7 dw ?
.CODE
fact PROC
	push ax
	push bx 
	push cx 
	push dx
	push n2
	push f2
	push i2
	mov t0,1
	mov ax,t0
	mov f2,ax
	mov ax,n2
	mov i2,ax
L2:
	mov t1,0
	mov ax,i2
	cmp ax,t1
	jg L0
	mov t2,0
	jmp L1
L0:
	mov t2,1
L1:
	mov ax,t2
	cmp ax,0
	je L3
	mov ax,f2
	mov BX,i2
	mul BX
	mov t4, ax
	mov ax,t4
	mov f2,ax
	mov ax,i2
	mov t3,ax
	dec i2
	jmp L2
L3:
	mov ax,f2
	mov fact_return,ax
	jmp L_Return_fact
L_Return_fact:
	pop i2
	pop f2
	pop n2
	pop DX
	pop CX
	pop BX
	pop ax
	ret
fact ENDP
main PROC
	mov ax,@DATA
	mov ds,ax 

	mov t5,6
	mov ax,t5
	mov n4,ax
	mov n2,ax
	call fact
	mov ax,fact_return
	mov t6,ax
	mov f4,ax
	call OUTDEC
	mov t7,0
	mov ax,t7
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
