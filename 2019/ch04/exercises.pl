#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               exercises.pl
%
%   Started:            Tue Aug 13 21:10:33 2019
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

%
%    4.3
%
second(X, [_, X|_]).

% ?- second(a, [a, b, c]).
% false.

% ?- second(b, [a, b, c]).
% true.

% ?- second(b, [a, b]).
% true.

% ?- second(b, [a, b, c, d]).
% true.

%
%    4.4
%
swap12([X, Y|T], [Y, X|T]).

% ?- swap12([a, b], [b, a]).
% true.

% ?- swap12([a, b, c], [b, a, c]).
% true.

% ?- swap12([a, b, c, d], [b, a, c, d]).
% true.

% ?- swap12([a, b, c, d], [b, a, c]).
% false.

% ?- swap12([a, b, c, d], [b, a, c, e]).
% false.

% ?- swap12([a, b, c, d], [a, b, c, d]).
% false.

%
%    4.5
%
tran(eins, one).
tran(zwei, two).
tran(drei, three).
tran(vier, four).
tran(fuenf, five).
tran(sechs, six).
tran(sieben, seven).
tran(acht, eight).
tran(neun, nine).

listtran([], []).
listtran([G|T1], [E|T2]) :-
    tran(G, E),
    listtran(T1, T2).

% ?- listtran([eins, neun, zwei], E).
% E = [one, nine, two].

% ?- listtran(G, [one, seven, six, two]).
% G = [eins, sieben, sechs, zwei].

%
%    4.6
%
twice([], []).
twice([X|T1], [X, X|T2]) :-
    twice(T1, T2).

% ?- twice([a, 4, buggle], X).
% X = [a, a, 4, 4, buggle, buggle].

% ?- twice([1, 2, 1, 1], X).
% X = [1, 1, 2, 2, 1, 1, 1, 1].

% ?- twice(X, [1, 1, 2, 2, 3, 3, 4, 4]).
% X = [1, 2, 3, 4].

% ?- listtran(G, [one, seven, six, two]), twice(G, X).
% G = [eins, sieben, sechs, zwei],
% X = [eins, eins, sieben, sieben, sechs, sechs, zwei, zwei].

%
%    5.
%
combine1([], [], []).
combine1([X|T1], [Y|T2], [X, Y|T3]) :-
    combine1(T1, T2, T3).

% ?- combine1([a, b, c], [1, 2, 3], X).
% X = [a, 1, b, 2, c, 3].

% ?- combine1([f, b, yip, yup], [glu, gla, gli, glo], Result).
% Result = [f, glu, b, gla, yip, gli, yup, glo].

combine2([], [], []).
combine2([X|T1], [Y|T2], [[X, Y]|T3]) :-
    combine2(T1, T2, T3).

% ?- combine2([a, b, c], [1, 2, 3], X).
% X = [[a, 1], [b, 2], [c, 3]].

% ?- combine2([f, b, yip, yup], [glu, gla, gli, glo], Result).
% Result = [[f, glu], [b, gla], [yip, gli], [yup, glo]].

combine3([], [], []).
combine3([X|T1], [Y|T2], [j(X, Y)|T3]) :-
    combine3(T1, T2, T3).


% ?- combine3([a, b, c], [1, 2, 3], X).
% X = [j(a, 1), j(b, 2), j(c, 3)].

% ?- combine3([f, b, yip, yup], [glu, gla, gli, glo], Result).
% Result = [j(f, glu), j(b, gla), j(yip, gli), j(yup, glo)].
