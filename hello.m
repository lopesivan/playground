#!/usr/local/bin/MathKernel -script

Print["Hello World!"]

(* USAGE:                  *)
(* math < matriz_inversa.m *)
(*                         *)

(* matriz A *)
A = {{2, 3}, {1, -1}}
Print[A]

(* matriz B *)
B = Inverse[A]
Print[B]


(* matriz I *)
Print[A.B]


