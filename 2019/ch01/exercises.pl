#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               exercises.pl
%
%   Started:            Tue Jul 23 00:08:54 2019
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

hasWand(harry).
quidditchPlayer(harry).
wizard(ron).
wizard(X) :-
    hasBroom(X),
    hasWand(X).
hasBroom(X) :-
    quidditchPlayer(X).
