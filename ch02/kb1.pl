%#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   NAME:               kb1.pl
%
%   STARTED:            Tue Jul 13 00:21:49 2010
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

vertical(line(point(X, Y), point(X, Z))).
horizontal(line(point(X, Y), point(Z, Y))).
