module Context = Map.Make (String)

type expr =
  | Int of int
  | Variable of string
  | Abstraction of { param : string; body : expr }
  | Application of { funct : expr; argument : expr }

type value =
  | VClosure of { context : value Context.t; param : string; body : expr }
  | VNative of (value -> value)
  | VInt of int

exception Type_error

let rec interp context expr =
  match expr with
  | Int v -> VInt v
  | Variable name -> Context.find name context
  | Abstraction { param; body } -> VClosure { context; param; body }
  | Application { funct; argument } -> begin
      let argument = interp context argument in
      match interp context funct with
      | VClosure { context; param; body } ->
          interp (Context.add param argument context) body
      | VNative f -> f argument
      | VInt _ -> raise Type_error
    end

let _ =
  Abstraction
    {
      param = "f";
      body =
        Application
          {
            funct = Variable "f";
            argument =
              Application
                {
                  funct = Variable "print_hello_world";
                  argument = Variable "f";
                };
          };
    }

(* ((λf.(f (print_hello_world f))) (λf.(f (print_hello_world f)))) *)
let code = Application {
  funct = Variable "print_int";
  argument = Application {
    funct = Application {
      funct = Variable "add";
      argument = Int 5;
    };
    argument = Int 3;
  };
}


let initial_context =
  Context.empty
  |> Context.add "print_hello_world"
       (VNative
          (fun v ->
            print_endline "hello world";
            v))
  |> Context.add "add" 
  (VNative 
  (fun a -> 
    VNative
    (fun b -> 
      match a, b with
      | VInt a, VInt b -> VInt (a + b)
      | _ -> raise Type_error
    )
  ))
  |> Context.add "print_int" 
  (VNative
  (fun v -> 
    match v with
    | VInt w -> print_int w; print_newline (); v
    | _ -> raise Type_error
  ))

let _x = interp initial_context code