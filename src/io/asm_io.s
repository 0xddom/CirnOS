global io_send_byte
; The definition of this function is in 'include/io/io.h'

io_send_byte:
	mov al, [esp + 8]
	mov dx, [esp + 4]
	out dx, al
	ret

