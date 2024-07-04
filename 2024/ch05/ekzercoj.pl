#!/opt/local/bin/swipl -q -t main -f
%%  -*- Mode: Prolog -*-
%   Name:               ekzercoj.pl
%
%   Started:            Sat Jun  8 16:40:01 2024
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

%:- module(ekzercoj, []).

%%%
%%%    见 Lisp notes pg. 12
%%%    

maximum(X, Y, M) :-
    M is (X + Y + abs(X -Y)) / 2.
minimum(X, Y, M) :-
    maximum(-X, -Y, M1),
    M is -M1.

%% ?- maximum(2, 3, M).
%% M = 3.

%% ?- maximum(20.3, 3, M).
%% M = 20.3.

%% ?- maximum(2, 2.0, M).
%% M = 2.0.

%% ?- maximum(2.0, 2, M).
%% M = 2.0.

%% ?- minimum(2, 3, M).
%% M = 2.

%% ?- minimum(20, 3, M).
%% M = 3.

%% ?- minimum(2, 2.0, M).
%% M = 2.0.

%% ?- minimum(2, 2.0, M).
%% M = 2.0.

%%%
%%%    5.2
%%%    1.
%%%
increment(X, Y) :-
    var(X),
    integer(Y),
    X is Y - 1.
%% increment(X, Y) :-
%%     integer(X),
%%     var(Y),
%%     Y is X + 1.
%% increment(X, Y) :-
%%     integer(X),
%%     integer(Y),
%%     Y is X + 1.
increment(X, Y) :-
    integer(X),
    Y is X + 1.

%% ?- increment(4, 5).
%% true.

%% ?- increment(4, 6).
%% false.

%% ?- increment(4, Y).
%% Y = 5.

%% ?- increment(X, 5).
%% X = 4 ;
%% false.

%%%
%%%    2.
%%%
sum(X, Y, Z) :-
    var(X),
    number(Y),
    number(Z),
    X is Z - Y.
sum(X, Y, Z) :-
    number(X),
    var(Y),
    number(Z),
    Y is Z - X.
sum(X, Y, Z) :-
    number(X),
    number(Y),
    Z is X + Y.

%% ?- sum(4, 5, 9).
%% true.

%% ?- sum(4, 6, 12).
%% false.

%% ?- sum(4, 6, S).
%% S = 10.

%% ?- sum(4, X, 12).
%% X = 8 ;
%% false.

%% ?- sum(X, 6, 12).
%% X = 6 ;
%% false.

%%%
%%%    5.3
%%%
addone([], []).
addone([X|Xs], [Y|Ys]) :-
    Y is X + 1,
    addone(Xs, Ys).

%% ?- addone([1, 2, 7, 2], X).
%% X = [2, 3, 8, 3].

%% ?- addone([1, 2, 7, 2], [2, 3, 8, 3]).
%% true.

scalarMult(_, [], []).
scalarMult(A, [X|Xs], [Y|Ys]) :-
    Y is X * A,
    scalarMult(A, Xs, Ys).

%% ?- scalarMult(3, [2, 7, 4], V).
%% V = [6, 21, 12] ;
%% false.

%% ?- scalarMult(3, [2, 7, 4], [6, 21, 12]).
%% true ;
%% false.

dot(Xs, Ys, P) :-
    dot(Xs, Ys, P, 0).
dot([], [], P, P).
dot([X|Xs], [Y|Ys], P, P1) :-
    P2 is P1 + X * Y,
    dot(Xs, Ys, P, P2).

%% ?- dot([2, 5, 6], [3, 4, 1], P).
%% P = 32.

%% ?- dot([2, 5, 6], [3, 4, 1], 32).
%% true.
