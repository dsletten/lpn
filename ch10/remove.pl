#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               remove.pl
%
%   Started:            Wed May 23 23:24:38 2012
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

remove(_, [], []).
remove(Obj, [Obj|T1], T2) :- remove(Obj, T1, T2).
remove(Obj, [H|T1], [H|T2]) :- H \= Obj, remove(Obj, T1, T2).

remove1(_, [], []).
remove1(Obj, [Obj|T1], T2) :- !, remove1(Obj, T1, T2).
remove1(Obj, [H|T1], [H|T2]) :- remove1(Obj, T1, T2).

remove2(_, [], []).
remove2(Obj, [Obj|T1], T2) :- remove2(Obj, T1, T2), !.
remove2(Obj, [H|T1], [H|T2]) :- remove2(Obj, T1, T2).
