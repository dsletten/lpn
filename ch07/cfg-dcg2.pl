#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch07-dcg2.pl
%
%   Started:            Mon Mar 26 23:44:40 2012
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

%% conj([and|A], A).
%% conj([but|A], A).
%% conj([or|A], A).

%% simple_s(A, C) :-
%% 	np(A, B),
%% 	vp(B, C).

%% s(A, B) :-
%% 	simple_s(A, B).
%% s(A, D) :-
%% 	simple_s(A, B),
%% 	conj(B, C),
%% 	s(C, D).
