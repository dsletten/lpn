#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               non_cfg.pl
%
%   Started:            Wed Jun 16 15:08:20 2021
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


%% 105 ?- listing(ablock).
%% ablock(0, A, A).
%% ablock(succ(A), [a|B], C) :-
%% 	ablock(A, B, C).
