#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               travel.pl
%
%   Started:            Mon Aug 12 20:41:11 2013
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

:- op(500, xfy, car).
:- op(500, xfy, train).
:- op(500, xfy, plane).


byCar(auckland,hamilton). 
byCar(hamilton,raglan). 
byCar(valmont,saarbruecken). 
byCar(valmont,metz). 

byTrain(metz,frankfurt). 
byTrain(saarbruecken,frankfurt). 
byTrain(metz,paris). 
byTrain(saarbruecken,paris). 

byPlane(frankfurt,bangkok). 
byPlane(frankfurt,singapore). 
byPlane(paris,losAngeles). 
byPlane(bangkok,auckland). 
byPlane(singapore,auckland). 
byPlane(losAngeles,auckland).

travel(From, To) :- byCar(From, To).
travel(From, To) :- byTrain(From, To).
travel(From, To) :- byPlane(From, To).
travel(From, To) :-
    (byCar(From, X); byTrain(From, X); byPlane(From, X)),
    travel(X, To).

%% travel(From, To, go(From, To)) :- byCar(From, To).
%% travel(From, To, go(From, To)) :- byTrain(From, To).
%% travel(From, To, go(From, To)) :- byPlane(From, To).
%% travel(From, To, go(From, X, Route)) :-
%%     (byCar(From, X); byTrain(From, X); byPlane(From, X)),
%%     travel(X, To, Route).

travel(From, To, From car To) :- byCar(From, To).
travel(From, To, From train To) :- byTrain(From, To).
travel(From, To, From plane To) :- byPlane(From, To).
travel(From, To, From car Route) :-
    byCar(From, X),
    travel(X, To, Route).
travel(From, To, From train Route) :-
    byTrain(From, X),
    travel(X, To, Route).
travel(From, To, From plane Route) :-
    byPlane(From, X),
    travel(X, To, Route).
