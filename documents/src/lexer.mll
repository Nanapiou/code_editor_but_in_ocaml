{
open Parser
}

let white = [' ' '\t']+
let digit = ['0'-'9']
let int = '-'? digit+

rule read = 
  parse
  |white {read lexbuff }
  | "+" { PLUS }
  | "*" { MULT }
  | "(" { LPARENT }
  | ")" { RPARENT }
  |int { INT (int_of_string(Lexing.lexeme lexbuff)}
  | eof { EOF }