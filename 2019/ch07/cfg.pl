%#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               cfg.pl
%
%   Started:            Fri Jun 19 19:04:18 2020
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

s(Z) :- np(X), vp(Y), append(X, Y, Z).
np(Z) :- det(X), n(Y), append(X, Y, Z).
vp(Z) :- v(X), np(Y), append(X, Y, Z).
vp(Z) :- v(Z).

det([the]).
det([a]).

n([woman]).
n([man]).

v([shoots]).
