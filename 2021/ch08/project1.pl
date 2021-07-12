#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               project1.pl
%
%   Started:            Sat Jun 26 02:01:45 2021
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
%   Notes: Bare bones DCG.
%
%%

s --> np, vp.

np --> det, n.

vp --> v, np.
vp --> v.

det --> [the].
det --> [a].

n --> [woman].
n --> [man].
n --> [pear].
n --> [apple].
n --> [dog].
n --> [cat].
n --> [car].
n --> [person].
n --> [hamburger].
n --> [book].
n --> [teacher].
n --> [child].
n --> [song].
n --> [ball].

v --> [describes].
v --> [shoots].
v --> [eats].
v --> [knows].
v --> [speaks].
v --> [walks].
v --> [swims].
v --> [laughs].
v --> [learns].
v --> [loves].
v --> [hates].


