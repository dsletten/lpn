#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch08-pronoun.pl
%
%   Started:            Fri Apr 13 00:06:55 2012
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

s --> np, vp.

np --> det, n.
np --> pro.

vp --> v, np.
vp --> v.

det --> [the].
det --> [a].

n --> [woman].
n --> [man].

v --> [shoots].

pro --> [he].
pro --> [she].
pro --> [him].
pro --> [her].

%% pro([he|A], A).
%% pro([she|A], A).
%% pro([him|A], A).
%% pro([her|A], A).

%% v([shoots|A], A).

%% n([woman|A], A).
%% n([man|A], A).

%% det([the|A], A).
%% det([a|A], A).

%% vp(A, C) :-
%% 	v(A, B),
%% 	np(B, C).
%% vp(A, B) :-
%% 	v(A, B).

%% np(A, C) :-
%% 	det(A, B),
%% 	n(B, C).

%% np(A, B) :-
%% 	pro(A, B).

%% s(A, C) :-
%% 	np(A, B),
%% 	vp(B, C).
