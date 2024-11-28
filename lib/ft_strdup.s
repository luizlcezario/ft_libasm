
global ft_strdup
extern __errno_location
extern malloc
extern ft_strlen
extern ft_strcpy

ft_strdup:
    test rdi, rdi
    jz .renul
    call ft_strlen
    push rdi
    inc rax
    mov rdi, rax
    call malloc  WRT ..plt

    cmp rax, 0
    jz .error 
    mov rdi, rax            ; Colocar o ponteiro retornado por malloc em rdi (destino)
    pop rsi            ; Restaurar o ponteiro original da string de entrada em rsi (fonte)
    call ft_strcpy

.done:
    ret

.error:
    neg rax
    mov rdi, rax
    call __errno_location WRT ..plt
    jmp .renul

.renul:
    xor rax, rax            ; Definir o valor de retorno como NULL (rax = 0)
    jmp .done           