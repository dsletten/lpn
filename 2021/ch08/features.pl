#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               features.pl
%
%   Started:            Mon May  3 01:29:27 2021
%   Modifications:
%
%   Purpose: Grammar with pronouns using extra args to define features.
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

s --> np(subject), vp.

np(_) --> det, n.
np(X) --> pro(X).

vp --> v, np(object).
vp --> v.

det --> [the].
det --> [a].

n --> [woman].
n --> [man].

pro(subject) --> [he].
pro(subject) --> [she].
pro(object) --> [him].
pro(object) --> [her].

v --> [shoots].
