#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch07.pl
%
%   Started:            Tue Apr 20 02:26:48 2021
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
%%%    Ex. 7.2
%%%    
s --> [a, b].
s --> l, s, r.
l --> [a].
r --> [b].

%%%
%%%    Ex. 7.3
%%%
t --> [].
t --> l, t, r2.
r2 --> r, r.



