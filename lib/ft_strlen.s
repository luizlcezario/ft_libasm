
global ft_strlen
extern __errno_location

; Função ft_strlen
; rdi - Ponteiro para a string
; rax - Valor de retorno (número de bytes lidos ou código de erro)
ft_strlen:
    xor rax, rax              ; Inicializa rax (contagem de bytes lidos)
    test rdi, rdi             ; Verifica se o ponteiro é NULL
    jz .set_errno             ; Se for NULL, pula para configurar errno

.loop:
    cmp byte [rdi + rax], 0   ; Verifica se chegou ao final da string
    je .done                  ; Se encontrar o fim da string (nulo), termina
    inc rax                   ; Incrementa a contagem de bytes
    jmp .loop                 ; Continua o loop

.set_errno:
    call      __errno_location WRT ..plt              ; rax = &errno
    mov       dword [rax], 22           ; (4 bytes) *rax = EINVAL (Invalid Argument)
    xor       rax, rax                      ; rax = 0
    ret                                     ; return rax


.done:
    ret                       ; Retorna com o valor de rax, que contém o comprimento da string
