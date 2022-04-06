#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               test_parser.pl
%
%   Started:            Fri Aug  6 17:52:01 2021
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

:- module(test_parser, [test/2]).

:- use_module(parser).
:- use_module(pretty_print).

%% test(File, Sentence) :-
%%     s(Tree, Sentence, []),
%%     open(File, write, Out),
%%     pptree(Out, Tree),
%%     close(Out).

test(In, Out) :-
    open(In, read, InStream),
    read(InStream, Sentence),
    close(InStream),
    s(Tree, Sentence, []),
    open(Out, write, OutStream),
    write(OutStream, Sentence),
    nl(OutStream),
    nl(OutStream),
    pptree(OutStream, Tree),
    nl(OutStream),
    close(OutStream).

%% 152 ?- test('LearnPrologNow/2021/ch12/test1.in', 'LearnPrologNow/2021/ch12/test1.out').
%% true 

read_word_as_atom(Stream, end_of_file) :-
    peek_char(Stream, end_of_file), !.
read_word_as_atom(Stream, end_of_sentence) :-
    peek_char(Stream, '.'), !,
    get_char(Stream, _).
read_word_as_atom(Stream, Word) :-
    get_char(Stream, Ch),
    read_rest(Ch, Chs, Stream),
    atom_chars(BigWord, Chs),
    downcase_atom(BigWord, Word).

terminal(' ').
terminal('.').
terminal('\n').
terminal(end_of_file).

read_rest(Ch, [], _) :-
    terminal(Ch),
    !.
read_rest(Ch, [Ch], Stream) :-
    peek_char(Stream, '.'),
    !.
read_rest(Ch, [Ch|Chs], Stream) :-
    get_char(Stream, Ch1),
    read_rest(Ch1, Chs, Stream).

process_test_suite(TestFile, ResultFile) :-
    open(TestFile, read, In),
    read_tests(In, Tests),
    close(In),
    length(Tests, N),
    writeln(N),
    open(ResultFile, write, Out),
    process_tests(Out, Tests),
    close(Out).

read_tests(Stream, Tests) :-
    read_test(Stream, T),
    read_tests(Stream, T, Tests).
read_tests(_, [], []) :- !.
read_tests(Stream, T, [[T, R]|Tests]) :-
    read_word_as_atom(Stream, W),
    read_result(Stream, W, R),
    read_test(Stream, T1),
    read_tests(Stream, T1, Tests).

read_test(Stream, S) :-
    read_word_as_atom(Stream, W),
    read_sentence(Stream, W, S).

read_result(Stream, '', R) :- !,
    read_word_as_atom(Stream, W),
    read_result(Stream, W, R).
read_result(_, R, R).

read_sentence(_, end_of_sentence, []) :- !.
read_sentence(_, end_of_file, []) :- !.
read_sentence(In, '', S) :- !,
    read_word_as_atom(In, W),
    read_sentence(In, W, S).
read_sentence(In, W, [W|S]) :-
    read_word_as_atom(In, W1),
    read_sentence(In, W1, S).
    
process_tests(_, []) :- !. % This goes absolutely haywire without this clause... Figure this out!
process_tests(Stream, [[T, R]|Ts]) :-
    process_test(Stream, T, R),
    process_tests(Stream, Ts).

process_test(Stream, T, true) :-
    s(Tree, T, []),
    !,
    write(Stream, 'The sentence '),
    write(Stream, T),
    writeln(Stream, ' was successfully parsed as expected.'),
    writeln(Stream, 'The parse tree is: '),
    pptree(Stream, Tree),
    nl(Stream).
process_test(Stream, T, true) :-
    \+ s(_, T, []),
    !,
    write(Stream, 'The sentence '),
    write(Stream, T),
    writeln(Stream, ' failed to parse but should have.'),
    nl(Stream).
process_test(Stream, T, false) :-
    s(Tree, T, []),
    !,
    write(Stream, 'The sentence '),
    write(Stream, T),
    writeln(Stream, ' was successfully parsed but should have failed.'),
    writeln(Stream, 'The parse tree is: '),
    pptree(Stream, Tree),
    nl(Stream).
process_test(Stream, T, false) :-
    \+ s(_, T, []),
    !,
    write(Stream, 'The sentence '),
    write(Stream, T),
    writeln(Stream, ' failed to parse as expected.'),
    nl(Stream).

