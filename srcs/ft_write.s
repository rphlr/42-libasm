section .text
global _ft_write

_ft_write:
    mov rax, 1              ; Syscall numéro 1 pour `write`
    syscall                 ; Appelle `write`
    ret                     ; Retourne le nombre d'octets écrits
