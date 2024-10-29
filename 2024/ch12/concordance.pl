#!/opt/local/bin/swipl -q -t main -f
%%  -*- Mode: Prolog -*-
%   Name:               concordance.pl
%
%   Started:            Fri Oct 25 00:22:45 2024
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

:- module(concordance, []).
:- dynamic word/2.

read_file(File, Words) :-
    open(File, read, In),
    read_words(In, Ws),
    remove_empty(Ws, Words),
    count_words(Words),
    close(In), !.

remove_empty([], []).
remove_empty([''|T], Ws) :-
    remove_empty(T, Ws).
remove_empty([W|T], [W|Ws]) :-
    W \= '',
    remove_empty(T, Ws).

count_words([]).
count_words([W|Ws]) :-
    word(W, C), !,
    retract(word(W, C)),
    C1 is C + 1,
    assertz(word(W, C1)),
    count_words(Ws).
count_words([W|Ws]) :-
    assertz(word(W, 1)),
    count_words(Ws).

%% read_words(Stream, Ws) :-
%%     findall(W, read_word(Stream, W), Ws).

%% read_words(Stream, Ws) :-
%%     read_words(Stream, Ws, 3).
%% read_words(_, [], 0).
%% read_words(Stream, [W|Ws], N) :-
%%     N1 is N - 1,
%%     read_word(Stream, W),
%%     read_words(Stream, Ws, N1).

read_words(Stream, []) :-
    at_end_of_stream(Stream).
read_words(Stream, [W|Ws]) :-
    read_word(Stream, W),
    read_words(Stream, Ws).

read_word(Stream, Word) :-
    read_chars(Stream, Chars),
    atom_chars(Word, Chars).

read_chars(Stream, Chars) :-
    get_char(Stream, Char),
    read_chars(Stream, Char, Chars).

read_chars(_, Ch, []) :- delimiter(Ch), !.
%% read_chars(_, ' ', []) :- !.
%% read_chars(_, '.', []) :- !.
%% read_chars(_, '?', []) :- !.
%% read_chars(_, '!', []) :- !.
%% read_chars(_, ',', []) :- !.
%% read_chars(_, ':', []) :- !.
%% read_chars(_, '\n', []) :- !.
%% read_chars(_, '\t', []) :- !.
read_chars(_, -1, []) :- !.
read_chars(Stream, Char, [Char|Chars]) :-
    get_char(Stream, Char1),
    read_chars(Stream, Char1, Chars).

delimiter(' ').
delimiter('.').
delimiter('?').
delimiter('!').
delimiter(',').
delimiter(':').
delimiter('\n').
delimiter('\t').
