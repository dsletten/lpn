#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch08-blocks.pl
%
%   Started:            Fri Apr 13 00:04:40 2012
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

s(Count) --> ablock(Count), bblock(Count), cblock(Count).

ablock(0) --> [].
ablock(succ(Count)) --> [a], ablock(Count).

bblock(0) --> [].
bblock(succ(Count)) --> [b], bblock(Count).

cblock(0) --> [].
cblock(succ(Count)) --> [c], cblock(Count).

%% s(A, B, E) :-
%% 	ablock(A, B, C),
%% 	bblock(A, C, D),
%% 	cblock(A, D, E).

%% cblock(0, A, A).
%% cblock(succ(A), [c|B], C) :-
%% 	cblock(A, B, C).

%% bblock(0, A, A).
%% bblock(succ(A), [b|B], C) :-
%% 	bblock(A, B, C).

%% ablock(0, A, A).
%% ablock(succ(A), [a|B], C) :-
%% 	ablock(A, B, C).


%% ?- s(0, L, []).
%% L = [].

%% ?- s(succ(0), L, []).
%% L = [a, b, c].

%% ?- s(succ(succ(0)), L, []).
%% L = [a, a, b, b, c, c].


%% ?- s(Count, L, []).
%% Count = 0,
%% L = [] ;
%% Count = succ(0),
%% L = [a, b, c] ;
%% Count = succ(succ(0)),
%% L = [a, a, b, b, c, c] ;
%% Count = succ(succ(succ(0))),
%% L = [a, a, a, b, b, b, c, c, c] 
