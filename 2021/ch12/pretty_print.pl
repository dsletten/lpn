#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               pretty_print.pl
%
%   Started:            Fri Aug  6 17:49:55 2021
%   Modifications:
%
%   Purpose:
%   Practical session from ch. 9 repackaged as module.
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

:- module(pretty_print, [pptree/2]).

%%%
%%%    Practical
%%%    pptree/1 pretty print a compound term.
%%%    Only works for strict tree? Leaves are single-arg functors.
%%%
pptree(Stream, T) :-
    compound(T),
    pptree(Stream, T, 0).

pptree(Stream, T, D) :-
    T =.. [_,A],
    Depth is D * 2,
    tab(Stream, Depth),
    atomic(A),
    write(Stream, T).

pptree(Stream, T, D) :-
    T =.. [_,A],
    Depth is D * 2,
    tab(Stream, Depth),
    var(A),
    write(Stream, T).

pptree(Stream, T, D) :-
    T =.. [F|As],
    Depth is D * 2,
    tab(Stream, Depth),
    write(Stream, F),
    write(Stream, '('),
    D1 is D + 1,
    pplist(Stream, As, D1),
    write(Stream, ')').

pplist(_, [], _).
pplist(Stream, [A|As], D) :-
    nl(Stream),
    pptree(Stream, A, D),
    pplist(Stream, As, D).
