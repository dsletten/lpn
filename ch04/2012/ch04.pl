#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch04.pl
%
%   Started:            Wed Feb  8 23:35:20 2012
%   Modifications:
%
%   Purpose:
%
%
%
%   Calling Sequence:
%
%
%   Inputs:
%
%   Outputs:
%
%   Example:
%
%   Notes:
%
%%

%%%
%%%    4.3
%%%
second(X, L) :- [_, X | _] = L.

% !!
%second(X, [_, X| _]).

%%%
%%%    4.4
%%%    The first 2 clauses here are not part of the specification...
swap12([], []).
swap12([X], [X]).
swap12([X, Y | T1], [Y, X | T1]).

%%%
%%%    4.5
%%%
%%%(map nil #'(lambda (s1 s2) (format t "tran(~A, ~A).~%" (string-downcase (symbol-name s1)) s2)) '(eins zwei drei vier fuenf sechs sieben acht neun) (loop for i from 1 to 9 collect (format nil "~R" i)))
tran(eins, one).
tran(zwei, two).
tran(drei, three).
tran(vier, four).
tran(fuenf, five).
tran(sechs, six).
tran(sieben, seven).
tran(acht, eight).
tran(neun, nine).

listtran([], []).
listtran([H1|T1], [H2|T2]) :- tran(H1, H2), listtran(T1, T2).

%%%
%%%    4.6
%%%
twice([], []).
twice([H1|T1], [H1, H1|T2]) :- twice(T1, T2).

%% ?- twice(X, [1, 1, 2, 2, 3, 3]).
%% X = [1, 2, 3] ;
%% false.

zip1([], [], []).
zip1([H1|T1], [H2|T2], [H1, H2 | T3]) :- zip1(T1, T2, T3).

zip2([], [], []).
zip2([H1|T1], [H2|T2], [[H1, H2] | T3]) :- zip2(T1, T2, T3).

zip3([], [], []).
zip3([H1|T1], [H2|T2], [j(H1, H2) | T3]) :- zip3(T1, T2, T3).
