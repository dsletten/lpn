%#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   NAME:               descendants5.pl
%
%   STARTED:            Tue Aug 24 09:45:18 2010
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
    child(Z, Y),
    descendant(X, Z).

    