#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch08-blocks2.pl
%
%   Started:            Fri Apr 13 00:04:52 2012
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
%% s --> ablock(Count), bblock(Count), cblock(Count).

ablock(0) --> [].
ablock(NewCount) --> [a], ablock(Count), {NewCount is Count + 1}.

bblock(0) --> [].
bblock(NewCount) --> [b], bblock(Count), {NewCount is Count + 1}.

cblock(0) --> [].
cblock(NewCount) --> [c], cblock(Count), {NewCount is Count + 1}.

%% s(A, B, E) :-
%% 	ablock(A, B, C),
%% 	bblock(A, C, D),
%% 	cblock(A, D, E).

%% s(A, E) :-
%% 	ablock(B, A, C),
%% 	bblock(B, C, D),
%% 	cblock(B, D, E).

%% cblock(0, A, A).
%% cblock(B, [c|A], D) :-
%% 	cblock(C, A, E),
%% 	B is C+1,
%% 	D=E.

%% bblock(0, A, A).
%% bblock(B, [b|A], D) :-
%% 	bblock(C, A, E),
%% 	B is C+1,
%% 	D=E.

%% ablock(0, A, A).
%% ablock(B, [a|A], D) :-
%% 	ablock(C, A, E),
%% 	B is C+1,
%% 	D=E.

