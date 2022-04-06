#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               hogwarts.pl
%
%   Started:            Tue Aug  3 13:20:05 2021
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

:- module(hogwarts, [print_houses/0]).

print_houses :-
    open('hogwarts.houses', write, Stream),
    tab(Stream, 8),
    write(Stream, 'gryffindor'), % Quotes unnecessary!
    nl(Stream),
    write(Stream, hufflepuff),
    tab(Stream, 6),
    write(Stream, ravenclaw),
    nl(Stream),
    tab(Stream, 8),
    write(Stream, slytherin),
    nl(Stream),
    close(Stream).
