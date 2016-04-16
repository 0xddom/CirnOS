global loader

MAGIC_NUMBER 	equ 0x1badb002
FLAGS 			equ 0x0
CHECKSUM		equ -MAGIC_NUMBER

section .text:
align 4
	dd MAGIC_NUMBER
	dd FLAGS
	dd CHECKSUM

loader:
	mov eax, 0xcafebabe
.loop:
	jmp .loop
