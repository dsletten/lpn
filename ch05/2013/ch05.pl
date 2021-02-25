#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch05.pl
%
%   Started:            Wed Aug 21 20:20:35 2013
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

%% listMax([H], H).
%% listMax([H|T], H) :-
%%     listMax(T, M),
%%     H >= M.
%% listMax([H|T], M) :-
%%     listMax(T, M),
%%     H < M.

%% ?- listMax([], M).
%% false.

%% ?- listMax([2], M).
%% M = 2 ;
%% false.

%% ?- listMax([2, 4], M).
%% M = 4 ;
%% false.

%% ?- listMax([8, 2, 4], M).
%% M = 8 ;
%% false.

%% ?- listMax([8, 8, 2, 4], M).
%% M = 8 ;
%% false.

listMax([H|T], M) :- listMax(T, M, H).
listMax([], M, M).
listMax([H|T], Max, M) :-
    H > M,
    listMax(T, Max, H).
listMax([H|T], Max, M) :-
    H =< M,
    listMax(T, Max, M).

%%%
%%%    5.2.1
%%%
increment(X, Y) :- Y is X + 1.

%% ?- increment(4, 5).
%% true.

%% ?- increment(4, 6).
%% false.

%% ?- increment(X, 6).
%% ERROR: user://3:2471:
%% 	is/2: Arguments are not sufficiently instantiated
%% ?- increment(4, Y).
%% Y = 5.

%%%
%%%    5.2.2
%%%
sum(X, Y, Z) :- Z is X + Y.

%% ?- sum(4, 5, 9).
%% true.

%% ?- sum(4, 6, 12).
%% false.

%% ?- sum(4, 6, Z).
%% Z = 10.

%%%
%%%    5.3
%%%
addone([], []).
addone([H1|T1], [H2|T2]) :-
    H2 is H1 + 1, % increment/2 !!!
    addone(T1, T2).

%% ?- addone([1, 2, 7, 2], L).
%% L = [2, 3, 8, 3].

%% ?- addone([1, 2, 7, 2], [X, 3, Y, 3]).
%% X = 2,
%% Y = 8.

%% ?- addone([1, 2, 7, Z], [X, 3, Y, 3]).
%% ERROR: user://3:2501:
%% 	is/2: Arguments are not sufficiently instantiated

%%%
%%%    Practical session
%%%
listMin([H|T], Min) :- listMin(T, Min, H).
listMin([], M, M).
listMin([H|T], Min, M) :-
    H < M,
    listMin(T, Min, H).
listMin([H|T], Min, M) :-
    M =< H,
    listMin(T, Min, M).

scalarProduct(_, [], []).
scalarProduct(K, [H1|T1], [H2|T2]) :-
    H2 is K * H1,
    scalarProduct(K, T1, T2).

%% ?- scalarProduct(3, [2, 7, 4], R).
%% R = [6, 21, 12] ;
%% false.

%% dotProduct([], [], 0).
%% dotProduct([H1|T1], [H2|T2], S) :-
%%     dotProduct(T1, T2, S1),
%%     S is S1 + H1 * H2.

%% ?- dotProduct([2, 5, 6], [3, 4, 1], R).
%% R = 32.

%% ?- dotProduct([1, 3, -5], [4, -2, -1], R).
%% R = 3.

%% ?- dotProduct([10, 20], [3, 4], R).
%% R = 110.

dotProduct([H1|T1], [H2|T2], S) :- P is H1 * H2, dotProduct(T1, T2, S, P).
dotProduct([], [], S, S).
dotProduct([H1|T1], [H2|T2], S, Acc) :-
    P is H1 * H2,
    S1 is Acc + P,
    dotProduct(T1, T2, S, S1).
