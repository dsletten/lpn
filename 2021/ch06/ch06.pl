#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch06.pl
%
%   Started:            Tue Mar 30 01:36:36 2021
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

my_append([], L, L).
my_append([H|T], L1, [H|L2]) :-
    my_append(T, L1, L2).

append1([], L, L).
append1([H|T], L1, [H|L2]) :-
    append1(T, L1, L2).

append2([H|T], L1, [H|L2]) :-
    append2(T, L1, L2).
append2([], L, L).

revappend([], L, L).
revappend([H|T1], T2, L) :-
    revappend(T1, [H|T2], L).

%% reverse(A, B) :-
%%     reverse(A, B, []).
%% reverse([], L, L).
%% reverse([H|T1], B,T2) :-
%%     reverse(T1, B, [H|T2]).

%%%
%%%    6.1
%%%
double(L) :- append(L1, L1, L).

%% 43 ?- double([a, b, c, a, b, c]).
%% true ;
%% false.

%% 44 ?- double([a, b, c|L]).
%% L = [a, b, c] ;
%% L = [_4242, a, b, c, _4242] ;        <--- 
%% L = [_4242, _4254, a, b, c, _4242, _4254]   <--- These don't seem right...

%%%
%%%    6.2
%%%    
palindrome(L) :- reverse(L, L).

%% 46 ?- palindrome([r, o, t, a, t, o, r]).
%% true.

%% 47 ?- palindrome([n,u,r,s,e,s,r,u,n]).
%% true.

%% 50 ?- atom_chars(nursesrun, L), palindrome(L).
%% L = [n, u, r, s, e, s, r, u, n].

%% 51 ?- atom_chars(notthis, L), palindrome(L).
%% false.

%%%
%%%    6.3
%%%
toptail([_|T1], T) :-
    append(T, [_], T1).

%% 58 ?- toptail([a], T).
%% false.

%% 59 ?- toptail([a, b], T).
%% T = [] ;
%% false.

%% 60 ?- toptail([a, b, c], T).
%% T = [b] ;
%% false.

%% 61 ?- toptail([a, b, c, d], T).
%% T = [b, c] ;
%% false.

%%%
%%%    6.4
%%%
lastr(L, E) :-
    reverse(L, [E|_]).

%% 63 ?- lastr([a, b, c, d], E).
%% E = d.

%% 64 ?- lastr([a, b, c], E).
%% E = c.

%% 65 ?- lastr([a], E).
%% E = a.

%% 66 ?- lastr([], E).
%% false.

lastrec([E], E).
lastrec([_|T], E) :-
    lastrec(T, E).

%% 69 ?- lastrec([a, b, c, d], E).
%% E = d ;
%% false.

%% 70 ?- lastrec([a, b, c], E).
%% E = c ;
%% false.

%% 71 ?- lastrec([a], E).
%% E = a ;
%% false.

%% 72 ?- lastrec([], E).
%% false.

%%%
%%%    6.5
%%%    
swapfl([A|T1], [B|T2]) :-
    swapfl(T1, T2, A, B).
swapfl([B], [A], A, B) :- !.
swapfl([H|T1], [H|T2], A, B) :-
    swapfl(T1, T2, A, B).

%% 76 ?- swapfl([a, b], [b, a]).
%% true.

%% 77 ?- swapfl([a, c, b], [b, c, a]).
%% true.

%% 78 ?- swapfl([a, c, d, b], [b, c, d, a]).
%% true.

%% 79 ?- swapfl([a, c, d, b], [b, c, e, a]).
%% false.

%% 80 ?- swapfl([a, c, d, b], [b, c, a]).
%% false.

%%%
%%%    6.6
%%%

%% lists:append(A, B) :-
%% 	must_be(list, A),
%% 	append_(A, B).

%% lists:append([], A, A).
%% lists:append([A|B], C, [A|D]) :-
%% 	append(B, C, D).

%% %   Foreign: system:append/1

%% true.

%% 103 ?- listing(prefix).
%% lists:prefix([], _).
%% lists:prefix([A|B], [A|C]) :-
%% 	prefix(B, C).

suffix(S, L) :- append(_, S, L).
sublist(SubL, L) :- suffix(S, L), prefix(SubL, S).

color(red).
color(blue).
color(green).

nationality(english).
nationality(spanish).
nationality(japanese).

pet(zebra).
pet(jaguar).
pet(zebra).

%% house(color(red), nationality(english), pet(E)).
%% house(color(S), nationality(spanish), pet(jaguar)).
%% house(color(J), nationality(japanese), pet(Pj)) % P != snail
%% house(color(Sn), nationality(Nsn), pet(snail)). % C != blue, N != Japanese

%% [_, house(color(Sn), nationality(Nsn), pet(snail)), house(color(J), nationality(japanese), pet(Pj))]
%% [house(color(Sn), nationality(Nsn), pet(snail)), house(color(J), nationality(japanese), pet(Pj)), _]

street([H1, H2, H3]) :-
    sublist([house(color(Sn), nationality(Nsn), pet(snail)), house(color(J), nationality(japanese), pet(Pj))], [H1, H2, H3]),
    sublist([house(color(Sn), nationality(Nsn), pet(snail)), house(color(blue), nationality(X), pet(Pj))], [H1, H2, H3]),
    member(house(color(red), nationality(english), pet(E)), [H1, H2, H3]),
    member(house(color(S), nationality(spanish), pet(jaguar)), [H1, H2, H3]),
    member(house(color(blue), nationality(_), pet(_)), [H1, H2, H3]),
    member(house(color(green), nationality(_), pet(_)), [H1, H2, H3]),
    member(house(color(_), nationality(_), pet(zebra)), [H1, H2, H3]).

%%%
%%%    Redo
%%%
zebra(N) :-
    sublist([house(_, _, snail), house(_, japanese, _)], [H1, H2, H3]),
    sublist([house(_, _, snail), house(blue, _, _)], [H1, H2, H3]),
    member(house(red, english, _), [H1, H2, H3]),
    member(house(_, spanish, jaguar), [H1, H2, H3]),
%    member(house(blue, _, _), [H1, H2, H3]), % Redundant
    member(house(green, _, _), [H1, H2, H3]),
    member(house(_, N, zebra), [H1, H2, H3]).
    
%%%
%%%    Practical
%%%
membera(X, L) :- append(_, [X|_], L).

%% 53 ?- membera(a, [a, b, c, d]).
%% true ;
%% false.

%% 54 ?- membera(b, [a, b, c, d]).
%% true ;
%% false.

%% 56 ?- membera(c, [a, b, c, d]).
%% true ;
%% false.

%% 56 ?- membera(k, [a, b, c, d]).
%% false.

set([], []).
set([H|T1], T2) :-
    member(H, T1), !,
    set(T1, T2).
set([H|T1], [H|T2]) :-
    set(T1, T2).


%% 84 ?- set([a, b, c], L).
%% L = [a, b, c].

%% 87 ?- set([a, b, c, a], L).
%% L = [b, c, a].

%% 88 ?- set([a, b, c, a, b, b, c], L).
%% L = [a, b, c].

%% 89 ?- set([a, b, c], [c, b, a]).    <-- Not really sets!
%% false.

%% 90 ?- set([2, 2, foo, 1, foo, [], []], X).
%% X = [2, 1, foo, []].

my_flatten([], []).
my_flatten([[]|T1], T2) :-
    my_flatten(T1, T2).
my_flatten([H|T1], [H|T2]) :-
    H \= [_|_],
    H \= [],
    my_flatten(T1, T2).
my_flatten([[H|T]|T1], T2) :-
    my_flatten([H, T|T1], T2).

flatten2(T, L) :- flatten2(T, L, []).

flatten2([], L, L).
flatten2([[]|T], L1, L2) :-
    flatten2(T, L1, L2).
flatten2([H|T], L1, L2) :-
    H = [_|_],
    flatten2(T, L3, L2),
    flatten2(H, L1, L3).
flatten2([H|T], [H|L1], L2) :-
    H \= [_|_],
    H \= [],
    flatten2(T, L1, L2).
%%%
%%%    Wrong! Reversed.
%%%    
%% flatten2([H|T], L1, L2) :-
%%     H \= [_|_],
%%     H \= [],
%%     flatten2(T, L1, [H|L2]).
