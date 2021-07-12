#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               pseudo_difference.pl
%
%   Started:            Tue Jun  8 12:57:04 2021
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
%   Notes: This eliminates unnecessary cruft from the difference list implementation but
%   makes it less suitable as a lead-in to DCGs!
%
%   Uh...This whole idea is nonsense. It breaks the entire program!
%
%%

s(X) :- np(X, Y), vp(Y). % No np/2 anymore!

np(X) :- det(X, Y), n(Y). % D'oh!

vp(X) :- v(X, Y), np(Y).
vp(X) :- v(X).

det([a|W], W).
det([the|W], W).

n([man|W], W).
n([woman|W], W).

v([shoots|W], W).
