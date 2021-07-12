#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch09.pl
%
%   Started:            Sun Jul  4 03:46:27 2021
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

univ(T, [F|L]) :-
    functor(T, F, A),
    build_list(T, A, L).

build_list(T, A, L) :-
    build_list(T, A, 0, L).

build_list(_, A, A, []) :- !.
build_list(T, A, I, [X|Xs]) :-
    I1 is I + 1,
    arg(I1, T, X),
    build_list(T, A, I1, Xs).

%%%
%%%    9.2
%%%
%% .(a, .(b, .(c, []))) = [a, b, c].
%% .(a, .(b, .(c, []))) = [a, b|[c]].
%% .(.(a, []), .(.(b, []), .(.(c, []), []))) = X.
%% .(a, .(b, .(.(c, []), []))) = [a, b|[c]].
%% .(a, .(b, .(.(c, []), []))) = [a, b, [c]].


%% 150 ?- '[|]'(a, '[|]'(b, '[|]'(c, []))) = [a, b, c].
%% true.

%% 151 ?- '[|]'(a, '[|]'(b, '[|]'(c, []))) = [a, b|[c]].
%% true.

%% 152 ?- '[|]'('[|]'(a, []), '[|]'('[|]'(b, []), '[|]'('[|]'(c, []), []))) = X.
%% X = [[a], [b], [c]].

%% 153 ?- '[|]'(a, '[|]'(b, '[|]'('[|]'(c, []), []))) = [a, b|[c]].
%% false.

%% 155 ?- '[|]'(a, '[|]'(b, '[|]'('[|]'(c, []), []))) = [a, b, [c]].
%% true.

%% 156 ?- '[|]'(a, '[|]'(b, '[|]'('[|]'(c, []), []))) = [a, b|[[c]]].
%% true.

%%%
%%%    9.3
%%%
termtype(T, complex_term) :-
    compound(T).
termtype(T, atom) :-
    atom(T).
termtype(T, number) :-
    number(T).
termtype(T, constant) :-
    atomic(T).
termtype(T, variable) :-
    var(T).
termtype(T, simple_term) :-
    atom(T).
termtype(T, simple_term) :-
    number(T).
termtype(T, simple_term) :-
    var(T).

termtype(_, term).

%termtype(T, integer).
%termtype(T, float).
%termtype(T, nonvar).

%%%
%%%    9.4 Book also solves without using univ.
%%%
groundterm(T) :-
    atom(T).
groundterm(T) :-
    number(T).
%% groundterm(T) :-  % Book consolidates previous 2 rules...
%%     atomic(T).
groundterm(T) :-
    compound(T),
    T =.. [_|A],
    groundterm_list(A).

groundterm_list([]).
groundterm_list([A|As]) :-
    groundterm(A),
    groundterm_list(As).

%%%
%%%    9.5
%%%
:- op(300, xfx, [are, is_a]).
:- op(300, fx, likes). % This should be infix!
:- op(200, xfy, and).
:- op(100, fy, famous).

%%%
%%%    Practical
%%%    pptree/1 pretty print a compound term.
%%%    Only works for strict tree? Leaves are single-arg functors.
%%%
pptree(T) :-
    compound(T),
    pptree(T, 0).

pptree(T, D) :-
    T =.. [_,A],
    Depth is D * 2,
    tab(Depth),
    atomic(A),
    write(T).

pptree(T, D) :-
    T =.. [_,A],
    Depth is D * 2,
    tab(Depth),
    var(A),
    write(T).

pptree(T, D) :-
    T =.. [F|As],
    Depth is D * 2,
    tab(Depth),
    write(F),
    write('('),
    D1 is D + 1,
    pplist(As, D1),
    write(')').

pplist([], _).
pplist([A|As], D) :-
    nl,
    pptree(A, D),
    pplist(As, D).
