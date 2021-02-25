#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch08-feature.pl
%
%   Started:            Fri Apr 13 00:03:59 2012
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

%% v([shoots|A], A).

%% np(_, A, C) :-
%% 	det(A, B),
%% 	n(B, C).
%% np(A, B, C) :-
%% 	pro(A, B, C).

%% n([woman|A], A).
%% n([man|A], A).

%% det([the|A], A).
%% det([a|A], A).

%% pro(subject, [he|A], A).
%% pro(subject, [she|A], A).
%% pro(object, [him|A], A).
%% pro(object, [her|A], A).

%% vp(A, C) :-
%% 	v(A, B),
%% 	np(object, B, C).
%% vp(A, B) :-
%% 	v(A, B).

%% s(A, C) :-
%% 	np(subject, A, B),
%% 	vp(B, C).
