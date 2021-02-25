%#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   NAME:               ch05.pl
%
%   STARTED:            Mon Sep 13 14:40:33 2010
%   MODIFICATIONS:
%
%   PURPOSE:
%
%
%
%   CALLING SEQUENCE:
%
%
%   INPUTS:
%
%   OUTPUTS:
%
%   EXAMPLE:
%
%   NOTES:
%
%%

f(X, Y) :- Y is (X+3)*2.

length([], 0).
length([_|T], Len) :- length(T, Len1), Len is Len1 + 1.

length(L, Len) :- length(L, Len, 0).
length([], Len, Len).
length([_|T], Len, Acc) :- Acc1 is Acc + 1, length(T, Len, Acc1).

%% max_list([X], X).
%% max_list([H|T], M) :-
%%     max_list(T, M1),
%%     M is max(H, M1).

max_list([H|T], M) :- max_list(T, M, H).
max_list([], M, M).
max_list([X|T], M, M1) :-
    M2 is max(X, M1),
    max_list(T, M, M2).

%% max_list([X|T], M, M1) :-
%%     M1 > X,
%%     max_list(T, M, M1).
%% max_list([X|T], M, M1) :-
%%     M1 =< X,
%%     max_list(T, M, X).

increment(X, Y) :- Y is X + 1.

sum(X, Y, Z) :- Z is X + Y.

addone([], []).
addone([H1|T1], [H2|T2]) :-
    increment(H1, H2),
    addone(T1, T2).

%% ?- addone([1, 2, 7, 2], X).
%% X = [2, 3, 8, 3].

%% ?- addone([1, 2, 7, 2], [2, 3, 8, 3]).
%% true.

acc_min([H|T], Min) :- acc_min(T, Min, H).
acc_min([], Min, Min).
acc_min([H|T], Min, Min1) :-
    Min1 =< H,
    acc_min(T, Min, Min1).
acc_min([H|T], Min, Min1) :-
    Min1 > H,
    acc_min(T, Min, H).

scalar_mult(K, [], []).
scalar_mult(K, [H|T], [H1|T1]) :-
    H1 is K * H,
    scalar_mult(K, T, T1).

%% dot_product([], [], 0).
%% dot_product([H1|T1], [H2|T2], Sum) :-
%%     dot_product(T1, T2, Sum1),
%%     Sum is Sum1 + H1 * H2.

%% ?- dot_product([2, 5, 6], [3, 4, 1], X).
%% X = 32.

%% ?- dot_product([2, 5, 6], [3, 4, 1, 9], X).
%% false.

dot_product(V1, V2, Sum) :- dot_product(V1, V2, Sum, 0).
dot_product([], [], Sum, Sum).
dot_product([H1|T1], [H2|T2], Sum, Sum1) :-
    Sum2 is Sum1 + H1 * H2,
    dot_product(T1, T2, Sum, Sum2).
