#!/opt/local/bin/swipl -q -t main -f
%%  -*- Mode: Prolog -*-
%   Name:               ekzercoj.pl
%
%   Started:            Thu Oct 10 00:12:20 2024
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
%%%    10.3
%%%    
split([], [], []).
split([H|T], [H|P], N) :-
    H >= 0,
    split(T, P, N).
split([H|T], P, [H|N]) :-
    H < 0,
    split(T, P, N).

splitc([], [], []).
splitc([H|T], [H|P], N) :-
    H >= 0, !,
    splitc(T, P, N).
splitc([H|T], P, [H|N]) :-
    H < 0,
    splitc(T, P, N).

classify(0, zero) :- !.
classify(Number, negative) :- Number < 0, !.
classify(Number, positive) :- Number > 0, !.

splitcl([], [], []).
splitcl([H|T], P, [H|N]) :-
    classify(H, negative), !,
    splitc(T, P, N).
splitcl([H|T], [H|P], N) :-
    \+ classify(H, negative), !,
    splitcl(T, P, N).

%% ?- splitcl([3, 4, -5, -1, 0, 4, -9], P, N).
%% P = [3, 4, 0, 4],
%% N = [-5, -1, -9].

%%%
%%%    10.4
%%%
directTrain(saarbrücken, dudweiler).
directTrain(forbach, saarbrücken).
directTrain(freyming, forbach).
directTrain(stAvold, freyming).
directTrain(faulquemont, stAvold).
directTrain(metz, faulquemont).
directTrain(nancy, metz).

connected(A, B) :- directTrain(A, B).
connected(A, B) :- directTrain(B, A).

%% route(A, B, [A, B]) :-
%%     connected(A, B).
%% route(A, B, [A|R]) :-
%%     connected(A, C),
%%     route(C, B, R).

% L must be instantiated to check for membership!
% Thus -> accumulator
route(A, B, R) :-
    route(A, B, R, []).

route(A, A, [A|L], L).
route(A, B, R, L) :-
    \+ member(B, L),
    \+ member(A, L),
    connected(C, B),
    route(A, C, R, [B|L]).

%%%
%%%    Practical Session
%%%
%%%    Not unifiable
%%%    
nu1(X, Y) :- \+ X = Y.

%% ?- nu1(f(a, b), f(a, b)).
%% false.

%% ?- nu1(f(a, b), f(a, b, c)).
%% true.

%% ?- nu1(f(g(X), h(b)), f(g(a), h(Y))).
%% false.

%% ?- X = c, nu1(f(g(X), h(b)), f(g(a), h(Y))).
%% X = c.

%nu2(X, Y) :-

nu3(X, X) :- !, fail.
nu3(_, _).

%%%
%%%    Unifiable
%%%
unifiable([], _, []).
unifiable([H|T1], Term, [H|T2]) :-
    \+ nu1(H, Term),
    unifiable(T1, Term, T2).
unifiable([H|T1], Term, T2) :-
    nu1(H, Term),
    unifiable(T1, Term, T2).

unifiable_bad([], _, []).
unifiable_bad([H|T1], H, [H|T2]) :-
    unifiable_bad(T1, H, T2).
unifiable_bad([H|T1], Term, T2) :-
    nu1(H, Term),
    unifiable_bad(T1, Term, T2).

neg(Goal) :- write(Goal), nl, Goal, write(Goal), nl, !, fail.
neg(Goal).
