# Hachoir.exe
_Yann Lelong_

## Procédé

1. Dans sub_401020, on voit que l'on doit saisir un mot de passe. Un test est réalisé sur la longueur de celui-ci : il doit faire 12 caractères de long. Si la longueur est différente, on ne fait aucune autre opération.
2. En regardant la suite du code, on trouve qu'une sous-routine est appelée 3 fois (sub_401110), puis sub_401190 et enfin un `memcmp`. Cette dernière fonction réalise donc la comparaison finale entre deux bloc mémoire. Pour corroborer ce que l'on a vu précédemment, on voit que la comparaison s'effectue sur 12 octets.
3. On trouve la valeur du hash à comparer en mémoire à partir de la case 403018 : `0E 8C 01 B7 | 2F B0 67 A8 | 69 E0 BB E7`. Le but est donc de reverser l'exécutable pour obtenir ce hash.

## sub_401000

### Opérations reversées

1. `xor eax, 1337h`
2. `add eax, 453B698Eh`
3. `rol eax, 7`
4. `not eax`
5. `sub eax, ecx`
6. `ror eax, 0Dh`
7. La valeur `ecx` vaut la valeur de l'argument 2 passé à la fonction

## sub_401110

1. Passe à sub_401000 les 4 premières valeurs de son premier argument (1234 si tapé 123456789123) et son deuxième argument, puis les 4 valeurs suivantes et le même deuxième argument, trois fois

## main

1. Passe la chaîne de caractère en premier argument à sub_401110 et l'entier 0
2. Passe la chaîne modifiée par le premier appel à sub_401110 à celle-ci et l'entier 1
3. Passe la chaîne modifiée par le deuxième appel à sub_401110 à celle-ci et l'entier 2

## sub_401190

### Opérations reversées

* `xor eax, 21444545h`, eax = 3ème valeur précédemment modifiée
* `xor ecx, 53204D4Fh`, ecx = 2ème valeur précédemment modifiée
* `xor edx, 444E4152h`, edx = 1ère valeur précédemment modifiée

**FLAG : 87A1 25F5 DB5C**