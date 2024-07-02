section .text
    global write

; Função write
; rdi - Descritor de arquivo
; rsi - Ponteiro para o buffer (dados a serem escritos)
; rdx - Número de bytes a serem escritos
; rax - Valor de retorno (número de bytes escritos ou código de erro)
write:
    mov rax, 1              ; Número da syscall para sys_write
    syscall                 ; Invoca a syscall
    cmp rax, -1             ; verificar erro
    jne .done               ; caso nao tenha erro termina 

    ; caso tenha erro coloca esse erro
    extern __errno_location
    call __errno_location
    mov [rax], rdi

.done:
    ret