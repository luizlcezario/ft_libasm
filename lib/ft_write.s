section .text
    global ft_write
    extern __errno_location

; Função ft_write
; rdi - Descritor de arquivo
; rsi - Ponteiro para o buffer (dados a serem escritos)
; rdx - Número de bytes a serem escritos
; rax - Valor de retorno (número de bytes escritos ou código de erro)
ft_write:
    mov rax, 1              ; Número da syscall para sys_write
    syscall                 ; Invoca a syscall
    cmp rax, -1             ; verificar erro
    jne .done               ; caso nao tenha erro termina 

    ; caso tenha erro coloca esse erro
    mov rdi, fs:[0x18]          ; Obtém o endereço de errno
    mov [rdi], eax              ; Define errno com o valor de erro em rax

    mov rax, -1          
.done:
    ret