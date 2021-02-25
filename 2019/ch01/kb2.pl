#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               kb2.pl
%
%   Started:            Sun Jul 21 22:18:36 2019
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

happy(yolanda).
listens2Music(mia).
listens2Music(yolanda) :-
    happy(yolanda).
playsAirGuitar(mia) :-
    listens2Music(mia).
playsAirGuitar(yolanda) :-
    listens2Music(yolanda).
