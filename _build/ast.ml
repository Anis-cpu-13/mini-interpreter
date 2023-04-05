type ident = string (* identificateur*)

(* Definission du type value *)

type value =
  | Void
  | Int of int
  | Bool of bool
  | Str of string


type expr =
  | Value of value
  | Var of ident (* ident correspend à une string *)
  | Call of ident * expr list (* appel de fonction *)
and eval_list = expr list * ident list * block (* evaluer une liste *)
and instr = 
  | Assign of ident * expr (* un assign est expression portant un ident *)
  | Return of expr (* un return est une expression resultante de l'evalutation d'une expression *)
  | Expr of expr
  | Cond of expr * block * block (* Une condition est une liste de liste d'instruction *)
  | Loop of expr * block 
and  block =  instr  list (* Un block est une liste d'instruction *)

type def =
  | Func of ident * ident list * block (* Une fonction à un ident une liste d'arguement et un block d'instruction *)

(*type prog = def list  Un programme est une liste de défintion *)


