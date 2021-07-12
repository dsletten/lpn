#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               propositional.pl
%
%   Started:            Sat Apr 24 20:54:12 2021
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

prop --> sym.
%% prop --> or.
%% prop --> and.
prop --> lpar, prop, or, prop, rpar.
prop --> lpar, prop, and, prop, rpar.
prop --> lpar, prop, implies, prop, rpar.
prop --> not, prop.

lpar --> ['('].
rpar --> [')'].

or --> [or].

and --> [and].

implies --> [implies].

not --> [not].

sym --> [p].
sym --> [q].
sym --> [r].
