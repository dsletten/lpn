#!/opt/local/bin/swipl -q -t main -f
%%  -*- Mode: Prolog -*-
%   Name:               cuts.pl
%
%   Started:            Tue Oct  8 00:06:24 2024
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
%   Notes: Bramer 100-102 页
%
%%

%:- module(cuts, []).

sumto1(1, 1).
sumto1(N, S) :-
    N > 1,
    N1 is N - 1,
    sumto1(N1, S1),
    S is S1 + N.

sumto2(1, 1) :- !.
sumto2(N, S) :-
    N1 is N - 1,
    sumto2(N1, S1),
    S is S1 + N.


sumto3(1, S) :- !, S = 1.
sumto3(N, S) :-
    N1 is N - 1,
    sumto3(N1, S1),
    S is S1 + N.

classify1(0, zero).
classify1(N, negative) :- N < 0.
classify1(_, positive).

classify2(0, zero).
classify2(N, negative) :- N < 0.
classify2(N, positive) :- N > 0.

classify3(0, zero) :- !.
classify3(N, negative) :- N < 0, !.
classify3(_, positive).

classify4(0, C) :- !, C = zero.
classify4(N, negative) :- N < 0, !.
classify4(_, positive).

% LPN solution...
classify5(0, zero) :- !.
classify5(N, negative) :- N < 0, !.
classify5(N, positive) :- N > 0, !.

classify6(0, zero).
classify6(N, negative) :- N < 0, !.
classify6(N, positive) :- N > 0, !.

factorial(0, K) :- !, K = 1.
factorial(N, K) :-
    N1 is N - 1,
    factorial(N1, K1),
    K is N * K1.
