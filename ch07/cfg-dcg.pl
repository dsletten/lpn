#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch07-dcg.pl
%
%   Started:            Sun Mar 18 04:14:35 2012
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
s --> np, vp.

np --> det, n.

vp --> v, np.
vp --> v.

det --> [a].
det --> [the].

n --> [man].
n --> [woman].

v --> [shoots].

%% v([shoots|A], A).

%% n([man|A], A).
%% n([woman|A], A).

%% det([a|A], A).
%% det([the|A], A).

%% vp(A, C) :-
%% 	v(A, B),
%% 	np(B, C).
%% vp(A, B) :-
%% 	v(A, B).

%% np(A, C) :-
%% 	det(A, B),
%% 	n(B, C).

%% s(A, C) :-
%% 	np(A, B),
%% 	vp(B, C).
