#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch08-parse.pl
%
%   Started:            Fri Apr 13 00:04:13 2012
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

s(s(NP, VP)) --> np(NP), vp(VP).

np(np(DET, N)) --> det(DET), n(N).

vp(vp(V, NP)) --> v(V), np(NP).
vp(vp(V)) --> v(V).

det(det(the)) --> [the].  % !!!
det(det(a)) --> [a].

n(n(woman)) --> [woman].
n(n(man)) --> [man].

v(v(shoots)) --> [shoots].

%% s(s(A, C), B, E) :-
%% 	np(A, B, D),
%% 	vp(C, D, E).

%% v(v(shoots), [shoots|A], A).

%% det(det(the), [the|A], A).
%% det(det(a), [a|A], A).

%% n(n(woman), [woman|A], A).
%% n(n(man), [man|A], A).

%% vp(vp(A, C), B, E) :-
%% 	v(A, B, D),
%% 	np(C, D, E).
%% vp(vp(A), B, C) :-
%% 	v(A, B, C).

%% np(np(A, C), B, E) :-
%% 	det(A, B, D),
%% 	n(C, D, E).
