extrn ExitProcess: PROC
extrn MessageBoxA: PROC
.data
caption db 'Hello World!', 0
message db 'Hello World!!', 0
.code
funct proc
	sub rsp,28h
	mov rcx, 0
	lea rdx, message
	lea r8, caption
	mov r9d, 0
	call MessageBoxA
	mov ecx, eax
	call ExitProcess
funct endp
end