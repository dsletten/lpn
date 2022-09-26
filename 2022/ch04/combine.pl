#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               combine.pl
%
%   Started:            Mon Sep 26 02:01:01 2022
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

%:- module(combine, []).

combine1([], [], []).
combine1([A|As], [B|Bs], [A,B|Cs]) :-
    combine1(As, Bs, Cs).

%% ?- combine1([a, b, c], [1, 2, 3], X).
%% X = [a, 1, b, 2, c, 3].

%% ?- combine1([f, b, yip, yup], [glu, gla, gli, glo], Result).
%% Result = [f, glu, b, gla, yip, gli, yup, glo].

combine2([], [], []).
combine2([A|As], [B|Bs], [[A, B]|Cs]) :-
    combine2(As, Bs, Cs).

%% ?- combine2([a, b, c], [1, 2, 3], X).
%% X = [[a, 1], [b, 2], [c, 3]].

%% ?- combine2([f, b, yip, yup], [glu, gla, gli, glo], Result).
%% Result = [[f, glu], [b, gla], [yip, gli], [yup, glo]].

combine3([], [], []).
combine3([A|As], [B|Bs], [j(A, B)|Cs]) :-
    combine3(As, Bs, Cs).

%% ?- combine3([a, b, c], [1, 2, 3], X).
%% X = [j(a, 1), j(b, 2), j(c, 3)].

%% ?- combine3([f, b, yip, yup], [glu, gla, gli, glo], Result).
%% Result = [j(f, glu), j(b, gla), j(yip, gli), j(yup, glo)].
