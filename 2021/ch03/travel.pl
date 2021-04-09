#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               travel.pl
%
%   Started:            Sun Mar  7 10:56:38 2021
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
%   Notes: This is essentially the same structure as descend/2.
%   Each of the variants is possible here as well...
%
%%

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

%%%
%%%    This is identical to the problem with exercise 3.1!
%%%    
%% travel(From, To) :- byCar(From, To).
%% travel(From, To) :- byTrain(From, To).
%% travel(From, To) :- byPlane(From, To).
%% travel(Start, End) :- travel(Start, By),
%%                       travel(By, End).

%%%
%%%    descend/2 type aaa
%%%    
travel(From, To) :- byCar(From, To).
travel(From, To) :- byTrain(From, To).
travel(From, To) :- byPlane(From, To).
travel(Start, End) :- byCar(Start, By),
                      travel(By, End).
travel(Start, End) :- byTrain(Start, By),
                      travel(By, End).
travel(Start, End) :- byPlane(Start, By),
                      travel(By, End).

%%%
%%%    descend/2 type baa
%%%    
travel2(From, To) :- byCar(From, To).
travel2(From, To) :- byTrain(From, To).
travel2(From, To) :- byPlane(From, To).
travel2(Start, End) :- byCar(By, End),
                       travel2(Start, By).
travel2(Start, End) :- byTrain(By, End),
                       travel2(Start, By).
travel2(Start, End) :- byPlane(By, End),
                       travel2(Start, By).

%%%
%%%    No good...
%%%    
%% travel(From, To, go(From, To)) :- byCar(From, To).
%% travel(From, To, go(From, To)) :- byTrain(From, To).
%% travel(From, To, go(From, To)) :- byPlane(From, To).
%% travel(Start, End, Itinerary) :- travel(Start, By, Itinerary1),
%%                                  travel(By, End, Itinerary1).

%%%
%%%    Part 3.
%%%    
%% travel(From, To, go(From, To)) :- byCar(From, To).
%% travel(From, To, go(From, To)) :- byTrain(From, To).
%% travel(From, To, go(From, To)) :- byPlane(From, To).
%% travel(Start, End, go(Start, By, Itinerary1)) :- byCar(Start, By),
%%                                                  travel(By, End, Itinerary1).
%% travel(Start, End, go(Start, By, Itinerary1)) :- byTrain(Start, By),
%%                                                  travel(By, End, Itinerary1).
%% travel(Start, End, go(Start, By, Itinerary1)) :- byPlane(Start, By),
%%                                                  travel(By, End, Itinerary1).

%%%
%%%    Part 4.
%%%    
travel(From, To, go(From, To, byCar)) :- byCar(From, To).
travel(From, To, go(From, To, byTrain)) :- byTrain(From, To).
travel(From, To, go(From, To, byPlane)) :- byPlane(From, To).
travel(Start, End, go(Start, By, byCar, Itinerary1)) :- byCar(Start, By),
                                                        travel(By, End, Itinerary1).
travel(Start, End, go(Start, By, byTrain, Itinerary1)) :- byTrain(Start, By),
                                                          travel(By, End, Itinerary1).
travel(Start, End, go(Start, By, byPlane, Itinerary1)) :- byPlane(Start, By),
                                                          travel(By, End, Itinerary1).
