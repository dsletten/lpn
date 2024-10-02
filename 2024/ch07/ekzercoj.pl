#!/opt/local/bin/swipl -q -t main -f
%%  -*- Mode: Prolog -*-
%   Name:               ekzercoj.pl
%
%   Started:            Mon Aug 12 17:10:41 2024
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
%%%    7.1
%%%    
s --> foo,bar,wiggle.
foo --> [choo].
foo --> foo,foo.
bar --> mar,zar.
mar --> me,my.
me --> [i].
my --> [am].
zar --> blar,car.
blar --> [a].
car --> [train].
wiggle --> [toot].
wiggle --> wiggle,wiggle.

%% s(A, D) :-
%%     foo(A, B),
%%     bar(B, C),
%%     wiggle(C, D).
%% foo([choo|A], A).
%% foo(A, C) :-
%%     foo(A, B),
%%     foo(B, C).
%% bar(A, C) :-
%%     mar(A, B),
%%     zar(B, C).
%% mar(A, C) :-
%%     me(A, B),
%%     my(B, C).
%% me([i|A], A).
%% my([am|A], A).
%% zar(A, C) :-
%%     blar(A, B),
%%     car(B, C).
%% blar([a|A], A).
%% car([train|A], A).
%% wiggle([toot|A], A).
%% wiggle(A, C) :-
%%     wiggle(A, B),
%%     wiggle(B, C).

%%%
%%%    7.2
%%%
sab --> l,r.
sab --> l,sab,r.
l --> [a].
r --> [b].

%% sab(A, C) :-
%%     l(A, B),
%%     r(B, C).
%% sab(A, D) :-
%%     l(A, B),
%%     sab(B, C),
%%     r(C, D).
%% l([a|A], A).
%% r([b|A], A).

%%%
%%%    7.3
%%%
sa2b --> [].
sa2b --> l, sa2b, r, r.
%% l --> [a].
%% r --> [b].

%%%
%%%    Practical 1
%%%
even --> [].
even --> [a], even, [a].

%%%
%%%    Practical 2
%%%
core --> [].
core --> [b, b], core, [c, c].
block --> core.
block --> [a], block, [d].

%%%
%%%    Practical 3
%%%
prop --> [p].
prop --> [q].
prop --> [r].
prop --> [not], prop.
prop --> ['('], prop, [and], prop, [')'].
prop --> ['('], prop, [or], prop, [')'].
prop --> ['('], prop, [implies], prop, [')'].
