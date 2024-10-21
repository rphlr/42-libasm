section .text
global _ft_write

_ft_write:
    mov rax, 0x2000004      ; Numéro du syscall `write` sur macOS
    syscall                 ; Appelle le syscall
    ret                     ; Retourne le nombre d'octets écrits
