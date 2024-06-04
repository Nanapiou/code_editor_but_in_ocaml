(** The type of binary operators. *)


(** The type of the abstract syntax tree (AST). *)
type expr =
  | Int of int
  | Binop of bop * expr * expr

type bop =
  | Add
  | Mult