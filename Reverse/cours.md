# Reverse engineering

Code machine &rightarrow; Analyse manuelle &rightarrow; Code source

## Types et méthodologie
* Statique
    * Comprendre le code assembleur
* Dynamique
    * _debug_ de l'application
* Recherche d'un point d'entrée du programme
    * Liste d'information initiale
    * Fonctions import/export
    * Fonction crypto
    * Strings
    * ...
* Il faut identifier si la fonction est utile ou pas
    * Regarder les paramètres d'I/O
    * Renommer une fonction après l'avoir étudiée

## Sections
* Certaines sections ne sont pas mappées dans IDA par défaut comme les ressources

## IDA
* Désassembleur
* Debugger

## Conventions d'appel (ABI)
* `cdecl`
    * Passage sur la pile
    * Caller clean-up
* `stdcall`
    * Passage sur la pile
    * Caller clean-up (instruction `retn X`)
* `fastcall`
    * Passage dans les registres puis sur la pile
        * `ECX`, `EDX`, pile
        * Callee clean-up