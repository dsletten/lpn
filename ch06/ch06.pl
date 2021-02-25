%#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   NAME:               ch06.pl
%
%   STARTED:            Mon Sep 20 00:54:45 2010
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

append([], L, L).
append([H|T1], L, [H|T2]) :-
    append(T1, L, T2).

reverse([], []).
%% reverse([H|T], R) :-
%%     reverse(T, R1),
%%     append(R1, [H], R).

reverse([H|T], R) :- reverse(T, R, [H]).
reverse([], R, R).
reverse([H|T1], R, T2) :- reverse(T1, R, [H|T2]).

prefix(P, L) :- append(P, _, L).
suffix(S, L) :- append(_, S, L).

sublist(L1, L) :- suffix(L2, L), prefix(L1, L2).

%%%
%%%    Exercises
%%%

%%%
%%%    6.1
%%%    
doubled(L) :- append(L1, L1, L).

%%%
%%%   6.2
%%%   
%palindrome(L) :- reverse(L, L1), L = L1.
palindrome(L) :- reverse(L, L).
%palindrome(L) :- reverse(L, L1), append(L, L1, L2), doubled(L2).

%%%
%%%    6.3
%%%    
%toptail([_, _], []).
%% toptail([_, A|T1], T2) :- toptail(T1, T2, A).
%% toptail([], [], _).
%% toptail([B, _], [A, B], A).

toptail([_, _], []).
toptail([_, A|T1], [A|T2]) :- toptail_aux(T1, T2).
toptail_aux([_], []).
toptail_aux([H|T1], [H|T2]) :- toptail_aux(T1, T2).


%% toptail([], [], _).
%% toptail([B, _], [A, B], A).



%toptail([_, A|T1], [A|T2]) :- toptail(T1, T2).

%%%
%%%    I.e., (reverse (rest (reverse (rest in-list))))
%%%    
%toptail([_|T], Out) :- reverse(T, [_|T1]), reverse(T1, Out).

%toptail(InList, OutList) :- append([_|OutList], [_], InList). % Nice!!

%%%
%%%    6.4
%%%    
%% last(Elt, L) :- reverse(L, L1), L1 = [Elt|_].

%% last([Elt], Elt).
%% last([_|T], Elt) :- last(T, Elt).

last(L, X) :- reverse(L, [X|_]).

%%%
%%%    6.5
%%%
%% swapfl([Elt1|T1], L2) :-
%%     reverse(T1, [Elt2|T2]),
%%     reverse(T2, L3),
%%     append([Elt2|L3], [Elt1], L2).

swapfl([Elt1|T1], L2) :- swapfl(Elt1, T1, L2).
swapfl(First, [Last], [Last, First]).
swapfl(First, [H1|T], L) :- swapfl(First, T, [H2|T2]), L = [H2, H1|T2].

pet(jaguar).
pet(snail).
pet(zebra).
color(red).
color(blue).
color(green).
nationality(englishman).
nationality(spaniard).
nationality(japanese).
position(1).
position(2).
position(3).


%% house(Position1, red, englishman, Pet1).
%% house(Position2, Color1, spaniard, jaguar).
%% house(Position3, Color2, japanese, !snail).
%% house(Position4, 

member(X, L) :- append(_, [X|_], L).

set([], []).
set([H|T1], T2) :- member(H, T1), set(T1, T2).
set([H|T1], [H|T2]) :- set(T1, T2).

%% flatten([], []).
%% flatten([H|T], L) :- H = [_|_], flatten(H, L1), flatten(T, L2), append(L1, L2, L).
%% flatten([H|T1], [H|T2]) :- flatten(T1, T2).

%%%
%%%    No append!
%%%    
%% flatten([], []).
%% flatten([[]|T], L) :- flatten(T, L).
%% flatten([[H|T]|T1], L) :- flatten([H, T|T1], L).
%% flatten([H|T], [H|L]) :- flatten(T, L).

flatten(L1, L2) :- flatten(L1, L2, []).
flatten([], L, L).
flatten([H|T], L, Acc) :- H = [_|_], flatten(T, L1, Acc), flatten(H, L, L1).
flatten([H|T], [H|L], Acc) :- flatten(T, L, Acc).

