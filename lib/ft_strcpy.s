
global ft_strcpy
extern __errno_location

ft_strcpy:
    ; rdi = destino, rsi = origem
    test rdi, rdi
    jz .error
    test rsi, rsi            ; Verificar se a origem é NULL
    jz .error
    xor rcx, rcx            ; Zera o contador

.copy_loop:
    mov al, [rsi + rcx]     ; Ler cada byte da string original
    mov [rdi + rcx], al     ; Escrever cada byte na nova área de memória
    inc rcx                 ; Incrementar contador
    cmp al, 0               ; Verificar se o byte lido é 0
    jne .copy_loop           ; Repetir loop se não for 0
    mov rax, rdi            ; Retornar o endereço da string de destino
    ret                     ; Retornar ao chamador

.error:
    call __errno_location WRT ..plt
    mov       dword [rax], 22 
    xor rax, rax            ; Retornar NULL (rax = 0)
    ret                     ; Retornar ao chamador