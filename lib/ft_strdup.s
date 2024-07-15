section .text
    global ft_strdup
    extern malloc
    extern ft_strlen
    extern ft_strcpy

ft_strdup:
    mov rdi, rsi
    call ft_strlen
    add rax, 1

    mov rdi, rax
    call malloc

    test rax, rax
    jz malloc_failure

    mov rdi, rax
    mov rsi, rdx
    call ft_strcpy

done:
    ret

malloc_failure:
    xor rax, rax            ; Retornar NULL (rax = 0)
    jmp done