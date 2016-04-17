global io_read_byte

io_read_byte:
	mov dx, [esp + 4]
	in al, dx
	ret

