#! /usr/local/bin/MathematicaScript -script

(* plot-bsplines.m *)
(* Brandon Amos *)

bspline[j_Integer, 1, t_List,x_] := If[
    t[[j]] <= x < t[[j+1]],
    1.0,
    0.0
];

(* Use the recurrence relationship de Boor gives on page 90. *)
bspline[i_Integer, k_Integer, t_List, x_] :=
    If[ t[[i+k-1]] == t[[i]],
        0.0,
        (x-t[[i]])/(t[[i+k-1]] - t[[i]])*bspline[i,k-1,t,x]
    ] +
    If[ t[[i+k]] == t[[i+1]],
        0.0,
        (t[[i+k]]-x)/(t[[i+k]]-t[[i+1]])*bspline[i+1,k-1,t,x]
    ];

(* Iterate through all of the splines and plot them. *)
makeSpline[knots_, order_Integer, minItem_, maxItem_, i_Integer] := Module[
    {spline, splinePlot},
    spline[x_] = bspline[i, order, knots, x];
    splinePlot = Plot[spline[x], {x, minItem, maxItem}, PlotRange->{0,1},
        PlotLabel->"B-Spline B" <> ToString[i] <> "(x)"];
    Export[Directory[] <> "/figures/1-B" <> ToString[i] <> ".jpg",
        splinePlot];
];

knots = {0, 1, 1, 3, 4, 6, 6, 6}; order = 3;
(makeSpline[knots, order, First[knots], Last[knots], #])& /@
    Range[1,Length[knots]-order];
