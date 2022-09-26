#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               travel.pl
%
%   Started:            Sat Apr 23 03:58:32 2022
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

%% travel(Source, Dest) :-
%%     byCar(Source, Dest).
%% travel(Source, Dest) :-
%%     byTrain(Source, Dest).
%% travel(Source, Dest) :-
%%     byPlane(Source, Dest).
%% travel(Source, Dest) :-
%%     byCar(Source, Layover),
%%     travel(Layover, Dest).
%% travel(Source, Dest) :-
%%     byTrain(Source, Layover),
%%     travel(Layover, Dest).
%% travel(Source, Dest) :-
%%     byPlane(Source, Layover),
%%     travel(Layover, Dest).


connected(Source, Dest) :-
    byCar(Source, Dest).
connected(Source, Dest) :-
    byTrain(Source, Dest).
connected(Source, Dest) :-
    byPlane(Source, Dest).

travel(Source, Dest) :-
    connected(Source, Dest).
travel(Source, Dest) :-
    connected(Source, Layover),
    travel(Layover, Dest).

travel(Source, Dest, go(Source, Dest)) :-
    connected(Source, Dest).
travel(Source, Dest, go(Source, Layover, Itinerary)) :-
    connected(Source, Layover),
    travel(Layover, Dest, Itinerary).
%% travel(Source, Dest, go(Source, Layover, Itinerary)) :-
%%     connected(Layover, Dest),
%%     travel(Source, Layover, Itinerary).

travel2(Source, Dest, go(byCar, Source, Dest)) :-
    byCar(Source, Dest).
travel2(Source, Dest, go(byTrain, Source, Dest)) :-
    byTrain(Source, Dest).
travel2(Source, Dest, go(byPlane, Source, Dest)) :-
    byPlane(Source, Dest).
travel2(Source, Dest, go(byCar, Source, Layover, Itinerary)) :-
    byCar(Source, Layover),
    travel2(Layover, Dest, Itinerary).
travel2(Source, Dest, go(byTrain, Source, Layover, Itinerary)) :-
    byTrain(Source, Layover),
    travel2(Layover, Dest, Itinerary).
travel2(Source, Dest, go(byPlane, Source, Layover, Itinerary)) :-
    byPlane(Source, Layover),
    travel2(Layover, Dest, Itinerary).


%%%%%%%%%%%%%%%%%%%%%%%
connected(Source, Dest, byCar) :-
    byCar(Source, Dest).
connected(Source, Dest, byTrain) :-
    byTrain(Source, Dest).
connected(Source, Dest, byPlane) :-
    byPlane(Source, Dest).

travel3(Source, Dest, go(Mode, Source, Dest)) :-
    connected(Source, Dest, Mode).
travel3(Source, Dest, go(Mode, Source, Layover, Itinerary)) :-
    connected(Source, Layover, Mode),
    travel3(Layover, Dest, Itinerary).
