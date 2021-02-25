#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               exercises.pl
%
%   Started:            Sat Aug 17 02:46:36 2019
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

%
%    5.2.1
%
increment(X, Y) :-
    Y is X+1.

%
%    5.2.2
%
sum(X, Y, Z) :-
    Z is X + Y.

%
%    5.3
%
addone([], []).
addone([X|T1], [Y|T2]) :-
    Y is X+1,
    addone(T1, T2).

%
%    6.1
%
minList([H|T], M) :-
    minList(T, M, H).
minList([], M, M).
minList([H|T], M, Acc) :-
    Acc1 is min(H, Acc),
    minList(T, M, Acc1).

minList2([H|T], M) :-
    minList2(T, M, H).
minList2([], M, M).
minList2([H|T], M, Acc) :-
    Acc =< H,
    minList2(T, M, Acc).
minList2([H|T], M, Acc) :-
    H < Acc,
    minList2(T, M, H).

%
%    6.2
%
scalarMult(_, [], []).
scalarMult(K, [X|T1], [Y|T2]) :-
    Y is K * X,
    scalarMult(K, T1, T2).

%
%    6.3
%
dot([], [], 0).
dot([X|T1], [Y|T2], D) :-
    dot(T1, T2, D1),
    D is X * Y + D1.

dot1(V1, V2, D) :-
    dot1(V1, V2, D, 0).
dot1([], [], D, D).
dot1([X|T1], [Y|T2], D, Acc) :-
    Acc1 is X * Y + Acc,
    dot1(T1, T2, D, Acc1).
