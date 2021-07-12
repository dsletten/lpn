#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               abcd.pl
%
%   Started:            Sat Apr 24 20:54:00 2021
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
%   Notes: Practical Session ex. 2
%
%%

%%%
%%%    This is wrong. Only recognizes 2 or 4 b/c's
%%%    
%% s --> [].
%% s --> a, mid1, d.

%% mid1 --> [].
%% mid1 --> b, b, mid2, c, c.
%% mid1 --> a, mid1, d.

%% mid2 --> [].
%% mid2 --> b, b, c, c.

s --> [].
s --> a, mid, d.

%mid --> [].
mid --> bcm.
mid --> a, mid, d.

bcm --> [].
bcm --> b, b, bcm, c, c.

a --> [a].
b --> [b].
c --> [c].
d --> [d].

