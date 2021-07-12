#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               train_grammar.pl
%
%   Started:            Tue Apr 20 02:20:32 2021
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

s --> foo, bar, wiggle.
foo --> [choo].
foo --> foo, foo.
bar --> mar, zar.
mar --> me, my.
me --> [i].
my --> [am].
zar --> blar, car.
blar --> [a].
car --> [train].
wiggle --> [toot].
wiggle --> wiggle, wiggle.
