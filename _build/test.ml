open Ast
open Interp
open Baselib

let () =
    let prog = [
                (Func ("guessing_game", ["n"], 
                        [
                             (Assign ("rand", (Call ("%rand", [Var "n"])))) 
                             ;(Expr (Call ("%print", [Value (Str "Devinez le random:\n")])))
                             ;(Assign ("joueur", (Call ("%input", []))))
                             
                             ;(Loop ((Call ("%neq", [ Var "joueur"; Var "rand"])),
                        [
                           (Cond ((Call ("%eq", [ Var "rand"; Var "joueur"])),
                                             [
                                                (Expr (Call ("%print", [Value (Str "Vous avez trouvé le random\n")])))
                                             ],
                                             [
                                                (Cond ((Call ("%inf", [ Var "rand"; Var "joueur"])),
                                                                [
                                                                    (Expr (Call ("%print", [Value (Str "Votre nombre est superieur au random\n")])))
                                                                    ;(Expr (Call ("%print", [Value (Str "Devinez le random:\n")])))
                                                                    ;(Assign ("joueur", (Call ("%input", []))))
                                                                ],
                                                                [ 
                                                                    (Expr (Call ("%print", [Value (Str "Votre nombre est inferieur au random")])))
                                                                    ;(Expr (Call ("%print", [Value (Str "Devinez le random:")])))
                                                                    ;(Assign ("joueur", (Call ("%input", []))))
                                                                ]))
                                             ]))
                        ]))
                        ;(Expr (Call ("%print", [Value (Str "Vous avez trouvé le nombre x !")])))
                        ]
    
                ))
                ;(Func ("main", [], [
                        (Expr (Call ("%print", [Value (Str "Donner un intervalle pour le random:")])))
                        ;(Assign ("x", (Call ("%input", []))))
                        ;(Expr (Call ("guessing_game", [Var "x"])))
                  ]))
            ]in
Print.print_value(eval_expr(Call("main", [])) (eval_def prog baselib))