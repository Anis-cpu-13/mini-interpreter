open Ast
open Interp
open Baselib

let () =
    let prog = [
                (Func ("guessing_game", ["n"], 
                        [
                            (Assign ("rand", (Call ("%rand", [Var "n"])))) 
                            ;(Expr (Call ("%print", [Value (Str "Devinez au nombre mystére:\n")])))
                            ;(Assign ("joueur", (Call ("%input", []))))
                            ;(Loop ((Call ("%neq", [ Var "joueur"; Var "rand"])),
                        [
                            (Cond ((Call ("%eq", [ Var "rand"; Var "joueur"])),
                        [
                            (Expr (Call ("%print", [Value (Str "Vous avez trouvé le nombre mystére\n")])))
                        ],
                        [
                            (Cond ((Call ("%inf", [ Var "rand"; Var "joueur"])),
                        [
                            (Expr (Call ("%print", [Value (Str "Votre nombre est superieur au nombre mystére\n")])))
                            ;(Expr (Call ("%print", [Value (Str "Devinez le nombre mystére:\n")])))
                            ;(Assign ("joueur", (Call ("%input", []))))
                        ],
                        [ 
                            (Expr (Call ("%print", [Value (Str "Votre nombre est inferieur au nombre mystére")])))
                            ;(Expr (Call ("%print", [Value (Str "Devinez nombre mystére:")])))
                            ;(Assign ("joueur", (Call ("%input", []))))
                        ]))
                        ]))
                        ]))
                            ;(Expr (Call ("%print", [Value (Str "Vous avez trouvé le nombre mystére !")])))
                        ]
    
                ))
                ;(Func ("main", [], [
                        (Expr (Call ("%print", [Value (Str "Donner un intervalle pour le random:")])))
                        ;(Assign ("x", (Call ("%input", []))))
                        ;(Expr (Call ("guessing_game", [Var "x"])))
                  ]))
            ]in
Print.print_value(eval_expr(Call("main", [])) (eval_def prog baselib))