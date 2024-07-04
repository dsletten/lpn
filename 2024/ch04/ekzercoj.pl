#!/opt/local/bin/swipl -q -t main -f
%%  -*- Mode: Prolog -*-
%   Name:               ekzercoj.pl
%
%   Started:            Wed Jun  5 01:49:28 2024
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

%% ?- second(a, [a]).
%% false.

%% ?- second(a, [b, a]).
%% true.

%% ?- second(a, [b, a, c]).
%% true.

%% ?- second(b, [b, a, c]).
%% false.

%% ?- second(X, [a, b, c, d]).
%% X = b.

%% ?- second(X, [a, b]).
%% X = b.

%% ?- second(X, [a]).
%% false.

%% ?- second(a, L).
%% L = [_, a|_].

%%%
%%%    4.4
%%%
%swap12([A, B|_], [B, A|_]).

%% ?- swap12([a, b, c], [b, a, c]).
%% true.

%% ?- swap12([a, b, c], L).
%% L = [b, a|_].

%% ?- swap12([a, b, c], [X, Y, c]).
%% X = b,
%% Y = a.

%%%
%%%    D'oh! This is wrong...
%%%    
%% ?- swap12([a, b, c], [b, a, c, d, e]).
%% true.

%%%
%%%    见 2019
%%%
swap12([X, Y|T], [Y, X|T]).

%% ?- swap12([a, b, c], [b, a, c, d, e]).
%% false.

%% ?- swap12([a, b, c], L).
%% L = [b, a, c].

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
listtran([D|Td], [E|Te]) :-
    tran(D, E),
    listtran(Td, Te).

%%%
%%%    4.6
%%%
twice([], []).
twice([X|Xs], [X, X|Ys]) :-
    twice(Xs, Ys).

%% ?- twice([a, 4, buggle], X).
%% X = [a, a, 4, 4, buggle, buggle].

%% ?- twice([1, 2, 1, 1], X).
%% X = [1, 1, 2, 2, 1, 1, 1, 1].

%% ?- twice(X, [a, a, 4, 4, buggle, buggle]).
%% X = [a, 4, buggle].



combine1([], [], []).
combine1([A|As], [B|Bs], [A, B|Cs]) :-
    combine1(As, Bs, Cs).

%% ?- combine1([a, b, c], [1, 2, 3], X).
%% X = [a, 1, b, 2, c, 3].

%% ?- combine1([a, b, c], [1, 2, 3, 4], X).
%% false.

%% ?- combine1([f, b, yip, yup], [glu, gla, gli, glo], Result).
%% Result = [f, glu, b, gla, yip, gli, yup, glo].

combine1a([], _, []).
combine1a(_, [], []).
combine1a([A|As], [B|Bs], [A, B|Cs]) :-
    combine1a(As, Bs, Cs).

%% ?- combine1a([a, b, c], [1, 2, 3], X).
%% X = [a, 1, b, 2, c, 3] ;
%% X = [a, 1, b, 2, c, 3].

%% ?- combine1a([a, b, c], [1, 2, 3, 4], X).
%% X = [a, 1, b, 2, c, 3] ;
%% false.

%% ?- combine1a([a, b, c, d], [1, 2, 3], X).
%% X = [a, 1, b, 2, c, 3] ;
%% false.

combine2([], [], []).
combine2([A|As], [B|Bs], [[A, B]|Cs]) :-
    combine2(As, Bs, Cs).

%% ?- combine2([a, b, c], [1, 2, 3], X).
%% X = [[a, 1], [b, 2], [c, 3]].

%% ?- combine2([a, b, c], [1, 2, 3, 4], X).
%% false.

%% ?- combine2([a, b, c, d], [1, 2, 3], X).
%% false.

%% ?- combine2([f, b, yip, yup], [glu, gla, gli, glo], Result).
%% Result = [[f, glu], [b, gla], [yip, gli], [yup, glo]].

combine2a([], _, []).
combine2a(_, [], []).
combine2a([A|As], [B|Bs], [[A, B]|Cs]) :-
    combine2a(As, Bs, Cs).

%% ?- combine2a([a, b, c], [1, 2, 3], X).
%% X = [[a, 1], [b, 2], [c, 3]] ;
%% X = [[a, 1], [b, 2], [c, 3]].

%% ?- combine2a([a, b, c], [1, 2, 3, 4], X).
%% X = [[a, 1], [b, 2], [c, 3]] ;
%% false.

%% ?- combine2a([a, b, c, d], [1, 2, 3], X).
%% X = [[a, 1], [b, 2], [c, 3]] ;
%% false.

combine3([], [], []).
combine3([A|As], [B|Bs], [j(A, B)|Cs]) :-
    combine3(As, Bs, Cs).

combine3a([], _, []).
combine3a(_, [], []).
combine3a([A|As], [B|Bs], [j(A, B)|Cs]) :-
    combine3a(As, Bs, Cs).

%% ?- combine3([a, b, c], [1, 2, 3], X).
%% X = [j(a, 1), j(b, 2), j(c, 3)].

%% ?- combine3([a, b, c], [1, 2, 3, 4], X).
%% false.

%% ?- combine3([a, b, c, d], [1, 2, 3], X).
%% false.

%% ?- combine3([f, b, yip, yup], [glu, gla, gli, glo], Result).
%% Result = [j(f, glu), j(b, gla), j(yip, gli), j(yup, glo)].

%% ?- combine3a([a, b, c], [1, 2, 3], X).
%% X = [j(a, 1), j(b, 2), j(c, 3)] ;
%% X = [j(a, 1), j(b, 2), j(c, 3)].

%% ?- combine3a([a, b, c, d], [1, 2, 3], X).
%% X = [j(a, 1), j(b, 2), j(c, 3)] ;
%% false.

%% ?- combine3a([a, b, c], [1, 2, 3, 4], X).
%% X = [j(a, 1), j(b, 2), j(c, 3)] ;
%% false.
