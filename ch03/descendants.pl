#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   NAME:               descendants.pl
%
%   STARTED:            Sat Jul 31 16:21:56 2010
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
    child(X, Z),
    descendant(Z, Y).

 % Depth-first recursive rule.
 % anne -> caroline
 %      -> donna
 %      -> emily
 %
 % bridget -> donna
 %         -> emily
 %
 % caroline -> emily