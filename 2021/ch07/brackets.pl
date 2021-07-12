#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               brackets.pl
%
%   Started:            Mon Apr 26 03:16:33 2021
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

expr --> [].
expr --> expr1, expr.

expr1 --> l, expr, r.

l --> [<].
r --> [>].

%% expr(A, A).
%% expr(A, D) :-
%% 	l(A, B),
%% 	expr(B, C),
%% 	r(C, D).
%% expr(A, C) :-
%% 	sequential(A, B),
%% 	expr(B, C).

%% sequential(A, C) :-
%% 	expr(A, B),
%% 	expr(B, C).


%% s(A, A).
%% s(A, D) :-
%% 	l(A, B),
%% 	s1(B, C),
%% 	r(C, D).
%% s(A, C) :-
%% 	s1(A, B),
%% 	s1(B, C).

%% s1(A, A).
%% s1(A, D) :-
%% 	l(A, B),
%% 	s1(B, C),
%% 	r(C, D).
