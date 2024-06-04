%token <int> INT
%token EOF
%token PLUS
%token MULT
%start <Ast.expr> prog


%left PLUS
%left MULT

%%

prog:
	| e = expr; EOF { e }
	;

expr:
	| i = INT { Int i }
	| e1 = expr; PLUS;e2 = expr { Binop (Add,e1,e2) }
	| LPARENT; e = expr ; RPARENT { e }
	;