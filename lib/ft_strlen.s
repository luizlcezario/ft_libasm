section .text
    global ft_strlen

; Função ft_read
; rdi - Ponteiro para a string
; rax - Valor de retorno (número de bytes lidos ou código de erro)
ft_strlen:
    xor rax, rax
.loop:
    cmp byte [rdi + rax], 0
    je .done
    inc rax
    jmp .loop
.done:
    ret
