; multi-segment executable file template.

data segment
    divider db 4
    heightY dw 100
    widthX dw 100
    lengthS dw 5
    stPosX dw 500
    stPosY dw 500
    color db 1011b
    temp dw 0
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

   mov ax, 4F02h
   mov bx, 107h
   ;mov al, 12h
   ;mov ah, 00h
    int 10h     ; set graphics video mode.
	mov al, color
	mov cx, stPosX
	mov dx, stPosY
	squareAgain:
	 call drawHorizon
	 add lengthS, 1
	 call drawVertical
	 call drawHorizonOther 
	 add lengthS, 1
	 call drawVerticalOther
	 mov ax, temp
	 div divider
	 cmp ah, 0
	 jne contWOdiv
	 inc color
	 contWOdiv:
	 mov al, color
	 inc temp
	 cmp cx, 5
	 jnl squareAgain
	 
	
   
   sof:
    
    mov ax, 4c00h ; exit to operating system.
    int 21h
    
	
	; draws at cx [X]
	; draws at dx [Y]
	; size at lengthS
	drawHorizon:
	mov ah, 0ch
	mov bx, cx
	add bx, lengthS
	 againHorizon:
	 cmp cx, bx
	 je endDrawHorizon
     int 10h
     inc cx
     jmp againHorizon
	endDrawHorizon:
	ret
	
	drawHorizonOther:
	mov ah, 0ch
	mov bx, cx
	sub bx, lengthS
	 againHorizonOther:
	 cmp cx, bx
	 je endDrawHorizonOther
     int 10h
     dec cx
     jmp againHorizonOther
	endDrawHorizonOther:
	ret
	
	drawVertical:
	mov ah, 0ch
	mov bx, dx
	add bx, lengthS
	 againVertical:
	 cmp dx, bx
	 je endDrawVertical
     int 10h
     inc dx
     jmp againVertical
	
	endDrawVertical:
	ret
	
	drawVerticalOther:
	mov ah, 0ch
	mov bx, dx
	sub bx, lengthS
	 againVerticalOther:
	 cmp dx, bx
	 je endDrawVerticalOther
     int 10h
     dec dx
     jmp againVerticalOther
	
	endDrawVerticalOther:
	ret
	
	
	
    ; startPos X
    ; starPos Y
    ; width - x
    ; height - y
    ; color to al
    drawSquare:
    ;mov al, color
    mov ah, 0ch
    mov cx, stPosX
    mov dx, stPosY
    
    ; cx changes
    upLine:
    mov bx, stPosX
    add bx, widthX
    upLineAgain:
    cmp cx, bx
    je rightLine
    int 10h
    inc cx
    jmp upLineAgain
    
    rightLine:
    mov bx, stPosY
    add bx, heightY
    rightLineAgain:
    cmp dx, bx
	je downLine
	int 10h
	inc dx
	jmp rightLineAgain
	
	downLine:
	mov bx, stPosX
	downLineAgain:
	cmp cx, bx
	je leftLine
	int 10h
	dec cx
	jmp downLineAgain
	
	leftLine:
	mov bx, stPosY
	leftLineAgain:
	cmp dx, bx
	je endSquareDraw
	int 10h
	dec dx
	jmp leftLineAgain
	endSquareDraw:
    ret
    
    
    
    getChar:
      push ax
      mov ah, 01
      int 21h
      cmp al, 0dh
      je stopIt
      pop ax
      ret
      
    stopIt:
    jmp sof
        
ends

end start ; set entry point and stop the assembler.
