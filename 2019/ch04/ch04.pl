#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch04.pl
%
%   Started:            Tue Aug 13 20:22:02 2019
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


mymember(X, [X|_]).
mymember(X, [_|L]) :-
    mymember(X, L).

% member(X, '[|]'(X, _)).
% member(X, '[|]'(_, L)) :-
%     member(X, L).

a2b([], []).
a2b([a|T1], [b|T2]) :-
    a2b(T1, T2).
