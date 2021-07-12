#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               plurals.pl
%
%   Started:            Sun May  9 13:45:09 2021
%   Modifications:
%
%   Purpose:
%      Exercise 8.1
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

s --> np(P), vp(P).

np(P) --> det(P), n(P).

vp(P) --> v(P), np(_).
vp(P) --> v(P).

det(_) --> [the].
det(singular) --> [a].

n(singular) --> [woman].
n(singular) --> [man].
n(plural) --> [men].
n(plural) --> [women].
n(singular) --> [apple].
n(singular) --> [pear].
n(plural) --> [apples].
n(plural) --> [pears].

v(singular) --> [eats].
v(plural) --> [eat].
v(singular) --> [knows].
v(plural) --> [know].
