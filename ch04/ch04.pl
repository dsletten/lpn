%#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   NAME:               ch04.pl
%
%   STARTED:            Wed Sep  1 01:41:15 2010
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

member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

a2b([], []).
a2b([a|T1], [b|T2]) :- a2b(T1, T2).

%%%
%%%    Ex. 4.3
%%%    
second(X, [_, X|_]).

%%%
%%%    Ex. 4.4
%%%
swap12([X, Y|T], [Y, X|T]).

%%%
%%%    Ex. 4.5
%%%
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
listtran([G|Tg], [E|Te]) :-
    tran(G, E),
    listtran(Tg, Te).

%%%
%%%    Ex. 4.6
%%%
twice([], []).
twice([X|Ti], [X, X|To]) :- twice(Ti, To).

%%%
%%%    Practical Session
%%%    
zip([], [], []).
zip([H1|T1], [H2|T2], [H1, H2|T3]) :- zip(T1, T2, T3).

combine1([], [], []).
combine1([H1|T1], [H2|T2], [H1, H2|T3]) :- combine1(T1, T2, T3).

combine2([], [], []).
combine2([H1|T1], [H2|T2], [[H1, H2]|T3]) :- combine2(T1, T2, T3).

combine3([], [], []).
combine3([H1|T1], [H2|T2], [j(H1, H2)|T3]) :- combine3(T1, T2, T3).

%% ?- zip([a, b, c], X, [a, 1, b, 2, c, 3]).
%% X = [1, 2, 3].

%% ?- combine2([a, b, c], X, [[a, 1], [b, 2], [c, 3]]).
%% X = [1, 2, 3].

%% ?- combine3([a, b, c], X, [j(a, 1), j(b, 2), j(c, 3)]).
%% X = [1, 2, 3].
