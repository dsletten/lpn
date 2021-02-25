#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch03.pl
%
%   Started:            Mon Oct 31 23:06:23 2011
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
%%%    Ex. 3.1
%%%    
child(anne, bridget).
child(bridget, caroline).
child(caroline, donna).
child(donna, emily).

descendant(X, Y) :-
    child(X, Y).
descendant(X, Y) :-
    descendant(X, Z),
    descendant(Z, Y).

%%%
%%%    Ex. 3.2
%%%
directlyIn(katarina, olga).
directlyIn(olga, natasha).
directlyIn(natasha, irina).

in(X, Y) :-
    directlyIn(X, Y).
in(X, Z) :-
    directlyIn(X, Y),
    in(Y, Z).


