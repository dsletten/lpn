#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               difference.pl
%
%   Started:            Tue Jun  8 12:57:00 2021
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
%   Notes: Difference list implementation of grammar.
%
%%


s(X, Z) :- np(X, Y), vp(Y, Z).

np(X, Z) :- det(X, Y), n(Y, Z).

vp(X, Z) :- v(X, Y), np(Y, Z).
vp(X, Y) :- v(X, Y).

det([a|W], W).
det([the|W], W).

n([man|W], W).
n([woman|W], W).

v([shoots|W], W).
