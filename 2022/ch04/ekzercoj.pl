#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ekzercoj.pl
%
%   Started:            Sun Sep 18 20:20:51 2022
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
%%%    4.3
%%%    
second(X, [_, X|_]).

%% ?- second(a, [a, b, c]).
%% false.

%% ?- second(b, [a, b, c]).
%% true.

%% ?- second(c, [a, b, c]).
%% false.

%% ?- second(b, [a, b]).
%% true.

%%%
%%%    4.4
%%%
swap12([A, B|T], [B, A|T]).

%% ?- swap12([a, b, c], [b, a, c]).
%% true.

%% ?- swap12([a, b], [b, a]).
%% true.

%% ?- swap12([a, a], [a, a]).
%% true.

%% ?- swap12([a, b], [b, c]).
%% false.

%%%
%%%    4.5
%%%
tran(eins, one).
tran(zwei, two).
tran(drei, three).
tran(vier, four).
tran(fünf, five).
tran(sechs, six).
tran(sieben, seven).
tran(acht, eight).
tran(neun, nine).

listtran([], []).
listtran([G|Gs], [E|Es]) :-
    tran(G, E),
    listtran(Gs, Es).

%% ?- listtran([eins, neun, zwei], L).
%% L = [one, nine, two].

%% ?- listtran(L, [one, seven, six, two]).
%% L = [eins, sieben, sechs, zwei].

%%%
%%%    4.6
%%%
twice([], []).
twice([A|As], [A, A|Bs]) :-
    twice(As, Bs).

%% ?- twice([a, 4, buggle], L).
%% L = [a, a, 4, 4, buggle, buggle].

%% ?- twice([1, 2, 1, 1], L).
%% L = [1, 1, 2, 2, 1, 1, 1, 1].

%% ?- twice(L, [a, a, b, b, c, c]).
%% L = [a, b, c].

%% ?- twice(L, [a, a, b, b, c]).
%% false.
