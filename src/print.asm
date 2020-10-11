
%macro print 7
	mov bp, %1
	mov cx, [%2]
	mov bl, %3
	mov al, %4
	mov bh, %5
	mov dh, %6
	mov dl, %7
	mov ah, 13h
	int 10h
%endmacro

%macro print 2
	mov si, %1
	mov cx, [%2]
	call print_string_with_length
	int 10h
%endmacro

print_string_with_length:
	push ax
	push cx
	mov ah, 0x0e
print_char_check_for_length:	
	lodsb
	int 10h
	loop print_char_check_for_length
	pop cx
	pop ax
	ret

%macro print 1
	mov si, %1
	call print_string
%endmacro



print_string:
	push ax
	mov ah, 0x0e

print_char_check_for_terminator:	
	lodsb
	cmp al, 0
	jz print_string_done
	int 10h
	jmp print_char_check_for_terminator	

print_string_done:	
	pop ax
	ret