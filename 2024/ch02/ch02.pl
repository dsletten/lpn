#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch02.pl
%
%   Started:            Thu May  9 21:34:54 2024
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

%:- module(ch02, []).

%%%
%%%    2.3
%%%    
word(determiner, a).
word(determiner, every).
word(noun, criminal).
word(noun, 'big kahuna burger').
word(verb, eats).
word(verb, likes).

sentence(W1, W2, W3, W4, W5) :-
    word(determiner, W1),
    word(noun, W2),
    word(verb, W3),
    word(determiner, W4),
    word(noun, W5).

%%%
%%%    2.4
%%%
word(astante, a, s, t, a, n, t, e).
word(astoria, a, s, t, o, r, i, a).
word(baratto, b, a, r, a, t, t, o).
word(cobalto, c, o, b, a, l, t, o).
word(pistola, p, i, s, t, o, l, a).
word(statale, s, t, a, t, a, l, e).

crossword(V1, V2, V3, H1, H2, H3) :-
    word(V1, _, L11, _, L21, _, L31, _),
    word(V2, _, L12, _, L22, _, L32, _),
    word(V3, _, L13, _, L23, _, L33, _),
    word(H1, _, L11, _, L12, _, L13, _),
    word(H2, _, L21, _, L22, _, L23, _),
    word(H3, _, L31, _, L32, _, L33, _).
