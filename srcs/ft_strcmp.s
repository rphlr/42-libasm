section .text
global _ft_strcmp

_ft_strcmp:
    mov rcx, rdi           ; rcx reçoit l'adresse de s1 (quadword)
    mov rdx, rsi           ; rdx reçoit l'adresse de s2 (quadword)

loop_strcmp:
    mov al, byte [rcx]     ; Charger le byte de s1 pointé par rcx dans al
    mov bl, byte [rdx]     ; Charger le byte de s2 pointé par rdx dans bl
    cmp al, bl             ; Comparer les bytes de s1 et s2
    jne not_equal          ; Si différent, sauter à not_equal
    test al, al            ; Vérifier si fin de chaîne (al == 0)
    je equal               ; Si oui, les chaînes sont égales
    inc rcx                ; Incrémenter l'adresse de s1
    inc rdx                ; Incrémenter l'adresse de s2
    jmp loop_strcmp        ; Boucle pour le prochain byte

not_equal:
    sub al, bl             ; Calculer la différence entre les bytes
    movsx eax, al          ; Étendre la différence signée en 32 bits dans eax
    ret                    ; Retourner la différence

equal:
    xor eax, eax           ; Mettre eax à 0 pour indiquer égalité
    ret                    ; Retourner 0
