open Ast
open Baselib

(*
   * V nom de variable
   * e environement
   * sb suite block
   * i iterrateur (curseur)
   * b block
   * N native
*)

(* Le type 'a res définit si o renvoie une valeur ou bien un envirenement *)

type 'a res =
  | Ret of value
  | Env of 'a Env.t

(* Definition de eval_value elle permet d'evaluer une valeur *)

let eval_value = function
  | Void -> Void
  | Bool b -> Bool b
  | Int n -> Int n
  | Str s -> Str s

(* fonction qui evalue le une expression *)

(*
  une expression peut être une valeur constant soit c'est un nom de varibale 
  si c'est une constant on fera appel à eval_value.
  Si c'est un nom de varibale nous devons allez la chercher la ou elle est stocker
  dans notre cas nous allons utiliser des environement pour stocker les valeur crée 
  par le programme.

  - Un envireonement doit avoir obligatoirement des valeur du mếme type
*)

let rec eval_expr e env = 
  match e with 
    | Value v -> (eval_value v) (* Lire et renvoyer la valeur *)
    | Var v ->                  (* Evaluer une expression : chercher la clef n dans env et renvoyer la valeur associer *)
      (match Env.find v env with
        | V v -> v
        | _ -> failwith "ERROR : EXEPTED VARIABLE NAME")
    | Call (f, args) -> 
      (match Env.find f env with 
          | N b -> b (List.map (fun a -> eval_expr a env)args) (* En applique la fonction eval_expr sur l'ensemble des args qui est une liste *)
          | F (list_res, b ) -> eval_list args list_res b env (* En appel la fonction pour tester sur le reste de la liste *)
          | _ -> failwith "ERROR : EXECEPTED FUNCTION")

(* Fonction qui eavlue une liste *)          
and eval_list list_1 list_2 b env =
    begin
    match list_1 with
    
    | [] -> (match eval_block b env with
             | Env void -> Void  (* Si l'environemment et vide en renvoie void *)
             | Ret e -> e)    (* Si non en renvoie une valeur *)
    | i :: r -> match list_2 with
                 | x :: y -> match (eval_instr(Assign (x, i)) env) with
                                | Ret e -> e                  (* En renvoie un nouveal envirenement mis à jour *)
                                | Env e -> eval_list r y b e  (* En recommence l'operation pour le reste de la liste *)          
    end
  (*
    fonction qui evalue une instruction elle renvoie soit un env augmenter (mis à jour)
    soit une valeur de type value
  *)
and eval_instr i env = 
  match i with
    | Assign (v, e) ->  Env (Env.add v (V(eval_expr e env)) env ) (* Crée un nouvel env en ajoutant à l'interieur la valeur v *) 
    | Return e -> Ret(eval_expr e env) (* Renvoyer la valeur de l'expression *)
    | Expr e -> ignore(eval_expr e env); Env(env)
    | Cond (expr, bt, bf) ->  
      (match eval_expr expr env with
        | Bool boolean -> (match boolean with
                            | true -> eval_block bt env
                            | false -> eval_block bf env) (* evaluer l'expresson et renvoyer true ou false et continuer l'execution *)
        | _ -> Env env) (* si non renvoyer l'env*)
    | Loop (e, b) -> (match eval_expr e env with
                              | Bool false -> Env env
                              | _ ->(match eval_block b env with 
                                                | Env e -> eval_instr i e
                                                | Ret e -> Ret e))   
    


(* fonction qui evalue un block d'instruction *)

and eval_block b env =
  match b with 
    | i :: sb -> 
      begin
        match eval_instr i env with
         | Env new_env  -> 
            eval_block sb new_env  (* On crée un nouvel env est on evalue la suite du block *)
         | Ret v -> Ret v                             (* On renvoie une valeur de type value *)
      end
    | [] -> Env env (*Ou en renvoie un message d'erreur *)                               (* Env vide on continue l'execution et en renvoie l'env courant *)


let rec eval_def f env =
    match f with
    | [] -> env
    | i :: r -> match i with
                |Func (v, args, b) -> Env.add v (F (args,b)) (eval_def r env)

