#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               parse.pl
%
%   Started:            Mon May  3 01:51:53 2021
%   Modifications:
%
%   Purpose: Grammar using extra args to capture parse tree
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

s(s(NP, VP)) --> np(subject, NP), vp(VP).

np(_, np(DET, N)) --> det(DET), n(N).
np(X, PRO) --> pro(X, PRO).

vp(vp(V, NP)) --> v(V), np(object, NP).
vp(vp(V)) --> v(V).

det(det(the)) --> [the].
det(det(a)) --> [a].

n(n(woman)) --> [woman].
n(n(man)) --> [man].

pro(subject, pro(he)) --> [he].
pro(subject, pro(she)) --> [she].
pro(object, pro(him)) --> [him].
pro(object, pro(her)) --> [her].

v(v(shoots)) --> [shoots].


%% s(s(A, C), B, E) :-
%% 	np(subject, A, B, D),
%% 	vp(C, D, E).

%% np(_, np(A, C), B, E) :-
%% 	det(A, B, D),
%% 	n(C, D, E).
%% np(A, B, C, D) :-
%% 	pro(A, B, C, D).

%% vp(vp(A, C), B, E) :-
%% 	v(A, B, D),
%% 	np(object, C, D, E).
%% vp(vp(A), B, C) :-
%% 	v(A, B, C).

%% det(det(the), [the|A], A).
%% det(det(a), [a|A], A).

%% n(n(woman), [woman|A], A).
%% n(n(man), [man|A], A).

%% pro(subject, pro(he), [he|A], A).
%% pro(subject, pro(she), [she|A], A).
%% pro(object, pro(him), [him|A], A).
%% pro(object, pro(her), [her|A], A).

%% v(v(shoots), [shoots|A], A).
