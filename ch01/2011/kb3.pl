#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               kb3.pl
%
%   Started:            Sat Oct 15 22:01:24 2011
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
playsAirGuitar(butch) :- happy(butch).
playsAirGuitar(butch) :- listens2Music(butch).
