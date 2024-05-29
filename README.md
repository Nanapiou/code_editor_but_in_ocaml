# A code editor, but in OCaml.

*Switching to french, beacause french.*

Liens:
- https://github.com/tomprimozic/type-systems?tab=readme-ov-file Différentes implémentations d'algorithmes d'inférence de type
- https://gitlab.inria.fr/fpottier/inferno Une implémentation de l'algorithme de Hindley-Milner
- https://github.com/andrejbauer/plzoo Différents petits langages implémentés (dont inférence de types)
- https://www.youtube.com/watch?v=Y8RE8VcQdFU Implémentation d'une exécution de lambda calcul (sans inférence de type)
- https://www.youtube.com/watch?v=E3BjV-Y6jlk Implémentation de l'inférence de type de la vidéo ci-dessus
- https://www.youtube.com/watch?v=3fWkF8aBOMk Polymorphisme ajouté à l'implémentation ci-dessus (non vue)
- https://github.com/dakk/lambda Une librairie OCaml implémentant le lambda calcul dans sa grande majorité
- https://www.editions-ellipses.fr/accueil/6352-compilation-analyse-lexicale-et-syntaxique-du-texte-a-sa-structure-en-informatique-9782340003668.html livre de compilation
- https://www.editions-ellipses.fr/index.php?controller=attachment&id_attachment=37774  sommaire du livre de compilation
- [A Short Introduction to Systems F and Fω](./documents/f-fw.pdf), une introduction au système F, permettant d'utiliser le λ2 (lié au polymorphisme et aux langages ml, cf [wikipedia](https://en.wikipedia.org/wiki/Lambda_cube#(%CE%BB2)_System_F)) *(parcouru)*
- [EXTENSION OF ML TYPE SYSTEM WITH A SORTED EQUATIONAL THEORY ON TYPES](./documents/eq-theory-on-types.pdf)
- [https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://www.youtube.com/watch%3Fv%3Deis11j_iGMs&ved=2ahUKEwiUlaH_oo2GAxUZT6QEHSl2DaAQtwJ6BAgUEAI&usg=AOvVaw3eSilo1kbqgPbljPOemJG6](vidéo youtube) bool en lambda calcul (church encoding)
- [Interpreters in OCaml](https://cs3110.github.io/textbook/chapters/interp/intro.html), création d'AST et interpréteurs en OCaml, sur [Cornell’s CS 3110](https://www.cs.cornell.edu/courses/cs3110/2024sp/)
- [CS 4110 (Fall 2012)](https://www.cs.cornell.edu/courses/cs4110/2012fa/index.php) *(palu)* *mais y'a un [deuxième lien](https://www.cs.cornell.edu/courses/cs4110/2020fa/) si jamais curiosité*
- https://www.youtube.com/watch?v=dycsRSOQjho ocaml parser *(pavu)*
- https://www.youtube.com/watch?v=NjKJ9-ejR6o ocaml interpreter *(pavu)*
  
$x: \sigma \in \Gamma  $

### Règles de dérivation

| $x: \sigma \in \Gamma  $ |
| ---------------------- |
| $\Gamma \vdash x: \sigma $|


| $c\text{ est une constante de type} T$ |
| ---------------------- |
|   $\Gamma \vdash c: T $|

| $x: \Gamma ,x: \sigma \vdash e: \tau $ |
| ---------------------- |
| $\Gamma \vdash (\lambda x: \sigma \rightarrow \tau):( \sigma \rightarrow  \tau )$ |

|  $\Gamma \vdash e_1: \sigma \rightarrow  \tau \Gamma \vdash e_2: \sigma $  |
| ---------------------- |
| $\Gamma \vdash e_1 e_2: \sigma $|
