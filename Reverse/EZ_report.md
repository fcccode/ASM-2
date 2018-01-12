# EZ.exe

## 1er flag

1. Suivre l'exécution pas à pas
2. Appel de sub_401000 : l'ouvrir
3. Mot de passe "TANK" dans un commentaire

**FLAG : TANK**

## 2ème flag

1. Suivre l'exécution pas à pas
2. Appel de sub_4010C0
3. On trouve une comparaison entre `eax` et [ebp+var_C]
    * On trouve au dessus que `eax` contient [ebp+var_18], qui porte la valeur `19C`
    * On comprend que la valeur à saisir doit être comparée à celle-ci
    * `19c` = 412 en base 10

**FLAG : 412**

## 3è flag

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

## 4è flag

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

## 5è flag

1. Suivre l'exécution pas à pas
2. 