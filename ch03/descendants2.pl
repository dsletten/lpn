%#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   NAME:               descendants2.pl
%
%   STARTED:            Mon Aug  9 02:56:20 2010
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

descendant(X, Y) :-
    child(X, Z),
    descendant(Z, Y).
descendant(X, Y) :- child(X, Y).

 % The recursive rule yields a DFS in reverse order.
 % anne -> emily
 %      -> donna
 %      -> caroline
 %
 % bridget -> emily
 %         -> donna
 %
 % caroline -> emily    