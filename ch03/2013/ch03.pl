#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch03.pl
%
%   Started:            Mon Aug 12 00:29:49 2013
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

%%%
%%%    3.2
%%%
%%%
directlyIn(natasha, irina).
directlyIn(olga, natasha).
directlyIn(katarina, olga).

in(Outer, Inner) :- directlyIn(Outer, Inner).
%% in(Outer, Inner) :-
%%     directlyIn(X, Inner),
%%     in(Outer, X).
in(Outer, Inner) :-
    directlyIn(Outer, X),
    in(X, Inner).

%%%
%%%    3.3
%%%
directTrain(saarbruecken, dudweiler).
directTrain(forbach, saarbruecken).
directTrain(freyming, forbach).
directTrain(stAvold, freyming).
directTrain(fahlquemont, stAvold).
directTrain(metz, fahlquemont).
directTrain(nancy, metz).

travelFromTo(From, To) :- directTrain(From, To).
travelFromTo(From, To) :-
    directTrain(From, X),
    travelFromTo(X, To).

%%%
%%%    3.5
%%%
swap(leaf(Label), leaf(Label)).
swap(tree(Left, Right), tree(RightS, LeftS)) :-
    swap(Left, LeftS),
    swap(Right, RightS).
