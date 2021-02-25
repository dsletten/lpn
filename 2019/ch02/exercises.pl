#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               exercises.pl
%
%   Started:            Sat Jul 27 02:13:02 2019
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

house_elf(dobby).

witch(hermione).
witch('McGonagall').
witch(rita_skeeter).

%
%    This will work if other knowledge bases from the chapter are still loaded.
%    Otherwise Prolog will balk about the wizard/1 predicate in the 2nd rule.
%    
magic(X) :-
    house_elf(X).
%% magic(X) :-
%%     wizard(X).
magic(X) :-
    witch(X).

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

word(astante, a, s, t, a, n, t, e).
word(astoria, a, s, t, o, r, i, a).
word(baratto, b, a, r, a, t, t, o).
word(cobalto, c, o, b, a, l, t, o).
word(pistola, p, i, s, t, o, l, a).
word(statale, s, t, a, t, a, l, e).

crossword(V1, V2, V3, H1, H2, H3) :-
    word(V1, _, C11, _, C21, _, C31, _),
    word(V2, _, C12, _, C22, _, C32, _),
    word(V3, _, C13, _, C23, _, C33, _),
    word(H1, _, C11, _, C12, _, C13, _),
    word(H2, _, C21, _, C22, _, C23, _),
    word(H3, _, C31, _, C32, _, C33, _).
    