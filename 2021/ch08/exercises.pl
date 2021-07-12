#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               exercises.pl
%
%   Started:            Wed May 12 04:35:04 2021
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

%%%
%%%    8.2
%%%    
kanga(V, R, Q) --> roo(V, R),
                   jumps(Q, Q),
                   {marsupial(V, R, Q)}.

%% kanga(V, R, Q, A, C) :-
%%     roo(V, R, A, B),
%%     jumps(Q, Q, B, C),
%%     marsupial(V, R, Q).
kanga(A, B, D, C, F) :-
	roo(A, B, C, E),
	jumps(D, D, E, G),
	marsupial(A, B, D),
	F=G.
