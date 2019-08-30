.model small
.stack 100H
.data 
main_return dw ?
a2 dw ?
b2 dw ?
i2 dw ?
c2 dw ?
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

	mov t0,0
	mov ax,t0
	mov b2,ax
	mov t1,1
	mov ax,t1
	mov c2,ax
	mov t2,0
	mov ax,t2
	mov i2,ax
L4:
	mov t3,4
	mov ax,i2
	cmp ax,t3
	jl L0
	mov t4,0
	jmp L1
L0:
	mov t4,1
L1:
	mov ax,t4
	cmp ax,0
	je L5
	mov t6,3
	mov ax,t6
	mov a2,ax
L2:
	mov ax,a2
	mov t7,ax
	dec a2
	mov ax,t7
	cmp ax,0
	je L3
	mov ax,b2
	mov t8,ax
	inc b2
	jmp L2
L3:
	mov ax,i2
	mov t5,ax
	inc i2
	jmp L4
L5:
	mov ax,a2
	call OUTDEC
	mov ax,b2
	call OUTDEC
	mov ax,c2
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
