#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               grammar2.pl
%
%   Started:            Mon Apr 19 01:32:58 2021
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
%   Notes: Second DCG example. Recursive rules. Extra rule to avoid left-recursion.
%
%%

s --> simple_s.
s --> simple_s, conj, s.

simple_s --> np, vp.

np --> det, n.

vp --> v, np.
vp --> v.

det --> [a].
det --> [the].

n --> [man].
n --> [woman].

v --> [shoots].

conj --> [and].
conj --> [but].
conj --> [or].
