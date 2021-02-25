#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch10.pl
%
%   Started:            Wed May 16 23:26:15 2012
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

%% split([], [], []).
%% split([I|T1], [I|T2], N) :-
%%     I >= 0,
%%     split(T1, T2, N).
%% split([I|T1], P, [I|T2]) :-
%%     I < 0,
%%     split(T1, P, T2).

split([], [], []).
split([I|T1], [I|T2], N) :-
    I >= 0, !,
    split(T1, T2, N).
split([I|T1], P, [I|T2]) :- split(T1, P, T2).
