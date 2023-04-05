open Ast
open Print  

module Env = Map.Make(String)

type native =  value list -> value

type env_value =
  | V of value
  | N of native
  | F of string list * block
  
  let baselib = Env.add "%add"(N (function [ Int a ; Int b ] -> Int (a + b)
  | _ -> failwith "ERROR")) (* should never happen *)
  Env.empty

let baselib = Env.add "%moin"(N (function [ Int a ; Int b ] -> Int (a - b)
  | _ -> failwith "ERROR")) (* should never happen *)
  baselib

let baselib = Env.add "%inf"(N (function [ Int a ; Int b ] -> Bool (a < b)
  | _ -> failwith "ERROR")) (* should never happen *)
  baselib

let baselib = Env.add "%sup"(N (function [ Int a ; Int b ] -> Bool (a > b)
  | _ -> failwith "ERROR")) (* should never happen *)
  baselib

let baselib = Env.add "%eq"(N (function [ Int a ; Int b ] -> Bool (a = b)
 | _ -> failwith "ERROR")) (* should never happen *)
 baselib

 let baselib = Env.add "%neq"(N (function [ Int a ; Int b ] -> Bool (a != b)
 | _ -> failwith "ERROR")) (* should never happen *)
 baselib


let baselib = Env.add "%rand"(N (function [ Int a] -> Int (Random.int a)
 | _ -> failwith "ERROR")) (* should never happen *)
 baselib


let baselib = Env.add "%input"
               (N (function
                   | [] -> Int (read_int() )
                   | _ -> failwith "ERROR "))
               baselib 
let baselib = Env.add "%print"
              (N (function
                 | [a] -> print_value a;Void
                 | _ -> failwith "ERROR "))
              baselib          