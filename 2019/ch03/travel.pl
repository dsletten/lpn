#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               travel.pl
%
%   Started:            Mon Aug 12 23:03:05 2019
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

travel(Source, Dest) :- byCar(Source, Dest).
travel(Source, Dest) :- byTrain(Source, Dest).
travel(Source, Dest) :- byPlane(Source, Dest).
travel(Source, Dest) :-
    byCar(Source, Stop),
    travel(Stop, Dest).
travel(Source, Dest) :-
    byTrain(Source, Stop),
    travel(Stop, Dest).
travel(Source, Dest) :-
    byPlane(Source, Stop),
    travel(Stop, Dest).

% travel(Source, Dest, go(Source, Dest)) :- byCar(Source, Dest).
% travel(Source, Dest, go(Source, Dest)) :- byTrain(Source, Dest).
% travel(Source, Dest, go(Source, Dest)) :- byPlane(Source, Dest).
% travel(Source, Dest, go(Source, Stop, R1)) :-
%     byCar(Source, Stop),
%     travel(Stop, Dest, R1).
% travel(Source, Dest, go(Source, Stop, R1)) :-
%     byTrain(Source, Stop),
%     travel(Stop, Dest, R1).
% travel(Source, Dest, go(Source, Stop, R1)) :-
%     byPlane(Source, Stop),
%     travel(Stop, Dest, R1).

travel(Source, Dest, go(byCar, Source, Dest)) :- byCar(Source, Dest).
travel(Source, Dest, go(byTrain, Source, Dest)) :- byTrain(Source, Dest).
travel(Source, Dest, go(byPlane, Source, Dest)) :- byPlane(Source, Dest).
travel(Source, Dest, go(byCar, Source, Stop, R1)) :-
    byCar(Source, Stop),
    travel(Stop, Dest, R1).
travel(Source, Dest, go(byTrain, Source, Stop, R1)) :-
    byTrain(Source, Stop),
    travel(Stop, Dest, R1).
travel(Source, Dest, go(byPlane, Source, Stop, R1)) :-
    byPlane(Source, Stop),
    travel(Stop, Dest, R1).

%%%
%%%    200407
%%%    
travel(S, D) :- byCar(S, D).
travel(S, D) :- byTrain(S, D).
travel(S, D) :- byPlane(S, D).
travel(S, D) :-
    byCar(S, I),
    travel(I, D).
travel(S, D) :-
    byTrain(S, I),
    travel(I, D).
travel(S, D) :-
    byPlane(S, I),
    travel(I, D).

%% travel(S, D, go(S, D)) :- byCar(S, D).
%% travel(S, D, go(S, D)) :- byTrain(S, D).
%% travel(S, D, go(S, D)) :- byPlane(S, D).
%% travel(S, D, go(S, I, R)) :-
%%     byCar(S, I),
%%     travel(I, D, R).
%% travel(S, D, go(S, I, R)) :-
%%     byTrain(S, I),
%%     travel(I, D, R).
%% travel(S, D, go(S, I, R)) :-
%%     byPlane(S, I),
%%     travel(I, D, R).

%%%
%%%    This is the only substantial difference from 2019
%%%    

%%
%%    Old
%%

%% ?- travel(valmont, losAngeles, R).
%% R = go(byCar, valmont, saarbrücken, go(byTrain, saarbrücken, paris, go(byPlane, paris, losAngeles))) ;
%% R = go(byCar, valmont, metz, go(byTrain, metz, paris, go(byPlane, paris, losAngeles))) ;

%%
%%    New
%%    

%% ?- travel(valmont, losAngeles, R).
%% R = byCar(valmont, saarbrücken, byTrain(saarbrücken, paris, byPlane(paris, losAngeles))) ;
%% R = byCar(valmont, metz, byTrain(metz, paris, byPlane(paris, losAngeles))) ;

travel(S, D, byCar(S, D)) :- byCar(S, D).
travel(S, D, byTrain(S, D)) :- byTrain(S, D).
travel(S, D, byPlane(S, D)) :- byPlane(S, D).
travel(S, D, byCar(S, I, R)) :-
    byCar(S, I),
    travel(I, D, R).
travel(S, D, byTrain(S, I, R)) :-
    byTrain(S, I),
    travel(I, D, R).
travel(S, D, byPlane(S, I, R)) :-
    byPlane(S, I),
    travel(I, D, R).
