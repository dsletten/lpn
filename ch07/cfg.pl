#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch07.pl
%
%   Started:            Sun Mar 11 18:07:45 2012
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

s(Z) :-
    np(X),
    vp(Y),
    append(X, Y, Z).

np(Z) :-
    det(X),
    n(Y),
    append(X, Y, Z).

vp(Z) :-
    v(X),
    np(Y),
    append(X, Y, Z).

vp(Z) :- v(Z).

det([a]).
det([the]).

n([man]).
n([woman]).

v([shoots]).
