#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               notes.pl
%
%   Started:            Thu Apr 28 02:04:03 2022
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
%   Notes: Review of A-3 -> A-5
%
%%

%:- module(notes, []).

add(X, 0, X).
add(X, succ(Y), succ(Z)) :- add(X, Y, Z).

subtract(X, 0, X).
subtract(succ(X), succ(Y), Z) :- subtract(X, Y, Z).

%%%    A-3 甲
multiply甲(_, 0, 0).
multiply甲(X, succ(Y), Z1) :-
    add(X, Z, Z1),
    multiply甲(X, Y, Z).

%%%    A-3 乙
multiply乙(_, 0, 0).
multiply乙(X, succ(Y), Z1) :-
    multiply乙(X, Y, Z),
    add(X, Z, Z1).

%%%  This fails for m(M, N, s(s(s(s(0))))) as does above version!
multiply乙a(_, 0, 0).
multiply乙a(X, succ(Y), Z1) :-
    multiply乙a(X, Y, Z),
    add(Z, X, Z1).

%%%    A-3 丙
multiply丙(_, 0, 0).
multiply丙(X, succ(Y), Z1) :-
    subtract(Z1, X, Z),
    multiply丙(X, Y, Z).
