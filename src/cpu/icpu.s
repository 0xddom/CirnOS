; Interface file for calling CPUID from assembly
; This file creates functions that calls CPUID
; and returns the value by reference

global cpu_vendor_name

; [esp - 4] => addr of dest buffer
cpu_vendor_name:
	push ebp
	mov ebp, esp
	xor eax, eax
	cpuid
	mov eax, [ebp + 8]
	mov [eax], ebx
	mov [eax + 4], edx
	mov [eax + 8], ecx
	pop ebp
	ret
	
