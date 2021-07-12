#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               grammar1.pl
%
%   Started:            Sun Apr 18 02:49:05 2021
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
%   Notes: First DCG example.
%
%%

s --> np, vp.

np --> det, n.

vp --> v, np.
vp --> v.

det --> [a].
det --> [the].

n --> [man].
n --> [woman].

v --> [shoots].
