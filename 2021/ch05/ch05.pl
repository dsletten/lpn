#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch05.pl
%
%   Started:            Fri Mar 26 21:11:34 2021
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

%%%
%%%    5.2 1
%%%    
increment(X, Y) :- Y is X + 1.

%%%
%%%    5.2 2
%%%
sum(X, Y, Z) :- Z is X + Y.

%%%
%%%    5.3
%%%
addone([], []).
addone([H1|T1], [H2|T2]) :-
    H2 is H1 + 1,
    addone(T1, T2).

scalarMult(_, [], []).
scalarMult(K, [H|T1], [KH|T2]) :-
    KH is K * H,
    scalarMult(K, T1, T2). % This is tail recursive... [KH|T2] is not completely bound until T2 is realized...

%% dot([], [], 0).
%% dot([X|T1], [Y|T2], D) :-
%%     dot(T1, T2, D1),
%%     D is D1 + X * Y.

dot(V1, V2, D) :-
    dot(V1, V2, D, 0).
dot([], [], D, D).
dot([X|T1], [Y|T2], D, D1) :-
    D2 is D1 + X * Y,
    dot(T1, T2, D, D2).
