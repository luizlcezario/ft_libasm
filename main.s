section .data
    msg db "Hello, World!", 0; A string de exemplo terminada em nulo

section .text
    extern ft_strlen, ft_write, ft_read        ; Declarar as funções externas
    global _start               ; Ponto de entrada do programa

_start:
    ; Chamar a função strlen
    lea rdi, [msg]              ; Passar o endereço da string para a função
    call ft_strlen
    ; Agora rax contém o comprimento da string

    ; Chamar a função write
    mov rdi, 1                  ; Descritor de arquivo 1 (stdout)
    lea rsi, [msg]              ; Endereço da string
    mov rdx, rax                ; Comprimento da string
    call ft_write

    ; Sair do programa
    mov rax, 60                 ; syscall: sys_exit
    xor rdi, rdi                ; Código de saída 0
    syscall
