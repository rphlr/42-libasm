section .text
global _ft_read

_ft_read:
    mov rax, 0              ; Syscall numéro 0 pour `read`
    syscall                 ; Appelle `read`
    ret                     ; Retourne le nombre d'octets lus
