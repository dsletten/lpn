#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch04.pl
%
%   Started:            Sat Mar 20 01:44:09 2021
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


member1(X, [X|_]).
member1(X, [_|T]) :- member1(X, T).

a2b([], []).
a2b([a|T1], [b|T2]) :- a2b(T1, T2).

%%%
%%%    4.3
%%%
second(X, [_, X|_]).
second(X, [_|T]) :-
    second(X, T).

%% 110 ?- second(b, [a, b, c, d]).
%% true ;
%% false.

%% 111 ?- second(a, [a, b, c, d]).
%% false.

%% 113 ?- second(b, [a, b, c]).
%% true ;
%% false.

%% 113 ?- second(b, [a, b]).
%% true ;
%% false.

%%%
%%%    4.4
%%%    
swap12([A, B|T], [B, A|T]).

%% 115 ?- swap12([a, b], [b, a]).
%% true.

%% 116 ?- swap12([a, b], X).
%% X = [b, a].

%% 117 ?- swap12(X, [b, a]).
%% X = [a, b].

%% 118 ?- swap12([A, B], [b, a]).
%% A = a,
%% B = b.

%% 119 ?- swap12([a, b, c, d], [b, a, c, d]).
%% true.

%% 120 ?- swap12([a, b, c, d], [b, a, c, e]).
%% false.

%%%
%%%    4.5
%%%
tran(eins, one).
tran(zwei, two).
tran(drei, three).
tran(vier, four).
tran(fünf, five).
tran(sechs, six).
tran(sieben, seven).
tran(acht, eight).
tran(neun, nine).

listtran([], []).
listtran([G|T1], [E|T2]) :-
    tran(G, E),
    listtran(T1, T2).

%% 122 ?- listtran([eins, neun, zwei], X).
%% X = [one, nine, two].

%% 123 ?- listtran(X, [one, seven, six, two]).
%% X = [eins, sieben, sechs, zwei].

%% 124 ?- listtran([X, vier, Y], [five, A, eight]).
%% X = fünf,
%% Y = acht,
%% A = four.

%% 125 ?- listtran([X, vier, Y], [five, A, eight, T]).
%% false.

%%%
%%%    4.6
%%%
twice([], []).
twice([H|T1], [H, H|T2]) :-
    twice(T1, T2).

%% 127 ?- twice([a, 4, buggle], X).
%% X = [a, a, 4, 4, buggle, buggle].

%% 128 ?- twice([1, 2, 1, 1], X).
%% X = [1, 1, 2, 2, 1, 1, 1, 1].

%% 129 ?- twice(X, [a, a, b, b, q, q]).
%% X = [a, b, q].

%%%
%%%    Practical
%%%
%%%    1.
%%%
combine1([], [], []).
combine1([H1|T1], [H2|T2], [H1, H2|T3]) :-
    combine1(T1, T2, T3).

%% 131 ?- combine1([a, b, c], [1, 2, 3], X).
%% X = [a, 1, b, 2, c, 3].

%% 132 ?- combine1([a, b, c], [1, 2], X).
%% false.

%% 133 ?- combine1([a, b], [1, 2, 3], X).
%% false.

%% 134 ?- combine1([f, b, yip, yup], [glu, gla, gli, glo], X).
%% X = [f, glu, b, gla, yip, gli, yup, glo].

%%%
%%%    2. pairlis
%%%
combine2([], [], []).
combine2([H1|T1], [H2|T2], [[H1, H2]|T3]) :-
    combine2(T1, T2, T3).

%% 136 ?- combine2([a, b, c], [1, 2, 3], X).
%% X = [[a, 1], [b, 2], [c, 3]].

%% 137 ?- combine2([f, b, yip, yup], [glu, gla, gli, glo], X).
%% X = [[f, glu], [b, gla], [yip, gli], [yup, glo]].

%%%
%%%    3.
%%%
combine3([], [], []).
combine3([H1|T1], [H2|T2], [j(H1, H2)|T3]) :-
    combine3(T1, T2, T3).

%% 139 ?- combine3([a, b, c], [1, 2, 3], X).
%% X = [j(a, 1), j(b, 2), j(c, 3)].

%% 140 ?- combine3([f, b, yip, yup], [glu, gla, gli, glo], X).
%% X = [j(f, glu), j(b, gla), j(yip, gli), j(yup, glo)].
