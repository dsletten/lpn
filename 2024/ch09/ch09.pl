#!/opt/local/bin/swipl -q -t main -f
%%  -*- Mode: Prolog -*-
%   Name:               ch09.pl
%
%   Started:            Mon Sep 23 20:36:41 2024
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

%:- module(ch09, []).

%%%
%%%    9.3
%%%    
termtype(T, atom) :-
    atom(T).
termtype(T, integer) :-
    integer(T).
termtype(T, float) :-
    float(T).
termtype(T, number) :-
    number(T).
termtype(T, constant) :-
    atomic(T).
termtype(T, variable) :-
    var(T).
termtype(T, complex_term) :-
    compound(T).
termtype(T, simple_term) :-
    \+ compound(T).
termtype(_, term).

%% ?- termtype(Vincent, variable).
%% true.

%% ?- termtype(mia, X).
%% X = atom ;
%% X = constant ;
%% X = simple_term ;
%% X = term.

%% ?- termtype(dead(zed), X).
%% X = complex_term ;
%% X = term.

%% ?- termtype(pi, X).
%% X = atom ;
%% X = constant ;
%% X = simple_term ;
%% X = term.

%% ?- Pi is pi, termtype(Pi, X).
%% Pi = 3.141592653589793,
%% X = float ;
%% Pi = 3.141592653589793,
%% X = number ;
%% Pi = 3.141592653589793,
%% X = constant ;
%% Pi = 3.141592653589793,
%% X = simple_term ;
%% Pi = 3.141592653589793,
%% X = term.

%%%
%%%    9.4
%%%
groundterm(X) :-
    atomic(X).
groundterm(X) :-
    compound(X),
    X =.. [_|Args],
    groundterms(Args).
groundterms([]).
groundterms([H|T]) :-
    groundterm(H),
    groundterms(T).

%%%
%%%    9.5
%%%
:- op(300, xfx, [are, is_a]).
:- op(300, fx, likes).
:- op(200, xfy, and).
:- op(100, fy, famous).



%%%
%%%    Print atom "as is".
%%%    Print
%% pptree(T) :-
%%     pptree(T, 0).
%% pptree(T, Depth) :-
%%     \+ compound(T),
%%     tab(Depth),
%%     write(T).
%% pptree(T, Depth) :-
%%     compound(T),
%%     print_compound(T, Depth).

%% print_compound(T, Depth) :-
%%     functor(T, F, 0, compound),
%%     print_zero_arity_compound(T, F, Depth).
%% print_compound(T, Depth) :-
%%     functor(T, F, 1, compound),
%%     print_single_arity_compound(T, F, Depth).
%% print_compound(T, Depth) :-
%%     functor(T, _, A, compound),
%%     A > 1,
%%     print_multiple_arity_compound(T, Depth).

%% print_zero_arity_compound(T, F, Depth) :-
%%     tab(Depth),
%%     write(F),
%%     write('('),
%%     write(')').
%% print_single_arity_compound(T, F, Depth) :-
%%     tab(Depth),
%%     write(F),
%%     write('('),
%%     arg(1, T, A),
%%     pptree(A),
%%     write(')').
%% print_multiple_arity_compound(T, Depth) :-
%%     tab(Depth),
%%     T =.. [F|Args],
%%     write(F),
%%     write('('),
%%     atom_chars(F, Cs),
%%     length(Cs, L),
%%     Depth1 is Depth + L + 1,
%%     nl,
%%     print_multiple_args(Args, Depth1),
%%     write(')').

%% print_multiple_args([H], Depth) :-
%%     pptree(H, Depth).
%% print_multiple_args([H|T], Depth) :-
%%     T = [_|_],
%%     pptree(H, Depth),
%%     nl,
%%     print_multiple_args(T, Depth).

%pptree(s(np(det(a),n(man)),vp(v(shoots),np(det(a),n(woman))))).
%pptree(s(a(1), b(), c(k, z))).
%pptree(a(b(c(d)))).

%%%
%%%    Pretty print a term.
%%%    Simple terms are simply printed via write/1.
%%%    Compound terms are printed based on their arity:
%%%    1. 0-arg predicates are handled essentially as simple terms (with ())
%%%    2. 1-arg predicates print their arg inline.
%%%    3. 1+ arg predicates print the functor and '(' then a newline.
%%%       Args are recursively pretty printed at a depth one column to the right
%%%       of the '(' above them. Each arg is printed with a newline except the
%%%       final arg which adds the matching ')'.
%%%       
%%%    The Depth parameter on its own is sufficient for all cases except where
%%%    a 1-arg predicate contains a 1+ arg predicate. The nested functor is printed
%%%    inline, yet its args must know how much further to Indent due to the functor
%%%    of the containing 1-arg predicate. E.g. a(b(c(X), d(Y))):
%%%    a(b(
%%%    ____c(X)
%%%        d(Y)))
%%%        
pptree(T) :-
    pptree(T, 0, 0).
pptree(T, Depth, _) :-
    \+ compound(T),
    tab(Depth),
    write(T).
pptree(T, Depth, Indent) :-
    compound(T),
    print_compound(T, Depth, Indent).

%    Must use functor/4 in case of 0-arg predicates!
print_compound(T, Depth, _) :-
    functor(T, F, 0, compound),
    tab(Depth),
    write(F),
    write('('),
    write(')').
print_compound(T, Depth, Indent) :-
    functor(T, F, 1, compound),
    print_single_arity_compound(T, F, Depth, Indent).
print_compound(T, Depth, Indent) :-
    functor(T, _, A, compound),
    A > 1,
    print_multiple_arity_compound(T, Depth, Indent).

print_single_arity_compound(T, F, Depth, Indent) :-
    atom_chars(F, Cs),
    length(Cs, L),
    Indent1 is Indent + L + 1 + Depth,
    arg(1, T, A),
    tab(Depth),
    write(F),
    write('('),
    pptree(A, 0, Indent1),
    write(')').
print_multiple_arity_compound(T, Depth, Indent) :-
    T =.. [F|Args],
    atom_chars(F, Cs),
    length(Cs, L),
    Depth1 is Depth + L + 1 + Indent,
    tab(Depth),
    write(F),
    write('('),
    nl,
    print_multiple_args(Args, Depth1, 0),
    write(')').

print_multiple_args([H], Depth, Indent) :-
    pptree(H, Depth, 0).
print_multiple_args([H|T], Depth, Indent) :-
    T = [_|_],
    pptree(H, Depth, Indent),
    nl,
    print_multiple_args(T, Depth, Indent).

%% pptree(a(b(e(f(c(2, 3, 4), d))))).
%% pptree(a(b(e(f(c(2, 3, 4), d()))))).
%% pptree(a(b(e(f(c(2, 3, 4), d(8)))))).
%% pptree(a(b(e(f(c(2, 3, 4), d(8, 5)))))).
%% pptree(s(np(det(a),n(man)),vp(v(shoots),np(det(a),n(woman))))).
%% pptree(s(a(1), b(), c(k, z))).
%% pptree(a(b(c(d)))).
%% pptree(a(b(),c(9),d(e(f(8), g())))).
%% pptree(a(b(),c(9),d(e(f(8))))).
%% pptree(s(a, b, c)).
%% pptree(s(foo(a), bar(b))).
