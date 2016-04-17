global io_send_byte

io_send_byte:
	mov al, [esp + 8]
	mov dx, [esp + 4]
	out dx, al
	ret


