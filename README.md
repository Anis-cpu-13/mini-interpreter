# Mini interpreter
## Introduction

This project consists of designing and implementing a mini-interpreter for a simple programming language. The project is divided into four modules:

  Ast: which contains the definition of our intermediate representation.
  Print: which contains a function for displaying values.
  Baselib: which contains our base library.
  Interp: which contains the code of the interpreter.

## Installation

The project requires OCaml to function. Simply open a terminal and type the following commands:
      ocamlbuild test.byte
      ./test.byte

## Implemented Features

The mini-interpreter implements the following features:

     Management of variables and assignments.
     Evaluation of expressions and statements.
     Definition of native functions for addition.
     Function calls.
     Conditions and loops.
  
## Project Structure

    ast.ml: Defines a value type that can contain values of our base types (void, bool, int, str).
    print.ml: Contains the function print_value: Ast.value -> unit that displays a value.
    baselib.ml: Defines the Env module that contains the environment for storing the values defined by the program.
    interp.ml: Contains the functions that evaluate expressions, statements, and blocks of statements.


## Usage

The source code must be written in a file, for example, "prog.ml", which must contain a value of type Ast.prog. This value must be passed to the Interp.eval function.

shell
let prog = ... (* define the Ast.prog value *)
Interp.eval prog;;

## References

For more information on the project, please refer to the following link: https://pablo.rauzy.name/teaching/ic.
