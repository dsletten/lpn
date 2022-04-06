#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               frequency.pl
%
%   Started:            Tue Aug  3 13:40:34 2021
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

:- module(frequency, []).
:- dynamic word/2.

read_word(Stream, end_of_file) :-
    peek_char(Stream, end_of_file), !.
read_word(Stream, Word) :-
    get_char(Stream, Ch),
    read_rest(Ch, Chs, Stream),
    atom_chars(Word, Chs).

terminal(' ').
terminal('\n').
terminal(end_of_file).

read_rest(Ch, [], _) :-
    terminal(Ch),
    !.
read_rest(Ch, [Ch|Chs], Stream) :-
    get_char(Stream, Ch1),
    read_rest(Ch1, Chs, Stream).

count_word(Word) :-
    word(Word, N),
    retract(word(Word, N)),
    N1 is N + 1,
    assertz(word(Word, N1)).
count_word(Word) :-
    \+ word(Word, _),
    assertz(word(Word, 1)).

read_file(F) :-
    open(F, read, In),
    read_word(In, Word),
    read_words(In, Word),
    close(In).

read_words(_, end_of_file) :- !.
read_words(In, '') :- !,
    read_word(In, Word1),
    read_words(In, Word1).
read_words(In, Word) :-
    count_word(Word),
    read_word(In, Word1),
    read_words(In, Word1).

%% frequency:read_file('LearnPrologNow/2021/ch12/email.txt').

%% 115 ?- findall([W, N], (frequency:word(W, N), N > 1), L).
%% L = [[on, 2], [a, 2], [you, 2], [have, 2], [no, 2], [are, 2], [an, 2], [more, 2], [the, 6], [we, 2], [trust, 2], [editorial, 2], [of, 6], [advertising, 4], [to, 6]].

