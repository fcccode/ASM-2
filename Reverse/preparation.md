# Préparation au reverse

## Partie 1 : Questions

**Quelle est la différence entre un désassembleur et un décompileur ?**
Les deux génèrent du texte humainement compréhensible. Cependant, le décompileur va présenter un texte de plus haut niveau, plus concis et plus facilement abordable.

**Donner une défintion de la pile. Comment fonctionne la pile ?**
La pile est une zone mémoire réservée pour garder la trace des opérations internes du programme. Elle contient les adresses de retour, les paramètres des fonctions, etc. Elle fonctionne en LIFO.

**Combien de registres généraux ? Les lister.**
15 registres généraux
* Registres de travail
    * EAX : registre accumulateur
        * opérations arithmétiques et stockage des valeurs de retour des appels sytème
    * EBX : registre de base
        * pointeur de données
    * ECX : registre compteur
        * duh
    * EDX : registre de donées
        * opérations arithmétiques et opérations d'I/O
* Registres d'offset
    * Utilisés lors de l'adressage indirect de la mémoire
    * EBP (**E**xtended **B**ase **P**ointer)
        * pointeur de base
    * ESP (**E**xtended **S**tack **P**ointer)
        * pointeur de pile
    * ESI (**E**xtended **S**ource **I**ndex)
        * pointeur source
    * EDI (**E**xtended **D**estination **I**ndex)
        * pointeur destination
* Registres de segments
    * Définissent le segment de mémoire utilisé
    * 16 bits
    * CS : code segment
    * DS : data segment
    * ES : extra segment
    * SS : stack segment
    * FS, GS
* Registre de flags

**Qu'est-ce qu'une frame ?**
C'est le stockage de toutes les données de pile associées avec une sous-routine. Elle contient généralement :
* l'adresse de retour
* les valeurs des paramètres passées dans la stack
* les variables locales
* une copie sauvegardée des registres modifiés par la sous-routine qui devront être restaurés

Au lieu de faire des push/pop successifs, il suffit de mettre à jour le pointeur de pile.

## Partie 2 : ASM x86
Réalise la suite :
* u1=1
* un=(u(n-1)+n)*n

`sub_401000(5) = 645`

## Partie 3 : Développement

Voir `../3-TP/strlen.asm` (et `../3-TP/xor2buffers.asm` quand il sera fait)

* Regarder les strings !
* `y` sur une fonction : permet de définir un prototype pour la fonction
* Sauvegarde :
    * File > Produce File > Dump to IDC Database
    * A la réouverture, importer l'exe, puis File > Script file > fichier.idc