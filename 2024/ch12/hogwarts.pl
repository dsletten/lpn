#!/opt/local/bin/swipl -q -t main -f
%%  -*- Mode: Prolog -*-
%   Name:               hogwarts.pl
%
%   Started:            Thu Oct 24 01:42:30 2024
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

%%    ~/prolog/lpn/text/chapter12.tex
%% \begin{LPNcodedisplay}
%%        gryffindor
%% hufflepuff     ravenclaw
%%        slytherin



:- module(hogwarts, []).

write_houses :-
    open("hogwart.houses", write, Out),
    tab(Out, 7),
    write(Out, gryffindor),
    nl(Out),
    write(Out, hufflepuff),
    tab(Out, 5),
    write(Out, ravenclaw),
    nl(Out),
    tab(Out, 7),
    write(Out, slytherin),
    nl(Out),
    close(Out).
