
global	ft_write

extern	__errno_location

; Função ft_write
; rdi - Descritor de arquivo
; rsi - Ponteiro para o buffer (dados a serem escritos)
; rdx - Número de bytes a serem escritos
; rax - Valor de retorno (número de bytes escritos ou código de erro)
ft_write:
    mov rax, 1              ; Número da syscall para sys_write
    test rsi, rsi
    jz .error
    syscall                 ; Invoca a syscall
    cmp		rax, 0			
	jl		.error
    ret

.error:
	neg		rax			
	mov		rdi, rax	
    call 	__errno_location WRT ..plt
	mov       dword [rax], 22 
	mov		rax, -1
	ret				