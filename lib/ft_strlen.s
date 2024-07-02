section .text
    global strlen

; Função strlen
; rdi - Ponteiro para a string
; rax - Comprimento da string (valor de retorno)
strlen:
    xor rax, rax            ; rax será usado como contador (inicializa com 0)
.loop:
    cmp byte [rdi + rax], 0 ; Comparar o byte atual com 0
    je .done                ; Se for 0, terminar
    inc rax                 ; Incrementar o contador
    jmp .loop               ; Repetir o loop
.done:
    ret                     ; Retornar com o comprimento em rax
