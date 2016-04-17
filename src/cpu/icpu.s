; Interface file for calling CPUID from assembly
; This file creates functions that calls CPUID
; and returns the value by reference

global cpu_vendor_name

; [esp - 4] => addr of dest buffer
cpu_vendor_name:
	xor eax, eax
	cpuid
	mov eax, [esp - 4]
	mov [eax], ebx
	mov [eax + 4], ecx
	mov [eax + 8], edx
	ret
	
