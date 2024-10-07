.section .text
.global ft_write

ft_write:
    movq $1, %rax            # Numéro de syscall pour write
    syscall                   # Exécute le syscall
    ret                       # Retour
