section .text
global _ft_read

_ft_read:
    mov rax, 0x2000003      ; Numéro du syscall `read` sur macOS
    syscall                 ; Appelle le syscall
    ret                     ; Retourne le nombre d'octets lus
