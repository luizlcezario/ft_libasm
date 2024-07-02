section .text
    global ft_read

; Função ft_read
; rdi - Descritor de arquivo
; rsi - Ponteiro para o buffer onde os dados serão armazenados
; rdx - Número de bytes a serem lidos
; rax - Valor de retorno (número de bytes lidos ou código de erro)
ft_read:
    mov rax, 0                  ; Número da syscall para sys_read
    syscall                     ; Invoca a syscall
    cmp rax, -1                 ; Verifica se houve erro (syscall retorna -1 em caso de erro)
    jne .done                   ; Se não houve erro, salta para .done

    ; Configura errno em caso de erro
    extern __errno_location
    call __errno_location       ; Obtém o endereço da variável errno
    mov [rax], rdi              ; Armazena o código de erro em errno

.done:
    ret                         ; Retorna ao chamador
