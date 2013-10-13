; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
    newl db 0dh, 0ah, '$'
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here
    mov ax, 0
  again: 
    push ax
    call printNum
    lea dx, newl
    call printString
    pop ax
    inc ax
    jmp again
    
    sof:        
    mov ax, 4c00h ; exit to operating system.
    int 21h


; prints a number in AX
; bx, cx is saved in the stack
; dx is destroed    
printNum:
  cmp ax, 0
  je printNum0
  push bx
  push cx
  mov bx, 10
  xor cx, cx
  againDivPrint:
  cmp ax, 0
  je startPrintAX
  xor dx, dx
  div BX; ax = ax/10, dx = ax%10
  push dx
  inc cx
  jmp againDivPrint
  startPrintAX:
  pop dx
  add dl, '0'
  call putChar
  loop startPrintAX
  pop cx
  pop bx
  ret
  printNum0:
  mov dl, '0'
  call putChar
  ret   
     
;-------------------------------------------;
    
;-------------------------------------------;
; Sets ah = 01
; Input char into al;
getChar:
	mov ah, 01
	int 21h
	ret
;-------------------------------------------;	
; Sets ah = 02
; Output char from dl
; Sets ah to last char output
putChar:
	mov ah, 02
	int 21h
	ret
;-------------------------------------------;
; Sets ah = 09
; Outputs string from dx
; Sets al = 24h
printString:
	mov ah, 09
	int 21h
	ret
;-------------------------------------------;
        
ends

end start ; set entry point and stop the assembler.
