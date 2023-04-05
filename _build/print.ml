open Ast (* inclure le module Ast dans Print *)

(* definition de la fonction d print_value *)

let print_value = function
	| Void  -> " "
	| Bool b -> string_of_bool b
	| Int n -> string_of_int n
	| Str s -> Printf.sprintf "%s" s
	
let print_value v = Printf.printf "%s\n" (print_value v)
