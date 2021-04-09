#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               exercises.pl
%
%   Started:            Fri Mar  5 20:11:49 2021
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
directlyIn(katarina, olga).
directlyIn(olga, natasha).
directlyIn(natasha, irina).

in(X, Y) :- directlyIn(X, Y).
in(X, Y) :- directlyIn(X, Z),
            in(Z, Y).

in2(X, Y) :- directlyIn(X, Y).
in2(X, Y) :- directlyIn(Z, Y),
             in2(X, Z).

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

travelFromTo(From, To) :- directTrain(From, To).
travelFromTo(From, To) :- directTrain(From, By),
                          travelFromTo(By, To).

%%%
%%%    3.4
%%%
greater_than(succ(_), 0) :- !.
greater_than(succ(X), succ(Y)) :- greater_than(X, Y).

%%%
%%%    3.5
%%%
swap(leaf(X), leaf(X)).
%swap(tree(leaf(L), leaf(R)), tree(leaf(R), leaf(L))). % Why is this unneeded??
swap(tree(L1, R1), tree(R, L)) :- swap(L1, L),
                                  swap(R1, R).
