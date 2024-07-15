global ft_strcmp

ft_strcmp:
    xor rax, rax            ; zera rax, que será usado como índice
    xor rcx, rcx            ; zera rcx, que será usado para armazenar o valor de retorno

    test rdi, rdi            ; Testa se rdi (primeira string) é NULL
    jz check_second         ; Se for NULL, verificar a segunda string

    test rsi, rsi            ; Testa se rsi (segunda string) é NULL
    jz first_not_null       ; Se for NULL e a primeira não for, strings não são iguais

looper:
    mov al, byte [rdi + rcx]     ; carrega o byte da string1
    mov bl, byte [rsi + rcx]     ; carrega o byte da string2
    cmp al, bl              ; compara os bytes
    jne done                ; se forem diferentes, sai do loop
    test al, al             ; verifica se al é nulo (fim da string)
    jz done                 ; se for nulo, sai do loop
    test bl, bl             ; verifica se bl é nulo (fim da string)
    inc rcx                 ; incrementa o índice
    jmp looper              ; repete o loop

done:
    sub al, bl              ; calcula a diferença entre os bytes
    movsx rax, al           ; converte a diferença para um valor de 64 bits com sinal
    ret                     ; retorna o valor da diferença

check_second:
    test rsi, rsi            ; Testa se rsi (segunda string) é NULL
    jz both_null            ; Se for NULL, ambas são NULL, strings são iguais
    mov rax, -1              ; Se a segunda string não for NULL, strings não são iguais
    ret

first_not_null:
    mov rax, 1               ; Se a primeira string não for NULL, strings não são iguais
    ret

both_null:
    xor rax, rax             ; Se ambas forem NULL, strings são iguais
    ret