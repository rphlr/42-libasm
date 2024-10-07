# Fonction `ft_strlen` en Assembleur

## Description
La fonction `ft_strlen` calcule la longueur d'une chaîne de caractères terminée par un caractère nul (`\0`). Elle prend en entrée un pointeur vers la chaîne de caractères et retourne la longueur de cette chaîne.

## Code Source
```assembly
section .text
    global ft_strlen

ft_strlen:
    xor eax, eax        ; Met le compteur de longueur (EAX) à zéro grâce à l'opération binaire XOR
    mov ecx, edi        ; Copie l'adresse de la chaîne de caractères de EDI à ECX

loop_start:
    cmp byte [ecx], 0   ; Compare le byte actuel pointé par ECX avec 0 (le caractère nul)
    je loop_end         ; Si le caractère est nul (fin de chaîne), saute à loop_end

    inc eax             ; Incrémente le compteur de longueur
    inc ecx             ; Avance au caractère suivant dans la chaîne
    jmp loop_start      ; Retourne au début de la boucle

loop_end:
    ret                 ; Retourne la longueur de la chaîne dans EAX
```

## Explication du Code

### Sections en Assembleur
- **section .text** : Contient le code exécutable. C'est la section où les instructions du programme sont stockées.

### Instructions Clés
- **global ft_strlen** : Rend la fonction `ft_strlen` accessible à d'autres fichiers.
- **xor eax, eax** : Met le registre `EAX` à zéro. `EAX` est utilisé pour compter la longueur de la chaîne.
- **mov ecx, edi** : Copie l'adresse de la chaîne de caractères (passée dans `EDI`) dans `ECX`. `ECX` sera utilisé pour parcourir la chaîne.

### Boucle de Comptage
1. **loop_start** : Étiquette marquant le début de la boucle.
2. **cmp byte [ecx], 0** : Compare le byte pointé par `ECX` avec 0 (caractère nul).
3. **je loop_end** : Si le caractère nul est trouvé, saute à `loop_end`.
4. **inc eax** : Incrémente le compteur de longueur.
5. **inc ecx** : Avance au caractère suivant de la chaîne.
6. **jmp loop_start** : Retourne au début de la boucle pour continuer le comptage.

### Fin de la Boucle
- **loop_end** : Étiquette marquant la fin de la boucle.
- **ret** : Retourne la longueur de la chaîne (contenue dans `EAX`) à l'appelant.

## Registres Utilisés
- **EAX** : Utilisé pour stocker la longueur de la chaîne et retourner cette valeur.
- **EDI** : Contient l'adresse de la chaîne de caractères en entrée.
- **ECX** : Utilisé comme pointeur pour parcourir la chaîne de caractères.

## Conventions d'Appel
Dans l'architecture x86-64 (utilisée par exemple sur Linux), les arguments des fonctions sont passés dans les registres suivants :
1. **EDI** : Premier argument (adresse de la chaîne de caractères dans ce cas).
2. **ESI** : Deuxième argument (non utilisé ici).
3. **EDX** : Troisième argument (non utilisé ici).
4. **ECX** : Quatrième argument (non utilisé ici).

## Résumé
La fonction `ft_strlen` parcourt une chaîne de caractères en utilisant `ECX` comme pointeur et `EAX` comme compteur de longueur. Elle continue jusqu'à ce qu'elle rencontre un caractère nul (`\0`), puis retourne la longueur de la chaîne dans `EAX`.

## Exemple d'Utilisation
Si la chaîne de caractères "hello" est passée à `ft_strlen`, la fonction retournera 5, car "hello" contient 5 caractères avant le caractère nul.