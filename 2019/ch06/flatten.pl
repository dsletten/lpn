#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               flatten.pl
%
%   Started:            Tue Aug 20 00:02:46 2019
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
%       Distilled ideas from ~/prolog/books/LearnPrologNow/ch06/2012/flatten/flatten.pl
%       as well as ~/prolog/books/LearnPrologNow/ch06/2012/flatten/flatten.lisp and
%       ~/lisp/programs/implementation/flatten.lisp
%%

%
% Straightforward version the "follows the type" (CTMCP 3.4.2.6)
%
flatten1([], []).
flatten1([H|T], F) :-
    H = [_|_],
    flatten1(H, F1),
    flatten1(T, F2),
    append(F1, F2, F).
flatten1([[]|T], F) :-
    flatten1(T, F).
flatten1([H|T], [H|F]) :-
    H \= [_|_],
    H \= [],
    flatten1(T, F).

% 2013
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
    flatten([H1, T1|T], L).      % <------ Raise up nested list!!!

flatten([H|T], [H|L]) :-
    H \= [_|_],
    H \= [],
    flatten(T, L).


?- [[H1|T1]|T] = [[a, b], c, [d, [e]]], L = [H1, T1|T].
H1 = a,
T1 = [b],
T = [c, [d, [e]]],
L = [a, [b], c, [d, [e]]].

%%%
%%%    Swipl
%%%    
%% lists:flatten(A, B) :-
%% 	flatten(A, [], C), !,
%% 	B=C.

%% lists:flatten(A, B, [A|B]) :-
%% 	var(A), !.
%% lists:flatten([], A, A) :- !.
%% lists:flatten([A|C], D, B) :- !,
%% 	flatten(A, E, B),
%% 	flatten(C, D, E).
%% lists:flatten(A, B, [A|B]).
