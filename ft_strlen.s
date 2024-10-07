; section .text
; 	global ft_strlen

; ft_strlen:
; 	xor eax, eax        ; Clear the EAX register using XOR operation
; 	mov ecx, edi        ; Move the address of the string to ECX

; loop_start:
; 	cmp byte [ecx], 0   ; Compare the byte at ECX with 0
; 	je loop_end         ; If it's 0, jump to loop_end

; 	inc eax             ; Increment the length counter
; 	inc ecx             ; Move to the next byte of the string
; 	jmp loop_start      ; Jump back to loop_start

; loop_end:
; 	ret                 ; Return the length in EAX

.global _ft_strlen

.text
_ft_strlen:
    mov     x1, x0          // Copie l'adresse de la chaîne dans x1
    mov     x0, #0          // Initialise le compteur à 0

loop:
    ldrb    w2, [x1], #1    // Charge un octet et incrémente le pointeur
    cbz     w2, done        // Si l'octet est nul, on a fini
    add     x0, x0, #1      // Incrémente le compteur
    b       loop            // Continue la boucle

done:
    ret                     // Retourne la longueur