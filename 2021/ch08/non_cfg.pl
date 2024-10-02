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

s1(Count) --> ablock1(Count), bblock1(Count), cblock1(Count).

ablock1(0) --> a.
ablock1(succ(Count)) --> a, ablock1(Count).

bblock1(0) --> b.
bblock1(succ(Count)) --> b, bblock1(Count).

cblock1(0) --> c.
cblock1(succ(Count)) --> c, cblock1(Count).

a --> [a].
b --> [b].
c --> [c].



s2(succ(Count)) --> ablock(succ(Count)), bblock(succ(Count)), cblock(succ(Count)).

%% ablock2(0) --> [].
%% ablock2(succ(Count)) --> [a], ablock2(Count).

%% bblock2(0) --> [].
%% bblock2(succ(Count)) --> [b], bblock2(Count).

%% cblock2(0) --> [].
%% cblock2(succ(Count)) --> [c], cblock2(Count).

s3(Count) --> ablock3(Count), bblock3(Count), cblock3(Count).


ablock3(0) --> [].
ablock3(NewCount) --> [a], ablock3(Count),
                      {NewCount is Count + 1}.

bblock3(0) --> [].
bblock3(NewCount) --> [b], bblock3(Count),
                      {NewCount is Count + 1}.

cblock3(0) --> [].
cblock3(NewCount) --> [c], cblock3(Count),
                      {NewCount is Count + 1}.


%%    Disaster
s3a(Count) --> ablock3a(Count), bblock3a(Count), cblock3a(Count).


ablock3a(0) --> [].
ablock3a(NewCount) --> [a], ablock3a(Count),
                       {NewCount is Count - 1}.

bblock3a(0) --> [].
bblock3a(NewCount) --> [b], bblock3a(Count),
                       {NewCount is Count - 1}.

cblock3a(0) --> [].
cblock3a(NewCount) --> [c], cblock3a(Count),
                       {NewCount is Count - 1}.

%% ablock3a(0, A, A).
%% ablock3a(NewCount, [a|A], B) :-
%%     ablock3a(Count, A, C),
%%     NewCount is Count-1,
%%     B=C.

s4(Count) --> ablock4(Count), bblock4(Count), cblock4(Count).


ablock4(1) --> a.
ablock4(NewCount) --> a, ablock4(Count),
                      {NewCount is Count + 1}.

bblock4(1) --> b.
bblock4(NewCount) --> b, bblock4(Count),
                      {NewCount is Count + 1}.

cblock4(1) --> c.
cblock4(NewCount) --> c, cblock4(Count),
                      {NewCount is Count + 1}.



s5(Count) --> ablock5(Count), bblock5(Count), cblock5(Count).


ablock5(1) --> a.
ablock5(NewCount) --> a,
                      {NewCount > 1, Count is NewCount - 1},
                      ablock5(Count).
                      

bblock5(1) --> b.
bblock5(NewCount) --> b,
                      {NewCount > 1, Count is NewCount - 1},
                      bblock5(Count).

cblock5(1) --> c.
cblock5(NewCount) --> c,
                      {NewCount > 1, Count is NewCount - 1},
                      cblock5(Count).

%%
%%    SWIPL translates:
%% ablock5(1, A, B) :-
%%     a(A, B).
%% ablock5(NewCount, A, B) :-
%%     a(A, C),
%%     NewCount>1,
%%     Count is NewCount+ -1,
%%     D=C,
%%     ablock5(Count, D, B).

%%%
%%%    Why does the book's "extra args" version (s3) count up?
%%%    - The succ/1 example in ch. 3 counts down.
%%%    - s5 counts down and allows the predicates to be tail-recursive.
%%%    but s3 blows up.
%%%
%%%    In all versions besides s5, there is no connection between NewCount and Count
%%%    until after the recursive call is attempted.
%%%    
