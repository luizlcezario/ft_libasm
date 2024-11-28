
global	ft_read
extern	__errno_location


; Função ft_read
; rdi - Descritor de arquivo
; rsi - Ponteiro para o buffer onde os dados serão armazenados
; rdx - Número de bytes a serem lidos
; rax - Valor de retorno (número de bytes lidos ou código de erro)
ft_read:
    mov rax, 0                  ; Número da syscall para sys_read
    test rsi, rsi
    jz .input_error
    syscall                     ; Invoca a syscall
    cmp rax, 0                 ; Verifica se houve erro (syscall retorna -1 em caso de erro)
    jl .error                   ; Se não houve erro, salta para .done
    ret

.error:
	neg		rax			; car le syscall renvoie dans rax errno mais en negatif
	mov		rdi, rax		; rdi sert de tampon car apres rax prendera le retour de errno location
	call	__errno_location  WRT ..plt	; errno location renvoie un pointeur sur errno dans rax
	mov		[rax], 	rdi		; d'ou ici on met rdi dans errno
	mov		rax, -1			; on met -1 dans rax pour renvoyer la bonne valeur d'un appel a read
	ret				

.input_error:
    call            __errno_location WRT ..plt              ; rax = &errno
    mov         dword [rax], 22           ; (4 bytes) *rax = EINVAL (Invalid Argument)
    mov		    rax, -1		                     ; rax = 0
    ret                     