.section .text
.global ft_read

ft_read:
    mov $0, %rax    # Place la valeur immédiate 0 dans rax pour l'appel système 'read'
    syscall         # Effectue l'appel système
    ret             # Retour
