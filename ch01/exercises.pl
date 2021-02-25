%#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   NAME:               exercises.pl
%
%   STARTED:            Mon Jul  5 19:19:08 2010
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

%%%
%%%    1.4
%%%
killer(butch).
married(mia, marcellus).
dead(zed).
kills(marcellus, X) :- footMassage(X, mia).
loves(mia, X) :- goodDancer(X).
eats(jules, X) :-
    nutritious(X);
    tasty(X).

%%%
%%%    1.5
%%%
wizard(ron).
wizard(X) :- hasBroom(X), hasWand(X).

hasWand(harry).

quidditchPlayer(harry).

hasBroom(X) :- quidditchPlayer(X).
