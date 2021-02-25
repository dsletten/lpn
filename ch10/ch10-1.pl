#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch10-1.pl
%
%   Started:            Wed May  9 20:09:19 2012
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
p(X) :- a(X).
p(X) :- b(X), c(X), d(X), e(X).
p(X) :- f(X).

a(1).

b(1).
b(2).

c(1).
c(2).

d(2).

e(2).

f(3).

p1(X) :- a(X).
p1(X) :- b(X), c(X), !, d(X), e(X).
p1(X) :- f(X).
