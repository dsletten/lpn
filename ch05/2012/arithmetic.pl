#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               arithmetic.pl
%
%   Started:            Fri Feb 17 12:37:17 2012
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

reduce([], 1).
reduce([H|T], X) :-
    reduce(T, X1),
    X is H * X1.

reduce2([], 1).
reduce2([H|T], X) :-
    nonvar(H),
    reduce2(T, X1),
    X is H * X1.
reduce2([H|T], X) :-
    var(H),
    nonvar(X),
    reduce2(T, X1),
    H is X / X1.
%    X is H * X1.
%reduce2(X, Y) :- var(X), 
%reduce2... :- number(X), ...

