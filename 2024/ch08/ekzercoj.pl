#!/opt/local/bin/swipl -q -t main -f
%%  -*- Mode: Prolog -*-
%   Name:               ekzercoj.pl
%
%   Started:            Sun Aug 25 16:46:59 2024
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

%:- module(ekzercoj, []).

%%%
%%%    8.1
%%%    
s --> np(X), vp(X).

np(X) --> det(X, Y), n(X, Y).

vp(X) --> v(X), np(_).
vp(X) --> v(X).

det(_, _) --> [the].
det(singular, consonant) --> [a].
det(singular, vowel) --> [an].

n(singular, consonant) --> [woman].
n(singular, consonant) --> [man].
n(singular, vowel) --> [apple].
n(singular, consonant) --> [pear].
n(plural, consonant) --> [men].

v(singular) --> [eats].
v(plural) --> [eat].
v(singular) --> [knows].
v(plural) --> [know].

%%%
%%%    8.2
%%%
kanga(V, R, Q) --> roo(V, R),
                   jumps(Q, Q),
                   {marsupial(V, R, Q)}.

%% kanga(V, R, Q, A, C) --> roo(V, R, A, B),
%%                          jumps(Q, Q, B, C),
%%                          marsupial(V, R, Q).

%% kanga(V, R, Q, A, B) :-
%%     roo(V, R, A, C),
%%     jumps(Q, Q, C, D),
%%     marsupial(V, R, Q),
%%     B=D.

