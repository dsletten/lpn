#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch04.pl
%
%   Started:            Mon Aug 19 01:16:44 2013
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

%%%
%%%    4.3
%%%
second(X, [_, X|_]).

%% ?- second(a, [b, a, c]).
%% true.

%% ?- second(a, [a, b, c]).
%% false.

%% ?- second(a, []).
%% false.

%% ?- second(a, [a, a, a]).
%% true.

%% ?- second(a, [b, a]).
%% true.

%% ?- second(a, [b, a, c, d, e]).
%% true.

%%%
%%%    4.4
%%%
swap12([X, Y|T], [Y, X|T]).

%% ?- swap12([a, b, c, d], [b, a, c, d]).
%% true.

%% ?- swap12([a, b, c, d], [a, b, c, d]).
%% false.

%% ?- swap12([a, b, c, d], [b, a, c]).
%% false.

%%%
%%%    4.5
%%%    
translate(eins, one).
translate(zwei, two).
translate(drei, three).
translate(vier, four).
translate(fuenf, five).
translate(sechs, six).
translate(sieben, seven).
translate(acht, eight).
translate(neun, nine).

list_translate([], []).
list_translate([G|Gs], [E|Es]) :-
    translate(G, E),
    list_translate(Gs, Es).

%% ?- list_translate([eins, neun, zwei], X).
%% X = [one, nine, two].

%% ?- list_translate(X, [one, seven, six, two]).
%% X = [eins, sieben, sechs, zwei] ;
%% false. <-- ????

%%%
%%%    4.6
%%%
twice([], []).
twice([H|T1], [H, H|T2]) :-
    twice(T1, T2).

%% ?- twice([a, 4, buggle], X).
%% X = [a, a, 4, 4, buggle, buggle].

%% ?- twice([1, 2, 1, 1], X).
%% X = [1, 1, 2, 2, 1, 1, 1, 1].




%%%
%%%    Practical Session
%%%    

%%% combine1/3
%% interleave([], [], []).
%% interleave([H|T1], [], [H|T2]) :-
%%     interleave(T1, [], T2).
%% interleave([], [H|T1], [H|T2]) :-
%%     interleave([], T1, T2).
%% interleave([H1|T1], [H2|T2], [H1, H2|T3]) :-
%%     interleave(T1, T2, T3).

%% ?- interleave([a, b, c], [1, 2, 3], X).
%% X = [a, 1, b, 2, c, 3] ;
%% false.

%% ?- interleave([f, b, yip, yup], [glu, gla, gli, glo], X).
%% X = [f, glu, b, gla, yip, gli, yup, glo] ;
%% false.

%% ?- interleave([a, b, c], [1, 2], X).
%% X = [a, 1, b, 2, c] ;
%% false.

%% ?- interleave([a, b], [1, 2, 3], X).
%% X = [a, 1, b, 2, 3] ;
%% false.

interleave([], L, L).
interleave([H|T1], L, [H|T2]) :-
    interleave(L, T1, T2).

%%% combine2/3
pair([], [], []).
pair([H1|T1], [H2|T2], [[H1, H2]|T3]) :-
    pair(T1, T2, T3).

%% ?- pair([a, b, c], [1, 2, 3], X).
%% X = [[a, 1], [b, 2], [c, 3]].

%% ?- pair([f, b, yip, yup], [glu, gla, gli, glo], X).
%% X = [[f, glu], [b, gla], [yip, gli], [yup, glo]].

%%% combine3/3
encase([], [], []).
encase([H1|T1], [H2|T2], [j(H1, H2)|T3]) :-
    encase(T1, T2, T3).

%% ?- encase([a, b, c], [1, 2, 3], X).
%% X = [j(a, 1), j(b, 2), j(c, 3)].

%% ?- encase([f, b, yip, yup], [glu, gla, gli, glo], X).
%% X = [j(f, glu), j(b, gla), j(yip, gli), j(yup, glo)].
