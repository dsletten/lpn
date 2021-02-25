#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch07-dl.pl
%
%   Started:            Sun Mar 18 03:56:28 2012
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

s(X) :- s(X, []).
s(X, Z) :- np(X, Y), vp(Y, Z).

np(X, Z) :- det(X, Y), n(Y, Z).

vp(X, Z) :- v(X, Y), np(Y, Z).
vp(X, Z) :- v(X, Z).

det([a|W], W).
det([the|W], W).

n([man|W], W).
n([woman|W], W).

v([shoots|W], W).
