#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               flatten.pl
%
%   Started:            Sun Aug 25 04:44:05 2013
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

%% flatten([], []).
%% flatten([H|T], L) :-
%%     H = [H1|T1],
%%     flatten([H1, T1|T], L).
%% flatten([H|T], [H|L]) :-
%%     H \= [_|_],
%%     flatten(T, L).

%% flatten([], []).
%% flatten([[H|T]], L) :-
%%     flatten([H|T], L).
%% flatten([H], [H]) :- H \= [_|_].
%% flatten([[]|T], L) :-
%%     flatten(T, L).
%% flatten([H|[H2|T]], L) :-
%%     H = [H1|T1],
%%     flatten([H1, T1, H2|T], L).
%% flatten([H|T], [H|L]) :-
%%     H \= [_|_],
%%     H \= [],
%%     flatten(T, L).

flatten([], []).
%flatten([H], [H]) :- H \= [_|_].
flatten([[]|T], L) :-
    flatten(T, L).
%% flatten([[H|T]], L) :-
%%     flatten([H|T], L).
%% flatten([H|[H2|T]], L) :-
%%     H = [H1|T1],
%%     flatten([H1, T1, H2|T], L).
flatten([[H1|T1]|T], L) :-
    flatten([H1, T1|T], L).

flatten([H|T], [H|L]) :-
    H \= [_|_],
    H \= [],
    flatten(T, L).
