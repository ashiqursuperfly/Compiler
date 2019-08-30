.model small
.stack 100H
.data 
main_return dw ?
i2 dw ?
val2 dw ?
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
a2 dw 20 dup(?)
.CODE
main PROC
	mov ax,@DATA
	mov ds,ax 

	mov t0,0
	mov ax,t0
	mov i2,ax
L2:
	mov t1,15
	mov ax,i2
	cmp ax,t1
	jl L0
	mov t2,0
	jmp L1
L0:
	mov t2,1
L1:
	mov ax,t2
	cmp ax,0
	je L3
	mov BX,i2
	add BX,BX
	mov t4,1
	mov ax,i2
	add ax,t4
	mov t5,ax
	mov a2[BX],ax
	mov ax,i2
	mov t3,ax
	inc i2
	jmp L2
L3:
	mov t6,0
	mov ax,t6
	mov i2,ax
L6:
	mov t7,15
	mov ax,i2
	cmp ax,t7
	jl L4
	mov t8,0
	jmp L5
L4:
	mov t8,1
L5:
	mov ax,t8
	cmp ax,0
	je L7
	mov BX,i2
	add BX,BX
	mov ax,a2[BX]
	mov t10,ax
	mov val2,ax
	call OUTDEC
	mov ax,i2
	mov t9,ax
	inc i2
	jmp L6
L7:
	mov t11,0
	mov ax,t11
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
