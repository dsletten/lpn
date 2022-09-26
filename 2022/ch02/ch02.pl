#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch02.pl
%
%   Started:            Thu Apr 14 01:30:08 2022
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

build_crossword([], []).
build_crossword([W|Ws], [R|Rs]) :-
    atom_chars(W, Cs),
    R =.. [word, W | Cs],
    build_crossword(Ws, Rs).


%% ?- build_crossword([astante, astoria, baratto, cobalto, pistola, statale], C).
%% C = [word(astante, a, s, t, a, n, t, e), word(astoria, a, s, t, o, r, i, a), word(baratto, b, a, r, a, t, t, o), word(cobalto, c, o, b, a, l, t, o), word(pistola, p, i, s, t, o, l, a), word(statale, s, t, a, t, a, l, e)].

word(astante, a, s, t, a, n, t, e).
word(astoria, a, s, t, o, r, i, a).
word(baratto, b, a, r, a, t, t, o).
word(cobalto, c, o, b, a, l, t, o).
word(pistola, p, i, s, t, o, l, a).
word(statale, s, t, a, t, a, l, e).

crossword(V1, V2, V3, H1, H2, H3) :-
    word(V1, _, A, _, D, _, G, _),
    word(V2, _, B, _, E, _, H, _),
    word(V3, _, C, _, F, _, I, _),
    word(H1, _, A, _, B, _, C, _),
    word(H2, _, D, _, E, _, F, _),
    word(H3, _, G, _, H, _, I, _).

%%%
%%%    Solution set (6) is identical to 2010 version, but newer SWIPl displays differently!
%%%    
%% ?- crossword(W1, W2, W3, W4, W5, W6).
%% W1 = W4, W4 = astante,
%% W2 = W5, W5 = baratto,
%% W3 = W6, W6 = statale ;

%% W1 = astante,    % These 2 full solutions (with no duplicates) are simply rotated H->V
%% W2 = cobalto,
%% W3 = pistola,
%% W4 = astoria,
%% W5 = baratto,
%% W6 = statale ;
%% W1 = astoria,
%% W2 = baratto,
%% W3 = statale,
%% W4 = astante,
%% W5 = cobalto,
%% W6 = pistola ;

%% W1 = W4, W4 = astoria,
%% W2 = W5, W5 = cobalto,
%% W3 = W6, W6 = pistola ;
%% W1 = W2, W2 = W4, W4 = W5, W5 = baratto,
%% W3 = W6, W6 = statale ;
%% W1 = W4, W4 = cobalto,
%% W2 = W5, W5 = baratto,
%% W3 = W6, W6 = statale ;
%% false.
