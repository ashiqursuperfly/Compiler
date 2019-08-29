.model small
.stack 100H
.data 
main_return dw ?
x2 dw ?
d2 dw ?
i2 dw ?
t0 dw ?
t1 dw ?
t2 dw ?
t3 dw ?
t4 dw ?
t5 dw ?
t6 dw ?
t7 dw ?
t8 dw ?
.CODE
main PROC
	mov ax,@DATA
	mov ds,ax 

	mov t0,3
	mov ax,t0
	mov x2,ax
	mov t1,4
	mov ax,t1
	mov d2,ax
	mov ax,x2
	mov i2,ax
L2:
	mov t2,15
	mov ax,i2
	cmp ax,t2
	jl L0
	mov t3,0
	jmp L1
L0:
	mov t3,1
L1:
	mov ax,t3
	cmp ax,0
	je L3
	mov ax,i2
	call OUTDEC
	mov ax,i2
	mov t4,ax
	inc i2
	jmp L2
L3:
L6:
	mov t5,0
	mov ax,i2
	cmp ax,t5
	jg L4
	mov t6,0
	jmp L5
L4:
	mov t6,1
L5:
	mov ax,t6
	cmp ax,0
	je L7
	mov ax,i2
	call OUTDEC
	mov ax,i2
	mov t7,ax
	dec i2
	jmp L6
L7:
	mov t8,0
	mov ax,t8
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
