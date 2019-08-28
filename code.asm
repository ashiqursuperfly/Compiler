.MODEL SMALL
.STACK 100H
.DATA 
var_return dw ?
a2 dw ?
b2 dw ?
t0 dw ?
main_return dw ?
x3 dw ?
d3 dw ?
t1 dw ?
t2 dw ?
t3 dw ?
.CODE
var PROC
	PUSH ax
	PUSH BX 
	PUSH CX 
	PUSH DX
	PUSH a2
	PUSH b2
	mov ax,a2
	add ax,b2
	mov t0,ax
	mov ax,t0
	mov var_return,ax
	jmp L_Return_var
L_Return_var:
	POP b2
	POP a2
	POP DX
	POP CX
	POP BX
	POP ax
	ret
var ENDP
main PROC
mov AX,@DATA
	mov DS,AX 

	mov t1,1
	mov ax,t1
	mov a2,ax
	mov ax,x3
	mov b2,ax
	CALL var
	mov ax,var_return
	mov t2,ax
	mov ax,t2
	mov x3,ax
	mov t3,0
	mov ax,t3
	mov main_return,ax
	jmp L_Return_main
L_Return_main:
	mov AH,4CH
	int 21H
OUTDEC PROC  
            push AX 
            push BX 
            push CX 
            push DX  
            cmp AX,0 
            jge BEGIN 
            push AX 
            mov DL,'-' 
            mov AH,2 
            int 21H 
            pop AX 
            neg AX 
            
            BEGIN : 
            xor CX,CX 
            mov BX,10 
            
            REPEAT : 
            xor DX,DX 
            div BX 
            push DX 
            inc CX 
            or AX,AX 
            jne REPEAT 
            mov AH,2 
            
            PRINT_LOOP : 
            pop DX 
            add DL,30H 
            int 21H 
            loop PRINT_LOOP 
            
            mov AH,2
            mov DL,10
            int 21H
            
            mov DL,13
            int 21H
        	
            pop DX 
            pop CX 
            pop BX 
            pop AX 
            ret 
        OUTDEC ENDP 
        END MAIN
