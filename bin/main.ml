module Context = Map.Make(String)

type expr = 
  | Int of int
  | Variable of string
  | Application of { funct: expr; argument: expr}
  | Abstraction of { param: string; body: expr }

type value =
  | VInt of int
  | VClosure of { context: value Context.t; param: string; body: expr }
  | VNative of (value -> value)

exception Type_error of string

let rec interp context e =
  match e with
  | Int n -> VInt n
  | Variable v -> Context.find v context
  | Abstraction {param; body} -> VClosure {context; param; body}
  | Application {funct; argument} -> 
    let argument = interp context argument in 
    match interp context funct with
    | VNative f -> f argument
    | VClosure {context; param; body} -> interp (Context.add param argument context) body
    | _ -> raise (Type_error "Not a function")

let initial_context =
  Context.empty |>
  Context.add "hello_world" (
    VNative (fun v -> print_endline "Hello world!"; v)
  ) |>
  Context.add "add" (
    VNative (fun a ->
      VNative (fun b ->
        match a, b with
        | VInt a, VInt b -> VInt (a + b)
        | _ -> raise (Type_error "Can only add two integers")
      )
    )
  ) |>
  Context.add "print_int" (
    VNative (fun v ->
      match v with
      | VInt n -> Printf.printf "%d\n" n; v
      | _ -> raise (Type_error "Can print an integer")
    )
  )

let rec to_string = function
  | Int n -> string_of_int n
  | Variable v -> v
  | Abstraction { param; body } -> String.concat "" [
      "("; "λ"; param; ".";  to_string body; ")"
    ]
  | Application { funct; argument } -> String.concat "" [
      "("; to_string funct; " "; to_string argument; ")"
    ]

let prog = Application {
  funct = Variable "print_int";
  argument = Application {
    funct = Application {
      funct = Variable "add";
      argument = Int 9;
    };
    argument = Int 5
  }
}

let _ = interp initial_context prog

let f = Abstraction {
  param = "f";
  body = Application {
    funct = Variable "f";
    argument = Application {
      funct = Variable "hello_world";
      argument = Variable "f"
    }
  }
}

let infinite_prog = Application {
  funct = f;
  argument = f
}

let () = infinite_prog |> to_string |> print_endline