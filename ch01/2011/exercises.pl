#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               exercises.pl
%
%   Started:            Sun Oct 16 15:31:55 2011
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

killer(butch).
married(mia, marcellus).
dead(zed).
kills(marcellus, X) :- massage(X, mia, foot).
loves(mia, X) :- goodDancer(X).
eats(jules, X) :- nutritious(X); tasty(X).

wizard(ron).
hasWand(harry).
quidditchPlayer(harry).
wizard(X) :- hasBroom(X), hasWand(X).
hasBroom(X) :- quidditchPlayer(X).

language(lisp).
language(clojure).
language(prolog).
language(java).
language(oz).
language(javascript).
language(haskell).
language(ruby).

sucks(java).
sucks(javascript).

rocks(lisp).
rocks(clojure).
rocks(prolog).
rocks(oz).

influenced(lisp, clojure).
influenced(prolog, oz).
influenced(lisp, oz).
influenced(oz, clojure).

inventor(lisp, 'John McCarthy').
inventor(clojure, 'Rich Hickey').
inventor(oz, 'Peter Van Roy').
inventor(prolog, 'Alain Colmerauer').
