global	ft_write
extern	__errno_location

; Função ft_write
; rdi - Descritor de arquivo
; rsi - Ponteiro para o buffer (dados a serem escritos)
; rdx - Número de bytes a serem escritos
; rax - Valor de retorno (número de bytes escritos ou código de erro)
ft_write:
    mov rax, 1              ; Número da syscall para sys_write
    syscall                 ; Invoca a syscall
    cmp		rax, 0			; compare si le retour du syscall est egal a 0
	jl		error
    ret

error:
	neg		rax			; car le syscall renvoie dans rax errno mais en negatif
	mov		rdi, rax		; rdi sert de tampon car apres rax prendera le retour de errno location
	call	__errno_location	; errno location renvoie un pointeur sur errno dans rax
	mov		[rax], 	rdi		; d'ou ici on met rdi dans errno
	mov		rax, -1			; on met -1 dans rax pour renvoyer la bonne valeur d'un appel a read
	ret				