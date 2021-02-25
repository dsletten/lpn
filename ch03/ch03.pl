%#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   NAME:               ch03.pl
%
%   STARTED:            Tue Aug 24 10:34:50 2010
%   MODIFICATIONS:
%
%   PURPOSE:
%
%
%
%   CALLING SEQUENCE:
%
%
%   INPUTS:
%
%   OUTPUTS:
%
%   EXAMPLE:
%
%   NOTES:
%
%%

%%%
%%%    Ex. 3.1
%%%    
child(anne, bridget).
child(bridget, caroline).
child(caroline, donna).
child(donna, emily).

descendant(X, Y) :- child(X, Y).
descendant(X, Y) :-
    descendant(X, Z),
    descendant(Z, Y).

%%%
%%%    Ex. 3.2
%%%
directly_in(katarina, olga).
directly_in(olga, natasha).
directly_in(natasha, irina).

in(X, Y) :- directly_in(X, Y).
in(X, Y) :-
    directly_in(X, Z),
    in(Z, Y).

%%%
%%%    Ex. 3.3
%%%
direct_train(saarbruecken, dudweiler).
direct_train(forbach, saarbruecken).
direct_train(freyming, forbach).
direct_train(st_avold, freyming).
direct_train(fahlquemont, st_avold).
direct_train(metz, fahlquemont).
direct_train(nancy, metz).

%%%
%%%    This introduces non-termination
%%%    
% direct_train(X, Y) :- direct_train(Y, X).

%%%
%%%    This is only one-way!
%%%

%% ?- travel_from_to(nancy, saarbruecken).
%% true ;
%% false.

%% ?- travel_from_to(saarbruecken, nancy).
%% false.

travel_from_to(X, Y) :- direct_train(X, Y).
travel_from_to(X, Y) :-
    direct_train(X, Z),
    travel_from_to(Z, Y).

%%%
%%%    Ex. 3.4
%%%    
greater_than(succ(X), X).
greater_than(succ(X), Y) :- greater_than(X, Y).
    
%%%
%%%    Ex. 3.5
%%%
swap(leaf(X), leaf(X)).
%swap(tree(leaf(X), leaf(Y)), tree(leaf(Y), leaf(X))).
swap(tree(X, Y), tree(Y1, X1)) :- swap(X, X1), swap(Y, Y1).
%swap(tree(X, Y), tree(Y, X)) :- swap(X, Y).