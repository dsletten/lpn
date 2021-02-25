%#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   NAME:               travel.pl
%
%   STARTED:            Sat Aug 28 22:42:35 2010
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

byCar(auckland, hamilton).
byCar(hamilton, raglan).
byCar(valmont, saarbruecken).
byCar(valmont, metz).

byTrain(metz, frankfurt).
byTrain(saarbruecken, frankfurt).
byTrain(metz, paris).
byTrain(saarbruecken, paris).

byPlane(frankfurt, bangkok).
byPlane(frankfurt, singapore).
byPlane(paris, losAngeles).
byPlane(bangkok, auckland).
byPlane(singapore, auckland).
byPlane(losAngeles, auckland).

travel(X, Y) :- byCar(X, Y).
travel(X, Y) :- byTrain(X, Y).
travel(X, Y) :- byPlane(X, Y).

travel(X, Y) :-
    byCar(X, Z),
    travel(Z, Y).
travel(X, Y) :-
    byTrain(X, Z),
    travel(Z, Y).
travel(X, Y) :-
    byPlane(X, Z),
    travel(Z, Y).

    
%% travel(X, Y, go(X, Y)) :- byCar(X, Y).
%% travel(X, Y, go(X, Y)) :- byTrain(X, Y).
%% travel(X, Y, go(X, Y)) :- byPlane(X, Y).

%% %%%
%% %%%    We want an explicit itinerary, but this allows tacit (transitive) connections
%% %%%    e.g., a->b->c go(a, c)
%% %%%    
%% %travel(X, Y, go(X, Y1, Z1)) :- travel(X, Y1), travel(Y1, Y, Z1).
%% travel(X, Y, go(X, Y1, Z1)) :- byCar(X, Y1), travel(Y1, Y, Z1).
%% travel(X, Y, go(X, Y1, Z1)) :- byTrain(X, Y1), travel(Y1, Y, Z1).
%% travel(X, Y, go(X, Y1, Z1)) :- byPlane(X, Y1), travel(Y1, Y, Z1).

travel(X, Y, go(byCar, X, Y)) :- byCar(X, Y).
travel(X, Y, go(byTrain, X, Y)) :- byTrain(X, Y).
travel(X, Y, go(byPlane, X, Y)) :- byPlane(X, Y).

travel(X, Y, go(byCar, X, Y1, Z1)) :- byCar(X, Y1), travel(Y1, Y, Z1).
travel(X, Y, go(byTrain, X, Y1, Z1)) :- byTrain(X, Y1), travel(Y1, Y, Z1).
travel(X, Y, go(byPlane, X, Y1, Z1)) :- byPlane(X, Y1), travel(Y1, Y, Z1).
