.model small
.stack 100H
.data 
main_return dw ?
a2 dw ?
b2 dw ?
t0 dw ?
t1 dw ?
t2 dw ?
c2 dw 3 dup(?)
.CODE
main PROC
	mov ax,@DATA
	mov ds,ax 

	mov t0,120
	mov ax,t0
	mov a2,ax
	mov t1,19
	mov ax,t1
	mov b2,ax
	mov ax,a2
	mov BX,b2
	mov DX,0
	div BX
	mov t2, DX
	mov ax,t2
	mov a2,ax
	mov ax,a2
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
