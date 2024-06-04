open Ast

(** [parse s] parses [s] into an AST. *)
let parse (s : string) : expr =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.prog Lexer.read lexbuf in
  ast

(** [interp s] interprets [s] by lexing and parsing it, 
.. **)




let string_of_val (e : expr) : string = 
  match with 
  |Int i -> string_of_int if
  | Binop _ -> failwith "pas de binop ici"

let is_value : expr -> bool = function
  |Int _ -> true
  |Binop _ -> false 

let rec step : expr -> expr = function
  |Int i -> failwith "pas de step sur des int"
  |Binop (bop,e1,e2) when is_value e1 && is_value e2 -> step_bop bop v1 v2
  |Binop (bop,e1,e2) when is_value e1 -> Binop(bop, e1, step e2)
  |Binop (bop,e1,e2) when is_value e2 -> Binop(bop, step e1, e2)

and step_bop bop v1 v2 = 
  match bop, v1,v2 with
  | Add, Int a, Int b -> Int(a + b)
  | Mult, Int a, Int b -> Int(a * b) 
  |_ -> failwith "operation inconnue"

let rec eval (e : expr) : expr = 
  if is_value e then e else 
    e |> step |> eval


let interp (s : string) : string =
  s |> parse |> eval |> string_of_eval