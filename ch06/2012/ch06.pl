#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch06.pl
%
%   Started:            Wed Feb 22 23:51:26 2012
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

%% reverse([], []).
%% reverse([H|T], L) :-
%%     reverse(T, L1),
%%     append(L1, [H], L).

my_reverse(L, R) :-
    my_reverse(L, [], R).
my_reverse([], L, L).
my_reverse([H|T], L, L1) :-
    my_reverse(T, [H|L], L1).

%%%
%%%    6.1
%%%
doubled(L) :- append(L1, L1, L).

%% ?- doubled([a, b, c, a, b, c]).
%% true ;
%% false.

%% ?- doubled([foo, gubble, foo, gubble]).
%% true ;
%% false.

%% ?- doubled([foo, gubble, foo]).
%% false.

%%%
%%%    6.2
%%%
palindrome(L) :-
    reverse(L, L).

%% ?- palindrome([r,o,t,a,t,o,r]).
%% true.

%% ?- palindrome([n,u,r,s,e,s,r,u,n]).
%% true.

%% ?- palindrome([n,o,t,h,i,s]).
%% false.

%%%
%%%    6.3
%%%
toptail([_, X|T], L) :-
    append(L, [_], [X|T]).

%% ?- toptail([a], T).
%% false.

%% ?- toptail([a, b], T).
%% T = [] ;
%% false.

%% ?- toptail([a, b, c], T).
%% T = [b] ;
%% false.

%%%
%%%    6.4
%%%
%% last(L, X) :-
%%     reverse(L, [X|_]).

%% ?- last([a, b, c], X).
%% X = c.

%% ?- last([a, b], X).
%% X = b.

%% ?- last([a], X).
%% X = a.

%% ?- last([], X).
%% false.

last([X], X).
last([_|T], X) :-
    last(T, X).

%% ?- last([a, b, c], X).
%% X = c ;
%% false.

%% ?- last([a, b], X).
%% X = b ;
%% false.

%% ?- last([a], X).
%% X = a ;
%% false.

%% ?- last([], X).
%% false.

%%%
%%%    6.5
%%%
%% swapfl(L1, L2) :-
%%     L1 = [H1|T1],
%%     L2 = [H2|T2],
%%     append(T1, [H1]

%% swapfl([X, Y], [Y, X]).
%% swapfl([H1|T1], [H2|T2]) :-
    

%% swapfl([X, Y], [Y, X]).
%% swapfl([X, Z|T1], [Y, Z|T2]) :-
%%     swapfl([X|T1], [Y|T2]).

%% ?- swapfl([a, b], [b, a]).
%% true ;
%% false.

%% ?- swapfl([a, b], [a, b]).
%% false.

%% ?- swapfl([a, c, b], [b, c, a]).
%% true ;
%% false.

%% ?- swapfl([a, c, d, b], [b, c, d, a]).
%% true ;
%% false.

%% ?- swapfl([a, c, d, e, b], [b, c, d, e, a]).
%% true ;
%% false.

%%%
%%%    6.6
%%%
%%%    https://literateprograms.org/zebra_puzzle__prolog_.html
%%%    
%% house(red).
%% house(blue).
%% house(green).

%% occupant(english).
%% occupant(spanish).
%% occupant(japanese).

%% pet(jaguar).
%% pet(snail).
%% pet(zebra).

%% [[Nationality, Color, Pet], [], []]

%% house(english, red, Pet).
%% house(spanish, Color, jaguar).
%% house(japanese, C, Pet), Pet \= snail.
%% house(N, C, snail), C \= blue.
member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

prefix(P, L) :- append(P, _, L).
suffix(S, L) :- append(_, S, L).

sublist(L1, L) :- suffix(L2, L), prefix(L1, L2).

%% house(red, english, P).
%% house(C, spanish, jaguar).
%% house(C, japanese, P).
%% house(C, N, snail).

street([H1, H2, H3]) :-
    L = [H1, H2, H3],
    H1 = house(_, _, _),
    H2 = house(_, _, _),
    H3 = house(_, _, _),
    member(house(red, english, _), L),
    member(house(_, spanish, jaguar), L),
    member(house(green, _, _), L),
    member(house(_, _, zebra), L),
%    member(house(_, japanese, _), L),
%    member(house(_, _, snail), L),

%    member(house(C1, japanese, P1), [H2, H3]),
%    member(house(_, japanese, _), [house(_, _, jaguar), house(_, _, zebra)]),

    member(house(blue, _, _), [house(_, _, jaguar), house(_, _, zebra)]),

%    member(house(_, _, snail), [H1, H2]),

    sublist([house(_, _, snail), house(blue, _, _)], L),
    sublist([house(_, _, snail), house(_, japanese, _)], L).
    

%% street([H1, H2, H3]) :-
%%     L = [H1, H2, H3],
%%     sublist([H4|T], L),
%%     member(house(C1, japanese, P1), T),
%%     sublist(L2, L),
%%     L2 = [_|[_]],
%%     member(house(C2, N2, snail), L2).

%%%
%%%    Practical
%%%
my_member(X, L) :- append(_, [X|_], L).

%% ?- my_member(2, [1, 2, 3]).
%% true ;
%% false.

%% ?- my_member(2, [1, 2, 3, 2]).
%% true ;
%% true ;
%% false.

%% ?- my_member(2, [1, 3, 4]).
%% false.

%% ?- my_member(2, [2, 1, 3, 4]).
%% true ;
%% false.

%% set([], []).
%% set([H|T], S) :-
%%     set(T, S),
%%     member(H, S).
%% set([H|T], [H|S]) :-
%%     set(T, S).

%% set([], []).
%% set([H|T1], T2) :- member(H, T1), set(T1, T2).
%% set([H|T1], [H|T2]) :- set(T1, T2).

my_set(In, Out) :-
    my_set(In, Out, []).

my_set([], L, L).
my_set([H|T1], T2, L) :- my_set(T1, T2, L), member(H, T2).
my_set([H|T1], [H|T2], L) :- my_set(T1, T2, L).

%% flatten([], []).
%% flatten([H|T], L) :- H = [_|_], flatten(H, L1), flatten(T, L2), append(L1, L2, L).
%% flatten([H|T1], [H|T2]) :- flatten(T1, T2).

%%%
%%%    No append!
%%%    
flatten1([], []).
flatten1([[]|T], L) :- flatten1(T, L).
flatten1([[H|T]|T1], L) :- flatten1([H, T|T1], L).
flatten1([H|T], [H|L]) :- flatten1(T, L).

flatten(L1, L2) :- flatten(L1, L2, []).
flatten([], L, L).
flatten([[X|Y]|T], L, Acc) :- flatten(T, L1, Acc), flatten([X|Y], L, L1).
flatten([H|T], [H|L], Acc) :- flatten(T, L, Acc).

onlisp_flatten(L1, L2) :- onlisp_flatten(L1, L2, []).
onlisp_flatten([], L, L).
onlisp_flatten(X, [X|L], L) :- X \= [_|_], X \= [].
onlisp_flatten([H|T], L, Acc) :- onlisp_flatten(T, L1, Acc), onlisp_flatten(H, L, L1).
%onlisp_flatten([[X|Y]|T], L, Acc) :- onlisp_flatten(T, L1, Acc), onlisp_flatten([X|Y], L, L1).
