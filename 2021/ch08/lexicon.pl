#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               lexicon.pl
%
%   Started:            Wed May  5 16:11:02 2021
%   Modifications:
%
%   Purpose:
%   Simple grammar using separate lexicon.
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

s --> np, vp.

np --> det, n.

vp --> v, np.
vp --> v.

det --> [W], {lex(W, det)}.

n --> [W], {lex(W, n)}.

v --> [W], {lex(W, v)}.

lex(the, det).
lex(a, det).
lex(woman, n).
lex(man, n).
lex(shoots, v).
