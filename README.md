# Bibliothèque `libasm` en Assembleur

## Description
La bibliothèque `libasm` contient plusieurs fonctions de manipulation de chaînes et d'E/S en assembleur pour l'architecture x86_64 sous Linux. Ces fonctions reproduisent le comportement de certaines fonctions standard en C, telles que `strlen`, `strcpy`, `strcmp`, `write`, `read`, et `strdup`.

## Fonctions

### 1. Fonction `ft_strlen`
La fonction `ft_strlen` calcule la longueur d'une chaîne de caractères terminée par un caractère nul (`\0`).

#### Code Source
```assembly
.section .text
.global ft_strlen

ft_strlen:
    xor %rax, %rax            # Initialise le compteur de longueur
    mov %rdi, %rcx            # Charge l'adresse de la chaîne dans rcx

loop_strlen:
    cmpb $0, (%rcx)           # Compare le byte courant avec 0
    je end_strlen             # Si 0, fin de chaîne
    inc %rax                  # Incrémente le compteur
    inc %rcx                  # Avance au caractère suivant
    jmp loop_strlen           # Retour à la boucle

end_strlen:
    ret                       # Retourne la longueur
```

#### Explication
- Utilise `rcx` pour parcourir la chaîne et `rax` pour compter les caractères.
- La boucle s'arrête lorsque le caractère nul (`\0`) est trouvé.

---

### 2. Fonction `ft_strcpy`
La fonction `ft_strcpy` copie une chaîne source dans une chaîne de destination.

#### Code Source
```assembly
.section .text
.global ft_strcpy

ft_strcpy:
    mov %rdi, %rcx            # Adresse de destination dans rcx
    mov %rsi, %rdx            # Adresse source dans rdx
copy_loop:
    movb (%rdx), %al          # Copie le byte de source dans al
    movb %al, (%rcx)          # Copie al dans destination
    inc %rcx                  # Avance dans la destination
    inc %rdx                  # Avance dans la source
    testb %al, %al            # Vérifie si fin de chaîne
    jne copy_loop             # Continue si non nul
    ret                       # Retourne la destination
```

#### Explication
- `rcx` parcourt la destination, `rdx` la source.
- La boucle se termine au caractère nul de fin de chaîne.

---

### 3. Fonction `ft_strcmp`
La fonction `ft_strcmp` compare deux chaînes de caractères et retourne 0 si elles sont identiques, ou une valeur positive/négative si elles diffèrent.

#### Code Source
```assembly
.section .text
.global ft_strcmp

ft_strcmp:
    mov %rdi, %rcx            # Première chaîne dans rcx
    mov %rsi, %rdx            # Deuxième chaîne dans rdx
loop_strcmp:
    movb (%rcx), %al          # Caractère courant de s1
    movb (%rdx), %bl          # Caractère courant de s2
    cmp %bl, %al              # Comparaison des caractères
    jne not_equal             # S'ils diffèrent, retour de la différence
    testb %al, %al            # Fin de chaîne
    je equal                  # Identiques si fin des deux chaînes
    inc %rcx
    inc %rdx
    jmp loop_strcmp

not_equal:
    sub %bl, %al
    movsx %al, %eax
    ret

equal:
    xor %eax, %eax
    ret
```

#### Explication
- Compare chaque caractère jusqu'à un caractère nul ou une différence.

---

### 4. Fonction `ft_write`
Appelle le syscall `write` pour écrire dans un fichier ou sur la sortie standard.

#### Code Source
```assembly
.section .text
.global ft_write

ft_write:
    mov $1, %rax              # Syscall pour write
    syscall                   # Exécution
    ret
```

#### Explication
- Utilise `rdi` (descripteur de fichier), `rsi` (buffer), et `rdx` (taille en octets) pour les paramètres.

---

### 5. Fonction `ft_read`
Appelle le syscall `read` pour lire depuis un fichier ou depuis l'entrée standard.

#### Code Source
```assembly
.section .text
.global ft_read

ft_read:
    mov $0, %rax              # Syscall pour read
    syscall                   # Exécution
    ret
```

#### Explication
- Utilise `rdi` (descripteur de fichier), `rsi` (buffer), et `rdx` (taille maximale en octets) pour les paramètres.

---

### 6. Fonction `ft_strdup`
Alloue de la mémoire et duplique une chaîne.

#### Code Source
```assembly
.section .text
.global ft_strdup
.extern malloc
.extern ft_strlen

ft_strdup:
    mov %rdi, %rsi            # Chaîne source
    call ft_strlen            # Obtiens longueur dans rax
    addq $1, %rax             # Ajoute 1 pour le '\0'
    mov %rax, %rdi            # Taille pour malloc
    call malloc               # Alloue mémoire
    test %rax, %rax           # Vérifie succès de malloc
    je end_strdup             # Si échec, retourne NULL
    mov %rax, %rcx            # Sauvegarde adresse allouée
    mov %rsi, %rdi            # Prépare la source
copy_loop:
    movb (%rsi), %al          # Caractère source
    movb %al, (%rcx)          # Caractère destination
    inc %rsi
    inc %rcx
    testb %al, %al            # Vérifie fin de chaîne
    jne copy_loop
end_strdup:
    ret
```

#### Explication
- Calcule la longueur avec `ft_strlen`, alloue avec `malloc`, copie chaque caractère.

---

## Conventions d'Appel x86_64 Linux

Les fonctions utilisent les registres suivants pour les arguments :
1. `rdi` : Premier argument.
2. `rsi` : Deuxième argument.
3. `rdx` : Troisième argument.
4. `rcx` : Quatrième argument.

Les valeurs de retour sont dans `rax`.

---

## Compilation et Test

Pour assembler, créer la bibliothèque et tester :

```bash
as ft_strlen.s -o ft_strlen.o
as ft_strcpy.s -o ft_strcpy.o
as ft_strcmp.s -o ft_strcmp.o
as ft_write.s -o ft_write.o
as ft_read.s -o ft_read.o
as ft_strdup.s -o ft_strdup.o
ar rcs libasm.a ft_strlen.o ft_strcpy.o ft_strcmp.o ft_write.o ft_read.o ft_strdup.o
gcc -Wall -Wextra -Werror main.c -L. -lasm -o test_libasm
./test_libasm
```

Chaque fonction de la bibliothèque `libasm.a` est testée dans `main.c`.