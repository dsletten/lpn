%#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   NAME:               magickb.pl
%
%   STARTED:            Mon Jul 26 00:22:44 2010
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

house_elf(dobby).

witch(hermione).
witch('McGonagall').
witch(rita_skeeter).

magic(X) :- house_elf(X).
%magic(X) :- wizard(X).
magic(X) :- witch(X).
magic(X) :- wizard(X).
