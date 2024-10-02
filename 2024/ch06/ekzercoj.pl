#!/opt/local/bin/swipl -q -t main -f
%%  -*- Mode: Prolog -*-
%   Name:               ekzercoj.pl
%
%   Started:            Sun Jun  9 20:20:53 2024
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

%:- module(ekzercoj, []).

%%%
%%%    6.1
%%%    
doubled(L) :-
    append(L1, L1, L).

%% ?- doubled([a, b, c, a, b, c]).
%% true ;
%% false.

%% ?- doubled([foo, gubble, foo, gubble]).
%% true ;
%% false.

%% ?- doubled([foo, gubble, foo]).
%% false.

%% ?- doubled([a, b|T]).
%% T = [a, b] ;
%% T = [_A, a, b, _A] ;
%% T = [_A, _B, a, b, _A, _B] 

%%%
%%%    6.2
%%%
palindrome(L) :-
    reverse(L, L).

%% ?- palindrome([r,o,t,a,t,o,r]).
%% true.

%% ?- palindrome([n,u,r,s,e,s,r,u,n]).
%% true.

%% ?- palindrome([n,o,t,t,h,i,s]).
%% false.

%% ?- palindrome([a, b, c|T]).
%% T = [b, a] ;
%% T = [c, b, a] ;
%% T = [_, c, b, a] ;
%% T = [_A, _A, c, b, a] 

palindrome1(L) :-
    palindrome1(L, []).
palindrome1(L, L).
palindrome1([_|L], L).
palindrome1([H|T], L) :-
    palindrome1(T, [H|L]).

%% ?- palindrome1([r,o,t,a,t,o,r]).
%% true ;
%% false.

%% ?- palindrome1([n,u,r,s,e,s,r,u,n]).
%% true ;
%% false.

%% ?- palindrome1([n,o,t,t,h,i,s]).
%% false.

%% ?- palindrome1([a, b, c|T]).
%% T = [b, a] ;
%% T = [c, b, a] ;
%% T = [_, c, b, a] ;
%% T = [_A, _A, c, b, a] 

%%%
%%%    6.3
%%%
toptail(L, T) :-
    append([_|T], [_], L).

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
last1(L, X) :-
    reverse(L, [X|_]).

%% last2([X], X).
%% last2([_,H|T], X) :-    <-- Unnecessary
%%     last2([H|T], X).

last2([X], X).
last2([_|T], X) :-
    last2(T, X).

%% ?- last1([a, b, c], X).
%% X = c.

%% ?- last1([a, c], X).
%% X = c.

%% ?- last1([c], X).
%% X = c.

%% ?- last1([], X).
%% false.

%% ?- last2([a, b, c], X).
%% X = c ;
%% false.

%% ?- last2([a, c], X).
%% X = c ;
%% false.

%% ?- last2([c], X).
%% X = c ;
%% false.

%% ?- last2([], X).
%% false.

%%%
%%%    6.5
%%%
swapfl([H1|T1], [H2|T2]) :-
    append(L, [H2], T1),
    append(L, [H1], T2).

%% ?- swapfl([a, b, c, d], [d, b, c, a]).
%% true ;
%% false.

%% ?- swapfl([a, b, d], [d, b, a]).
%% true ;
%% false.

%% ?- swapfl([a, d], [d, a]).
%% true 

%% ?- swapfl([a, b, c, d], L).
%% L = [d, b, c, a] ;
%% false.

%% ?- swapfl(L, [a, b, c, d]).
%% L = [d, b, c, a] ;
%% ERROR: Stack limit (1.0Gb) exceeded
%% ERROR:   Stack sizes: local: 1Kb, global: 0.9Gb, trail: 0Kb
%% ERROR:   Stack depth: 10, last-call: 10%, Choice points: 4
%% ERROR:   In:
%% ERROR:     [10] user:swapfl('<garbage_collected>', '<garbage_collected>')
%% ERROR:     [9] '$toplevel':toplevel_call('<garbage_collected>')
%% ERROR:     [8] '$toplevel':stop_backtrace('<garbage_collected>')
%% ERROR:     [7] '$tabling':'$wfs_call'('<garbage_collected>', '<garbage_collected>')
%% ERROR:     [5] '$toplevel':'$execute_goal2'('<garbage_collected>', [length:1], _230034572)
%% ERROR: 
%% ERROR: Use the --stack_limit=size[KMG] command line option or
%% ERROR: ?- set_prolog_flag(stack_limit, 2_147_483_648). to double the limit.

swapfl1([H1|T1], [H2|T2]) :-
    swapfl1(H1, H2, T1, T2).
swapfl1(H1, H2, [H2], [H1]).
swapfl1(H1, H2, [X|T1], [X|T2]) :-
    swapfl1(H1, H2, T1, T2).

%% ?- swapfl1([a, b, c, d], [d, b, c, a]).
%% true ;
%% false.

%% ?- swapfl1([a, b, d], [d, b, a]).
%% true ;
%% false.

%% ?- swapfl1([a, d], [d, a]).
%% true ;
%% false.

%% ?- swapfl1([a, b, c, d], L).
%% L = [d, b, c, a] ;
%% false.

%% ?- swapfl1(L, [a, b, c, d]).
%% L = [d, b, c, a] ;
%% false.

%%%
%%%    6.6
%%%

prefix(P, L) :- append(P, _, L).
suffix(S, L) :- append(_, S, L).
sublist(L1, L) :- suffix(L2, L), prefix(L1, L2).

%% zebra(Street) :-
%%     Street = [H1, H2, H3],
%%     sublist([house(C1, N1, snail), house(C2, japanese, P2)], Street),
%%     sublist([house(C1, N1, snail), house(blue, N2, P2)], Street),
%%     member(house(red, english, P1), Street),
%%     member(house(C3, spanish, jaguar), Street),
%%     member(house(red, _, _), Street),          <-- Fully explicit constraints (overkill)c
%%     member(house(blue, _, _), Street),
%%     member(house(green, _, _), Street),
%%     member(house(_, english, _), Street),
%%     member(house(_, spanish, _), Street),
%%     member(house(_, japanese, _), Street),
%%     member(house(_, _, snail), Street),
%%     member(house(_, _, zebra), Street),
%%     member(house(_, _, jaguar), Street).

%%
%%    Consolidated
%%    
zebra(N) :-
    Street = [_, _, _],
    sublist([house(_, _, snail), house(_, japanese, _)], Street),
    sublist([house(_, _, snail), house(blue, _, _)], Street),
    member(house(red, english, _), Street),
    member(house(green, _, _), Street),
    member(house(_, spanish, jaguar), Street),
    member(house(_, N, zebra), Street).

%%%
%%%    Redefined avoiding built-ins to facilitate tracing.
%%%    
zebra_(N) :-
    Street = [_, _, _],
    sublist_([house(_, _, snail), house(_, japanese, _)], Street),
    sublist_([house(_, _, snail), house(blue, _, _)], Street),
    member_(house(red, english, _), Street),
    member_(house(green, _, _), Street),
    member_(house(_, spanish, jaguar), Street),
    member_(house(_, N, zebra), Street).

member_(X, [X|_]).
member_(X, [_|T]) :- member_(X, T).

append_([], L, L).
append_([H|T1], L, [H|T2]) :- append_(T1, L, T2).

prefix_(P, L) :- append_(P, _, L).
suffix_(S, L) :- append_(_, S, L).

sublist_(S, L) :-
    suffix_(S1, L),
    prefix_(S, S1).


prefix1([], _).
prefix1([H|T], [H|L]) :-
    prefix1(T, L).

%% ?- prefix1([a, b, c], [a, b, c, d, e]).
%% true.

%% ?- prefix1(P, [a, b, c, d, e]).
%% P = [] ;
%% P = [a] ;
%% P = [a, b] ;
%% P = [a, b, c] ;
%% P = [a, b, c, d] ;
%% P = [a, b, c, d, e] ;
%% false.

%% ?- prefix1([a, b, c], [a, b]).
%% false.

suffix1([], _).
suffix1(S, L) :-
    match1(S, L).

%% match1([], []).
%% match1([H|T], [H|L]) :-
%%     match2(T, L).
%% match1([H|T], [H|L]) :-
%%     match1([H|T], L).
%% match1([A|T], [B|L]) :-
%%     A \= B,
%%     match1([A|T], L).

match1([], []).
match1([H|T], [H|L]) :-
    match2(T, L);
    match1([H|T], L).
match1([A|T], [B|L]) :-
    A \= B,
    match1([A|T], L).

match2([], []).
match2([H|T], [H|L]) :-
    match2(T, L).

%% ?- suffix1([a, b, c], [a, b, c]).
%% true ;
%% false.

%% ?- suffix1([a, b, c], [a, a, b, c]).
%% true ;
%% false.

%% ?- suffix1([a, b, c], [a, b, a, b, c]).
%% true ;
%% false.

%% ?- suffix1([a, b, c], [a, b, a, c]).
%% false.

%% ?- suffix1([a, b, c], [a, x, a, b, a, b, c]).
%% true ;
%% false.

%% ?- suffix1([a, b, c], [x, x, x, a, b, c]).
%% true ;
%% false.

suffix2(L, L).
suffix2(L, [_|T]) :-
    suffix2(L, T).


%%%
%%%    1.
%%%
member1(X, L) :-
    append(_, [X|_], L).

%%%
%%%    2.
%%%
remove_duplicates([], []).
remove_duplicates([H|T], L) :-
    member(H, T),
    remove_duplicates(T, L).
remove_duplicates([H|T], [H|L]) :-
    remove_duplicates(T, L).

%%%
%%%    3.
%%%
flatten1([], []).
flatten1([[]|T], L) :-
    flatten1(T, L).
flatten1([[H|T1]|T2], L) :-
    flatten1([H,T1|T2], L).
flatten1([H|T], [H|L]) :-
    flatten1(T, L).

%%
%%    A little better
%%    
flatten2([], []).
flatten2([[]|T], L) :-
    flatten2(T, L).
flatten2([H|T], [H|L]) :-
    H \= [],
    H \= [_|_],
    flatten2(T, L).
flatten2([[H|T1]|T2], L) :-
    flatten2([H,T1|T2], L).
