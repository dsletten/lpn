#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               even.pl
%
%   Started:            Sat Apr 24 20:49:29 2021
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
%   Notes: Practical Session ex. 1
%
%%

even --> [].
even --> a, even, a.
%even --> a, a, even.  % Equivalent to previous clause.

a --> [a].

%% even(A, A).
%% even(A, D) :-
%%     a(A, B),
%%     even(B, C),
%%     a(C, D).

%% a([a|A], A).


%%%
%%%    !
%%%    
%% 14 ?- even([a], [a]).
%% true 

%% 15 ?- even([a, a, a], [a]).
%% true 
