%#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   NAME:               crossword.pl
%
%   STARTED:            Wed Jul 28 02:09:03 2010
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

%% (defvar *words* '(astante astoria baratto cobalto pistola statale))

%% (dolist (word *words*)
%% (format t "word(~A, ~A).~%" (string-downcase (string word)) (with-output-to-string (s) (format s "~A" (char-downcase (char (string word) 0))) (dolist (ch (rest (coerce (string word) 'list))) (format s ", ~A" (char-downcase ch))))))

word(astante, a, s, t, a, n, t, e).
word(astoria, a, s, t, o, r, i, a).
word(baratto, b, a, r, a, t, t, o).
word(cobalto, c, o, b, a, l, t, o).
word(pistola, p, i, s, t, o, l, a).
word(statale, s, t, a, t, a, l, e).

crossword(V1, V2, V3, H1, H2, H3) :-
    word(V1, L1, L2, L3, L4, L5, L6, L7),
    word(V2, L8, L9, L10, L11, L12, L13, L14),
    word(V3, L15, L16, L17, L18, L19, L20, L21),
    word(H1, L22, L2, L24, L9, L26, L16, L28),
    word(H2, L29, L4, L31, L11, L33, L18, L35),
    word(H3, L36, L6, L38, L13, L40, L20, L42).

%%%
%%%    Many of the above variables are irrelevant.
%%%    Here's how SWIPL interprets the rule:
%%%    
%% crossword(A, B, C, D, H, L) :-
%% 	word(A, _, E, _, I, _, M, _),
%% 	word(B, _, F, _, J, _, N, _),
%% 	word(C, _, G, _, K, _, O, _),
%% 	word(D, _, E, _, F, _, G, _),
%% 	word(H, _, I, _, J, _, K, _),
%% 	word(L, _, M, _, N, _, O, _).

%%%
%%%    6 possible solutions.
%%%    
%% ?- crossword(W1, W2, W3, W4, W5, W6).
%% W1 = astante,
%% W2 = baratto,
%% W3 = statale,
%% W4 = astante,
%% W5 = baratto,
%% W6 = statale ;
%% W1 = astante,
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
%% W1 = astoria,
%% W2 = cobalto,
%% W3 = pistola,
%% W4 = astoria,
%% W5 = cobalto,
%% W6 = pistola ;
%% W1 = baratto,
%% W2 = baratto,
%% W3 = statale,
%% W4 = baratto,
%% W5 = baratto,
%% W6 = statale ;
%% W1 = cobalto,
%% W2 = baratto,
%% W3 = statale,
%% W4 = cobalto,
%% W5 = baratto,
%% W6 = statale ;
%% false.
