#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               basic.pl
%
%   Started:            Sat Jul 27 21:18:35 2019
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

clean(socks).
clean(towel).

dry(socks).
dry(towel).

serviceable(towel).

ready_for_inspection(X) :-
    clean(X),
    dry(X),
    serviceable(X).
