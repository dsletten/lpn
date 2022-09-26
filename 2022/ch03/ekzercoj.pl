#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ekzercoj.pl
%
%   Started:            Tue Apr 19 01:04:14 2022
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
%%%    3.2
%%%    
directly_in(katarina, olga).
directly_in(olga, natasha).
directly_in(natasha, irina).

in(X, Y) :-
    directly_in(X, Y).
in(X, Y) :-
    directly_in(X, Z),
    in(Z, Y).

%%%
%%%    3.3
%%%
directTrain(saarbrücken, dudweiler).
directTrain(forbach, saarbrücken).
directTrain(freyming, forbach).
directTrain(stAvold, freyming).
directTrain(faulquemont, stAvold).
directTrain(metz, faulquemont).
directTrain(nancy, metz).

travelFromTo(X, Y) :-
    directTrain(X, Y).
travelFromTo(X, Y) :-
    directTrain(X, Z),
    travelFromTo(Z, Y).

%%%
%%%    3.4
%%%
greater_than(succ(_), 0).
greater_than(succ(X), succ(Y)) :-
    greater_than(X, Y).

%% ?- One = succ(0), Two = succ(One), greater_than(Two, One).
%% One = succ(0),
%% Two = succ(succ(0)).

%% ?- One = succ(0), Two = succ(One), greater_than(One, Two).
%% false.

%% ?- One = succ(0), Two = succ(One), greater_than(Two, Two).
%% false.

%% ?- One = succ(0), Two = succ(One), greater_than(Two, 0).
%% One = succ(0),
%% Two = succ(succ(0)).

%% ?- One = succ(0), Two = succ(One), greater_than(One, 0).
%% One = succ(0),
%% Two = succ(succ(0)).

%% ?- One = succ(0), Two = succ(One), greater_than(succ(is(this, not, pung)), 0).
%% One = succ(0),
%% Two = succ(succ(0)).

%%%
%%%    3.5
%%%
swap(leaf(X), leaf(X)).
swap(tree(L, R), tree(R1, L1)) :-
    swap(L, L1),
    swap(R, R1).

