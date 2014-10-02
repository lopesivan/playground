(* USAGE:                  *)
(* math < matriz_inversa.m *)
(*                         *)

(* matriz A *)
A = {{2, 3}, {1, -1}}
MatrixForm[A]

(* matriz B *)
B = Inverse[A]
MatrixForm[B]


(* matriz I *)
MatrixForm[A.B]

