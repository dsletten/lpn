#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch06.pl
%
%   Started:            Sun Aug 25 04:13:31 2013
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

append([], L, L).
append([H|T1], L, [H|T2]) :-
    append(T1, L, T2).

prefix(P, L) :- append(P, _, L).
suffix(S, L) :- append(_, S, L).

sublist(S, L) :-
    prefix(S1, L),
    suffix(S, S1).

%% reverse([H|T], R) :- reverse(T, R, [H]). % See pensoj.
reverse(L, R) :- reverse(L, R, []).
reverse([], R, R).
reverse([H|T], R, L) :-
    reverse(T, R, [H|L]).

%%%
%%%    6.1
%%%
doubled(L) :- append(L1, L1, L).

%% ?- doubled([a, b, c, a, b, c]).
%% true ;
%% false.

%% ?- doubled([foo, gubble, foo, gubble]).
%% true ;
%% false.

%% ?- doubled([foo, gubble, foo]).
%% false.

%% ?- doubled([a, b, c|T]).
%% T = [a, b, c] ;
%% T = [_G305, a, b, c, _G305] ;
%% T = [_G305, _G311, a, b, c, _G305, _G311] ;
%% T = [_G305, _G311, _G317, a, b, c, _G305, _G311, _G317] 

%%%
%%%    6.2
%%%
palindrome(L) :- reverse(L, L).

%% ?- palindrome([r, o, t, a, t, o, r]).
%% true.

%% ?- palindrome([n, u, r, s, e, s, r, u, n]).
%% true.

%% ?- palindrome([n, o, t, h, i, s]).
%% false.

%%%
%%%    6.3 (See 2010 solution)
%%%
%% toptail([_|T], Out) :- append(Out, [_], T).

%% ?- toptail([a], T).
%% false.

%% ?- toptail([a, b], T).
%% T = [] ;
%% false.

%% ?- toptail([a, b, c], T).
%% T = [b] ;
%% false.

%%
%% Inspired by 2010 version
%%
toptail([_|T], Out) :- toptail_aux(T, Out).
toptail_aux([_], []).
toptail_aux([H|T1], [H|T2]) :- toptail_aux(T1, T2).

%%%
%%%    6.4
%%%
%% last(L, X) :- reverse(L, [X|_]).

%% ?- last([a, b, c], c).
%% true.

%% ?- last([a, b, c], C).
%% C = c.

last([X], X).
last([_|T], X) :- last(T, X).

%%%
%%%    6.4
%%%
%% swapfl([X, Y], [Y, X]). %% Unnecessary

%% swapfl([H1|T1], [H2|T2]) :-
%%     append(T3, [H2], T1),
%%     append(T3, [H1], T2).

%% ?- swapfl([a, b, c, d], [d, b, c, a]).
%% true ;
%% false.

%% ?- swapfl([a, b, c, d], X).
%% X = [d, b, c, a] ;
%% false.

%% ?- swapfl([X, b, c, d], [Y, b, c, a]).
%% X = a,
%% Y = d ;
%% false.

%% ?- swapfl([a, d], [d, a]).
%% true ;
%% false.

%%
%% See 2012 non-tail-recursive version.
%% 

swapfl([H1|T1], [H2|T2]) :- swapfl(T1, T2, H1, H2).
swapfl([Z], [A], A, Z).
swapfl([H|T1], [H|T2], A, Z) :-
    swapfl(T1, T2, A, Z).

%%%
%%%    6.6
%%%
house(green, _, _).
house(_, _, zebra).
house(red, english, _).
house(_, spanish, jaguar).
%% house(_, N, snail) :- N \= japanese.
%% house(C, _, snail) :- C \= blue.

%% This assumes house directly to left/right
%% street(L) :-
%%     sublist([house(C1, N1, snail), house(C2, japanese, P2)], L),
%%     sublist([house(C1, N1, snail), house(blue, N3, P3)], L).

street(L) :-
    sublist([house(C1, N1, snail), house(C2, japanese, P2)], L),
    sublist([house(C1, N1, snail), house(blue, N3, P3)], L).

zebra(N) :- house(_, N, zebra).