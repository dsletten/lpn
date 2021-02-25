#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               kb3.pl
%
%   Started:            Sun Jul 21 22:38:49 2019
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

happy(vincent).
listens2Music(butch).
playsAirGuitar(vincent) :-
    listens2Music(vincent),
    happy(vincent).
playsAirGuitar(butch) :-
    happy(butch).
playsAirGuitar(butch) :-
    listens2Music(butch).
