#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               negation_as_failure.pl
%
%   Started:            Wed Jul 21 03:01:57 2021
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

enjoys(vincent, X) :- big_kahuna_burger(X), !, fail.
enjoys(vincent, X) :- burger(X).

%% enjoys(vincent, X) :- burger(X), \+ big_kahuna_burger(X).

burger(X) :- big_mac(X).
burger(X) :- big_kahuna_burger(X).
burger(X) :- whopper(X).

big_mac(a).
big_kahuna_burger(b).
big_mac(c).
whopper(d).
