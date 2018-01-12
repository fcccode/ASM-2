# Rapport Reverse
_Yann LELONG_  
![logo_esiea](logo_esiea.jpg)

## EZ.exe

### 1er flag

1. Suivre l'exécution pas à pas
2. Appel de sub_401000 : l'ouvrir
3. Mot de passe "TANK" dans un commentaire

**FLAG : TANK**

### 2ème flag

1. Suivre l'exécution pas à pas
2. Appel de sub_4010C0
3. On trouve une comparaison entre `eax` et [ebp+var_C]
    * On trouve au dessus que `eax` contient [ebp+var_18], qui porte la valeur `19C`
    * On comprend que la valeur à saisir doit être comparée à celle-ci
    * `19c` = 412 en base 10

**FLAG : 412**

### 3è flag

1. Suivre l'exécution pas à pas
2. Appel de sub_401130
3. Eléments intéressants :
    * `cmp  ecx, [ebp+var_18]`
    * `xor  eax, 0BAADBAADh`
    * `call ds:strtol`
    * `mov  [ebp+var_18], 0D1CECA5Eh`
4. La comparaison finale se fait entre la valeur de `[ebp+var_18]` et le résultat du `xor`
5. Le `xor` est fait entre la valeur saisie et `0BAADBAADh`
6. `strtol` permet de passer la saisie faite au clavier en un entier en base 16. Il faut donc saisir la valeur voulue en base 16
7. Le flag cherché est le résultat de xor entre `0BAADBAADh` et `0D1CECA5Eh`

**FLAG : 6b6370f3**

### 4è flag

1. Suivre l'exécution pas à pas
2. Appel de sub_4011B0
3. Eléments intéressants :
    * `cmp  eax, [ebp+var_10]`
    * `call ds:rand`
    * `call ds:srand`
    * `call ds:atoi`
4. La comparaison finale se fait entre la valeur de `[ebp+var_10]` et eax
5. `eax` prend la valeur de `[ebp+var_C]`
6. `[ebp+var_10]` vaut la sortie du rand
7. `srand` est initialisé avec la valeur `6b6370f3`. On peut sait donc que la valeur sortie par le `rand`, utilisée dans la comparaison sera toujours la même
8. `atoi` permet de passer en entier la valeur saisie au clavier
9. En suivant l'exécution, on trouve que la valeur générée est `7AD5`, ce qui fait 31445 en base 10

**FLAG : 31445**

### 5è flag

1. Suivre l'exécution pas à pas
2. Appel de sub_401260
3. Eléments intéressants :
    * Beaucoup d'écriture en mémoire au lancement de la routine
4. On constate qu'une chaîne de caractère (incomplète) est écrite dans la mémoire `Nebuchadn[1]z[0Ah][6]r`
5. Une boucle permet de compter le nombre de caractères qui ont été saisis par l'utilisateur au clavier. Cette valeur est ensuite comparée à `0Ah`
    * On comprend que le flag doit faire au moins 10 caractères 
6. En supposant que les valeurs indiquées ici entre crochets correspondent à une position dans le mot, on peut compléter ainsi :
    * `[1]`     = `e`
    * `[0Ah]`   = `z`
    * `[6]`     = `a`

**FLAG : Nebuchadnezzar**

### 6è flag

1. Suivre l'exécution pas à pas
2. Appel de sub_4019E0
3. Eléments intéressants :
    * `cmp  ecx, [ebp+var_10]`
    * `call ds:atoi`
4.  On constate que la valeur que l'on a saisi au clavier est convertie en entier pour ensuite être comparée à celle pointée par `[ebp+var_10]`
5.  En regardant en mémoire ce qui est pointée par `[ebp+var_10]`, on trouve `3DBh` (il faut bien prendre les 4 octets composants l'entier)

**FLAG : 987**

## HACHOIR.exe

### Procédé

1. Dans sub_401020, on voit que l'on doit saisir un mot de passe. Un test est réalisé sur la longueur de celui-ci : il doit faire 12 caractères de long. Si la longueur est différente, on ne fait aucune autre opération.
2. En regardant la suite du code, on trouve qu'une sous-routine est appelée 3 fois (sub_401110), puis sub_401190 et enfin un `memcmp`. Cette dernière fonction réalise donc la comparaison finale entre deux bloc mémoire. Pour corroborer ce que l'on a vu précédemment, on voit que la comparaison s'effectue sur 12 octets.
3. On trouve la valeur du hash à comparer en mémoire à partir de la case 403018 : `0E 8C 01 B7 | 2F B0 67 A8 | 69 E0 BB E7`. Le but est donc de reverser l'exécutable pour obtenir ce hash.

### sub_401000

#### Opérations reversées

1. `xor eax, 1337h`
2. `add eax, 453B698Eh`
3. `rol eax, 7`
4. `not eax`
5. `sub eax, ecx`
6. `ror eax, 0Dh`
7. La valeur `ecx` vaut la valeur de l'argument 2 passé à la fonction

### sub_401110

1. Passe à sub_401000 les 4 premières valeurs de son premier argument (1234 si tapé 123456789123) et son deuxième argument, puis les 4 valeurs suivantes et le même deuxième argument, trois fois

### main

1. Passe la chaîne de caractère en premier argument à sub_401110 et l'entier 0
2. Passe la chaîne modifiée par le premier appel à sub_401110 à celle-ci et l'entier 1
3. Passe la chaîne modifiée par le deuxième appel à sub_401110 à celle-ci et l'entier 2

### sub_401190

#### Opérations reversées

* `xor eax, 21444545h`, eax = 3ème valeur précédemment modifiée
* `xor ecx, 53204D4Fh`, ecx = 2ème valeur précédemment modifiée
* `xor edx, 444E4152h`, edx = 1ère valeur précédemment modifiée

**FLAG : 87A1 25F5 DB5C**