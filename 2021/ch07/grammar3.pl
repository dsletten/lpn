#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               grammar3.pl
%
%   Started:            Mon Apr 19 01:33:00 2021
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
%   Notes: Third DCG example. 'ab' language.
%
%%

s --> [].
s --> l, s, r.

l --> [a].
r --> [b].

%%%
%%%    Original grammar using append.
%%%      The book's example with English grammar only deals with rules whose RHS's have at most 2 non-terminals.
%%%      This grammar has 3, which requires multiple appends.
%%%    
%%%    These both recognize legal strings. Infinite loop otherwise.
%%%    Generate OK.
%%%
s1a([]).
s1a(D) :- l1a(A), s1a(B), r1a(C), append(A, B, E), append(E, C, D).
l1a([a]).
r1a([b]).

s1b([]).
s1b(D) :- l1b(A), s1b(B), append(A, B, E), r1b(C), append(E, C, D).
l1b([a]).
r1b([b]).

%%%
%%%    Mundane recursive definition (Works perfectly!)
%%%    
sx([]).
sx([a|X]) :- sxa(X, 1).
sxa([a|X], N) :-
    N1 is N + 1,
    sxa(X, N1).
sxa([b|X], N) :-
    N > 0,
    N1 is N - 1,
    sxb(X, N1).
sxb([], 0).
sxb([b|X], N) :-
    N > 0,
    N1 is N - 1,
    sxb(X, N1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%%    Problems mixing non-terminals/terminals on RHS of grammar rule????
%%%
%%%    This should be a legitimate (simpler) grammar.
%%%    (How to designate a, b as terminal symbols?)
%%%
/*
s -> ϵ
s -> a s b
*/

%%%
%%%    But there's no way to encode this in DCG?
%%%
/*
s --> [].
s --> a, s, b.
=> s(A, D) :- a(A, B), s(B, C), b(C, D).  % Still requires terminal rules for a/2, b/2...
*/

/*
s2 --> [].
s2 --> {[a|A], s1(A, B), [b|B]}.  % Nonsense...
*/

%%%
%%%    D'oh!
%%%
s0 --> [].
s0 --> [a], s0, [b].

%% 109 ?- listing(s).
%% s(A, A).
%% s([a|A], C) :-
%% 	s(A, B),
%% 	B=[b|C].

%%%
%%%    Naive append grammar.
%%%    This recognizes legal strings. Infinite loop otherwise.
%%%    Generates OK.
%%%
s2([]).
s2([a|A]) :- s2(B), append(B, [b], A).


s2a1([]).
s2a1(Z) :- append([a], X, Y), s2a1(X), append(Y, [b], Z).

%%%    This recognizes legal strings. Infinite loop otherwise.
%%%    Generates OK.
s2b([]).
s2b(X) :- s2b(A), append([a|A], [b], X).


%%%
%%%    Raw difference lists
%%%    Huh???
%%%
%s2c([], []).
s2c(X, X).
%s2c([a|A], C) :- append(A, [b], B), s2c(B, C).
s2c([a|A], C) :- append(B, [b], A), s2c(B, C).

s2c2([]).
s2c2([a|A]) :- append(B, [b], A), s2c2(B).




%%%
%%%    See ch. 8
%%%
s3(N) --> as(N), bs(N).

as(0) --> [].
as(succ(N)) --> [a], as(N).

bs(0) --> [].
bs(succ(N)) --> [b], bs(N).
