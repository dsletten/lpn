#!/opt/local/bin/swipl -q -t main -f
%%  -*- Mode: Prolog -*-
%   Name:               travel.pl
%
%   Started:            Mon May 13 23:22:29 2024
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

%:- module(travel, []).

byCar(auckland, hamilton).
byCar(hamilton, raglan).
byCar(valmont, saarbrücken).
byCar(valmont, metz).

byTrain(metz, frankfurt).
byTrain(saarbrücken, frankfurt).
byTrain(metz, paris).
byTrain(saarbrücken, paris).

byPlane(frankfurt, bangkok).
byPlane(frankfurt, singapore).
byPlane(paris, losAngeles).
byPlane(bangkok, auckland).
byPlane(singapore, auckland).
byPlane(losAngeles, auckland).

travel(S, D) :- byCar(S, D).
travel(S, D) :- byTrain(S, D).
travel(S, D) :- byPlane(S, D).

travel(S, D) :-
    byCar(S, D1),
    travel(D1, D).
travel(S, D) :-
    byTrain(S, D1),
    travel(D1, D).
travel(S, D) :-
    byPlane(S, D1),
    travel(D1, D).

%% travel(S, D, go(S, D)) :- byCar(S, D).
%% travel(S, D, go(S, D)) :- byTrain(S, D).
%% travel(S, D, go(S, D)) :- byPlane(S, D).

%% travel(S, D, go(S, D1, G)) :-
%%     byCar(S, D1),
%%     travel(D1, D, G).
%% travel(S, D, go(S, D1, G)) :-
%%     byTrain(S, D1),
%%     travel(D1, D, G).
%% travel(S, D, go(S, D1, G)) :-
%%     byPlane(S, D1),
%%     travel(D1, D, G).

%% ?- travel(valmont, losAngeles, Itinerary).
%% Itinerary = go(valmont, 'saarbrücken', go('saarbrücken', paris, go(paris, losAngeles))) ;
%% Itinerary = go(valmont, metz, go(metz, paris, go(paris, losAngeles))) ;
%% false.

%% ?- travel(paris, losAngeles, I).
%% I = go(paris, losAngeles) ;
%% false.

travel(S, D, byCar(S, D)) :- byCar(S, D).
travel(S, D, byTrain(S, D)) :- byTrain(S, D).
travel(S, D, byPlane(S, D)) :- byPlane(S, D).

travel(S, D, byCar(S, D1, G)) :-
    byCar(S, D1),
    travel(D1, D, G).
travel(S, D, byTrain(S, D1, G)) :-
    byTrain(S, D1),
    travel(D1, D, G).
travel(S, D, byPlane(S, D1, G)) :-
    byPlane(S, D1),
    travel(D1, D, G).
