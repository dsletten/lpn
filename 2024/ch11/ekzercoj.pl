#!/opt/local/bin/swipl -q -t main -f
%%  -*- Mode: Prolog -*-
%   Name:               ekzercoj.pl
%
%   Started:            Mon Oct 21 14:03:52 2024
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

:- module(ekzercoj, []).

%%%
%%%    11.2
%%%    
q(blob, blug).
q(blob, blag).
q(blob, blig).
q(blaf, blag).
q(dang, dong).
q(dang, blug).
q(flab, blob).

%%%
%%%    11.3
%%%
:- dynamic sigmares/2.

sigma(1, 1).
sigma(N, S) :-
    sigmares(N, S), !.
sigma(N, S) :-
    N > 1,
    N1 is N - 1,
    sigma(N1, S1),
    S is S1 + N,
    assertz(sigmares(N, S)).

%%%
%%%    Practical Session
%%%

%% subset([], _).
%% subset([H|T], S) :-
%%     member(H, S),
%%     remove(H, S, S1),
%%     subset(T, S1).

%% remove(X, [X|T], T).
%% remove(X, [H|T1], [H|T2]) :-
%%     X \= H,
%%     remove(X, T1, T2).

%% make_set(L, S) :-
%%     setof(X, member(X, L), S).
%% subset_f(S1, S2) :-
%%     nonvar(S1),
%%     is_set(S1),
%%     is_set(S2),
%%     findall(X, (member(X, S1), member(X, S2)), S1).
%% %% set_equal(A, B) :-
%% %%     subset_f(A, B),
%% %%     subset_f(B, A).

%% is_set([]).
%% is_set([H|T]) :-
%%     \+ member(H, T),
%%     is_set(T).

%% %% is_set(A) :-
%% %%     make_set(A, B),
%% %%     set_equal(A, B).
%% %is_set(A)

%% %% subset(S1, S2) :-
%% %% %    set(S1),
%% %%     set(S2),
%% %%     subset_(S1, S2).

%% %% subset_([], _).
%% %% subset_([H|T], S) :-
%% %%     member(H, S),
%% %%     subset_(T, S).

%% subset(S1, S2) :-
%%     subset(S1, S2, []).
%% subset([], _, _).
%% subset([H|T], S, Xs) :-
%%     member(H, S),
%%     \+ member(H, Xs),
%%     subset(T, S, [H|Xs]).

%% subset1([], _).
%% subset1([H|T1], [H|T2]) :-
%%     subset1(T1, T2).
%% subset1([H1|T1], [H2|T2]) :-
%%     H1 \= H2,
%%     subset1([H1], T2),
%%     subset1(T1, [H2|T2]).

%% subset_x(S1, S2) :-
%%     var(S1),
%%     is_set(S2),
%%     subset_x_(S1, S2).
%% subset_x_([], []).
%% subset_x_([H|T1], [H|T2]) :-
%%     subset_x_(T1, T2).
%% subset_x_(T1, [_|T2]) :-
%%     subset_x_(T1, T2).

%% %%%    This works and satisifes the book's exercise.
%% %% powerset(S1, P) :-
%% %%     findall(S, subset_x(S, S1), P).

%% %%%
%% %%%    D'oh! This works and satisifes the book's exercise. But we
%% %%%    need an independent powerset/2 to define subset/2 below!
%% %%%    
%% %% powerset(S1, P) :-
%% %%     findall(S, subset_pow(S, S1), P).

%% %%
%% %%    subset_f/2 and subset_x/2 each solve half of the problem.
%%     subset_f/2 is actually more straightforward than the final subset/2
%%     below. It relies on the fundamental definition:
%%     A ⊂ B ⟺ x ∈ A ⟹ x ∈ B
%% % subset_f/2 works fine if both S1 and S2 are instantiated...
%% % subset_x/2 works to generate subsets of S2.

%% %%%
%% %%%    Advanced Prolog 101 页
%% %%%    
%% subset_ross([], []).
%% subset_ross(Subset, [H|X]) :-
%%     subset_ross(T, X),
%%     ( Subset = T;
%%       Subset = [H|T]).

%% %% ?- subset_ross(X, [a, b, c]).
%% %% X = [] ;
%% %% X = [a] ;
%% %% X = [b] ;
%% %% X = [a, b] ;
%% %% X = [c] ;
%% %% X = [a, c] ;
%% %% X = [b, c] ;
%% %% X = [a, b, c].

%% %%%
%% %%%    D'oh!
%% %%%
%% %% ?- subset_ross([a, c, b], [a, b, c]).
%% %% false.

%% %% ?- subset_ross([a, b, c], [a, b, c, a]).
%% %% true ;
%% %% false.


%% %%%
%% %%%    Slade ch. 8
%% %%%    
%% layer_elt(Elt, Set, Result) :-
%%     layer_elt(Elt, Set, Set, Result).
%% layer_elt(_, [], S, S).
%% layer_elt(Elt, [H|T], S, R) :-
%%     layer_elt(Elt, T, [[Elt|H]|S], R).

%% %%
%% %%    Lisp: (power-set s) => p  "The power set of s is p."
%% %%    Prolog: power_set(P, S).  "P is the power set of S."
%% %%    
%% power_set([[]], []).
%% power_set(P, [H|T]) :-
%%     power_set(P1, T),
%%     layer_elt(H, P1, P).


%% subset_y(S1, S2) :-
%%     is_set(S2),
%%     subset_y_(S1, S2).
%% subset_y_([], []).
%% subset_y_([H|T1], [H|T2]) :-
%%     subset_y_(T1, T2).
%% subset_y_(T1, [_|T2]) :-
%%     subset_y_(T1, T2).

%% %%
%% %%    Relaxing var(S1) in subset_y/2 behaves like Ross's ??
%% %%
%% %% ekzercoj:  ?- subset_y([a], [a, b, c]).
%% %% true ;
%% %% false.

%% %% ekzercoj:  ?- subset_y([a, b], [a, b, c]).
%% %% true ;
%% %% false.

%% %% ekzercoj:  ?- subset_y([a, b, c], [a, b, c]).
%% %% true ;
%% %% false.

%% %% ekzercoj:  ?- subset_y([], [a, b, c]).
%% %% true ;
%% %% false.

%% %% ekzercoj:  ?- subset_y([b], [a, b, c]).
%% %% true 

%% %% ekzercoj:  ?- subset_y([b, a], [a, b, c]).
%% %% false.

%% subset_pow(S1, S2) :-
%%     is_set(S2),
%%     power_set(P, S2),
%%     contains(P, S1).

%% contains(Ss, S1) :-
%%     member(S2, Ss),
%%     set_match(S2, S1).

%% set_match(S1, S2) :-
%%     permutations(S1, Ps),
%%     member(S2, Ps), !.

%% %% contains(S1, S2) :-
%% %%     member(S1, S2).
%% %% contains([S1|_], S2) :-
%% %%     permutations(S1, P),
%% %%     member(S2, P).
%% %% contains([_|Ss], S) :-
%% %%     contains(Ss, S).

%% permutations([], [[]]).
%% permutations(L, P) :-
%%     permutations(L, [], P).
%% permutations([], _, []).
%% permutations([H|T], L2, P) :-
%%     permutations(T, [H|L2], P1),
%%     cycle_list(H, T, L2, P1, P).

%% cycle_list(Elt, [], L2, P1, R) :-
%%     permutations(L2, P2),
%%     spread_elt(Elt, P2, P1, R).
%% cycle_list(Elt, [H|T], L2, P1, R) :-
%%     cycle_list(Elt, T, [H|L2], P1, R).

%% spread_elt(_, [], P, P).
%% spread_elt(Elt, [H|T], P, R) :-
%%     spread_elt(Elt, T, [[Elt|H]|P], R).


%% %% set_equal(S1, S2) :-
%% %%     is_set(S1),
%% %%     is_set(S2),
%% %%     set_equal(S1, S1, S2, S2).
%% %% set_equal([], _, [], _).
%% %% set_equal([A|As], S1, [B|Bs], S2) :-
%% %%     member(A, S2),
%% %%     member(B, S1),
%% %%     set_equal(As, S1, Bs, S2).


%%%
%%%    Final answer!
%%%
%%%    S1 is a subset of S2 if S2 is a set and S1 matches
%%%    (order-independent, thus permutations!)
%%%    some element of the power set of S2.
%%%
%%%    This predicate:
%%%    1. Correctly determines whether a list S1 represents a subset of S2
%%%      ekzercoj:  ?- subset([c, b], [a, b, c]).   
%%%      true ;                                     
%%%      false.                                     
%%%                                                 
%%%      ekzercoj:  ?- subset([c, b, b], [a, b, c]).
%%%      false.                                     
%%%                                                 
%%%      ekzercoj:  ?- subset([c, b, d], [a, b, c]).
%%%      false.                                     
%%%    2. Generates all subsets of S2:
%%%      ?- subset(S, [a, b, c]). 
%%%      S = [a] ;                
%%%      S = [a, c] ;             
%%%      S = [a, b, c] ;          
%%%      S = [a, b] ;             
%%%      S = [b] ;                
%%%      S = [b, c] ;             
%%%      S = [c] ;                
%%%      S = [] ;                 
%%%      false.
%%%
%%%     Both subset_f/2 and subset_x/2 above are required to accomplish the same
%%%     thing. Ross's version only satisfies what subset_x/2 can do.
%%%     
subset(S1, S2) :-
    is_set(S2),
    powerset(P, S2),
    contains(P, S1).

is_set([]).
is_set([H|T]) :-
    \+ member(H, T),
    is_set(T).

% Inconsistent! powerset(P, S) P is power set of S
% vs.           permutations(L, P) P is the set of permutations of L
powerset([[]], []).
powerset(P, [H|T]) :-
    powerset(P1, T),
    layer_elt(H, P1, P).

layer_elt(Elt, Set, Result) :-
    layer_elt(Elt, Set, Set, Result).
layer_elt(_, [], S, S).
layer_elt(Elt, [H|T], S, R) :-
    layer_elt(Elt, T, [[Elt|H]|S], R).

contains(Ss, S1) :-
    member(S2, Ss),
    set_match(S2, S1).

set_match(S1, S2) :-
    permutations(S1, Ps),
    member(S2, Ps), !.

permutations([], [[]]).
permutations(L, P) :-
    permutations(L, [], P).
permutations([], _, []).
permutations([H|T], L2, P) :-
    permutations(T, [H|L2], P1),
    cycle_list(H, T, L2, P1, P).

cycle_list(Elt, [], L2, P1, R) :-
    permutations(L2, P2),
    spread_elt(Elt, P2, P1, R).
cycle_list(Elt, [H|T], L2, P1, R) :-
    cycle_list(Elt, T, [H|L2], P1, R).

spread_elt(_, [], P, P).
spread_elt(Elt, [H|T], P, R) :-
    spread_elt(Elt, T, [[Elt|H]|P], R).
