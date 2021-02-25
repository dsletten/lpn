#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               arithmetic.pl
%
%   Started:            Sat Jan 28 16:50:03 2012
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

numeral(0).
numeral(succ(X)) :- numeral(X).

add(X, 0, X).
add(X, succ(Y), succ(Z)) :- add(X, Y, Z).

%% ?- add(succ(0), 0, X).
%% X = succ(0) ;
%% false.

%% ?- add(succ(0), succ(0), X).
%% X = succ(succ(0)) ;
%% false.

%% ?- add(succ(0), succ(succ(0)), X).
%% X = succ(succ(succ(0))) ;
%% false.

%% ?- add(0, succ(succ(0)), X).
%% X = succ(succ(0)) ;
%% false.

%% ?- add(0, 0, X).
%% X = 0 ;
%% false.

%% ?- add(succ(succ(0)), succ(succ(0)), X).
%% X = succ(succ(succ(succ(0)))) ;
%% false.

pred(X, succ(X)).

%% subtract(X, X, 0).
%% subtract(X, Y, succ(Z)) :- subtract(X, succ(Y), Z).

subtract(X, Y, Z) :- add(Z, Y, X).

multiply(_, 0, 0).
multiply(X, succ(0), X).
multiply(X, succ(Y), Z) :- multiply(X, Y, Z1), add(X, Z1, Z).
