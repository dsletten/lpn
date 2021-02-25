#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch08-naive.pl
%
%   Started:            Fri Apr 13 00:03:41 2012
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
s --> np_subject, vp.

np_subject --> det, n.
np_subject --> pro_subject.

np_object --> det, n.
np_object --> pro_object.

vp --> v, np_object.
vp --> v.

det --> [the].
det --> [a].

n --> [woman].
n --> [man].

pro_subject --> [he].
pro_subject --> [she].

pro_object --> [him].
pro_object --> [her].

v --> [shoots].

%% v([shoots|A], A).

%% pro_object([him|A], A).
%% pro_object([her|A], A).

%% np_object(A, C) :-
%% 	det(A, B),
%% 	n(B, C).
%% np_object(A, B) :-
%% 	pro_object(A, B).

%% pro_subject([he|A], A).
%% pro_subject([she|A], A).

%% n([woman|A], A).
%% n([man|A], A).

%% det([the|A], A).
%% det([a|A], A).

%% vp(A, C) :-
%% 	v(A, B),
%% 	np_object(B, C).
%% vp(A, B) :-
%% 	v(A, B).

%% np_subject(A, C) :-
%% 	det(A, B),
%% 	n(B, C).
%% np_subject(A, B) :-
%% 	pro_subject(A, B).

%% s(A, C) :-
%% 	np_subject(A, B),
%% 	vp(B, C).
