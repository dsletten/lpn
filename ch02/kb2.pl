%#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   NAME:               kb2.pl
%
%   STARTED:            Tue Jul 13 00:38:37 2010
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

f(a).
f(b).

g(a).
g(b).

h(b).

k(X) :- f(X), g(X), h(X).
