section .text
    global ft_strcpy

ft_strcpy:
    ; rdi = destino, rsi = origem
    test rdi, rdi
    jz done
    test rsi, rsi            ; Verificar se a origem é NULL
    jz done

    xor rcx, rcx            ; Zera o contador
copy_loop:
    mov al, [rsi + rcx]     ; Ler cada byte da string original
    mov [rdi + rcx], al     ; Escrever cada byte na nova área de memória
    inc rcx                 ; Incrementar contador
    cmp al, 0               ; Verificar se o byte lido é 0
    jne copy_loop           ; Repetir loop se não for 0
    mov rax, rdi            ; Retornar o endereço da string de destino
    ret                     ; Retornar ao chamador

done:
    xor rax, rax            ; Retornar NULL (rax = 0)
    ret                     ; Retornar ao chamador