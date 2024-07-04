#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch03.pl
%
%   Started:            Sun May 12 23:33:45 2024
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
%%

%:- module(ch03, []).

%%%
%%%    3.2
%%%    This is the opposite sense of the book: directlyIn(Inner, Outer).
%%%    
directlyIn(irina, natasha).
directlyIn(natasha, olga).
directlyIn(olga, katarina).

in(X, Y) :- directlyIn(X, Y).
in(X, Y) :- directlyIn(X, Z),
            in(Z, Y).

%%%
%%%    3.3 All one-way. Actually tricky to extend to symmetric relation?! (见 ex. 10.4)
%%%    A -> B <=> B ->A (Infinite search?)
%%%
directTrain(saarbrücken, dudweiler).
directTrain(forbach, saarbrücken).
directTrain(freyming, forbach).
directTrain(stAvold, freyming).
directTrain(faulquemont, stAvold).
directTrain(metz, faulquemont).
directTrain(nancy, metz).

travelFromTo(S, D) :-
    directTrain(S, D).
travelFromTo(S, D) :-
    directTrain(S, D1),
    travelFromTo(D1, D).

%%%
%%%    3.4
%%%
greater_than(succ(_), 0).
greater_than(succ(X), succ(Y)) :-
    greater_than(X, Y).

%%%
%%%    3.5
%%%
%%
%%    Not exactly right... since leaf(3) is itself a tree.
%% tree(leaf(_), leaf(_)).
%% tree(tree(_, _), leaf(_)).
%% tree(leaf(_), tree(_, _)).
%% tree(tree(_, _), tree(_, _)).

%% tree(leaf(_)).
%% tree(L, R) :-
%%     tree(L),
%%     tree(R).

swap(leaf(A), leaf(A)).
swap(tree(A, B), tree(B1, A1)) :-
    swap(A, A1),
    swap(B, B1).

%% swap2(tree(leaf(A), leaf(B)), tree(leaf(B), leaf(A))).
%% swap2(T, T1) :-
%%     T = tree(A, B),
%%     T1 = tree(B1, A1),
%%     swap2(A, A1),
%%     swap2(B, B1).

%%%
%%%    Bidirectional!
%%%
%% ?- swap(tree(tree(leaf(a), leaf(b)), tree(leaf(c), leaf(d))), T).
%% T = tree(tree(leaf(d), leaf(c)), tree(leaf(b), leaf(a))).

%% ?- swap(T, tree(tree(leaf(a), leaf(b)), tree(leaf(c), leaf(d)))).
%% T = tree(tree(leaf(d), leaf(c)), tree(leaf(b), leaf(a))).
