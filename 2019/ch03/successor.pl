#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               successor.pl
%
%   Started:            Sun Jul 28 00:25:29 2019
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

numeral(0).
numeral(succ(X)) :-
    numeral(X).

add(0, Y, Y).
add(succ(X), Y, succ(Z)) :-
    add(X, Y, Z).

numeral2(succ(X)) :-
    numeral2(X).
numeral2(0).
