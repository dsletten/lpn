%#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   NAME:               descendants4.pl
%
%   STARTED:            Fri Aug 20 10:39:42 2010
%   MODIFICATIONS:
%
%   PURPOSE:
%
%
%
%   CALLING SEQUENCE:
%
%
%   INPUTS:
%
%   OUTPUTS:
%
%   EXAMPLE:
%
%   NOTES:
%
%%

child(anne, bridget).
child(bridget, caroline).
child(caroline, donna).
child(donna, emily).

descendant(X, Y) :- child(X, Y).
descendant(X, Y) :-
    descendant(Z, Y),
    child(X, Z).

    