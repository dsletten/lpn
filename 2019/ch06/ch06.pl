#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch06.pl
%
%   Started:            Sun Aug 18 00:59:31 2019
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
%   Notes: See Lisp pensoj 200529 regarding differences between remove_duplicates/2 and delete_duplicates/2 below!
%
%%

append1([], L, L).
append1([H|T1], L, [H|T2]) :-
    append1(T1, L, T2).

reverse1(L, R) :-
    reverse1(L, R, []).
reverse1([], Acc, Acc).
reverse1([H|T], R, Acc) :-
    reverse1(T, R, [H|Acc]).

naiverev([], []).
naiverev([H|T], R) :-
    naiverev(T, R1),
    append1(R1, [H], R).

%rev([], []).
rev(L, R) :-
    accRev(L, R, []).
accRev([], Acc, Acc).
accRev([H|T], R, Acc) :-
    accRev(T, R, [H|Acc]).

prefix1(P, L) :-
    append1(P, _, L).

suffix1(S, L) :-
    append1(_, S, L).

sublist1(S, L) :-
    suffix1(L1, L),
    prefix1(S, L1).

sublist2(S, L) :-
    prefix1(S1, L),
    suffix1(S, S1).


member1(X, [X|_]).
member1(X, [_|T]) :-
    member1(X, T).

my_member(X, L) :- append(_, [X|_], L).

% set([], []).
% set([H|T], S) :-
%     set(T, S),     % Why flipped??
%     member(H, S).
% set([H|T], [H|S]) :-
%     set(T, S).

set([], []).
set([H|T1], T2) :- 
    member(H, T1), 
    set(T1, T2).
set([H|T1], [H|T2]) :-
    set(T1, T2).

my_set(In, Out) :-
    my_set(In, Out, []).

my_set([], L, L).
my_set([H|T1], T2, L) :- my_set(T1, T2, L), member(H, T2).
my_set([H|T1], [H|T2], L) :- my_set(T1, T2, L).

remove_duplicates([], []).
remove_duplicates([H|T], T1) :-
    member1(H, T),
    remove_duplicates(T, T1), !.
remove_duplicates([H|T], [H|T1]) :-
    remove_duplicates(T, T1).

%%%
%%%    It's the middle clause above that removes something.
%%%    Otherwise it's just this:
%%%    
duplicate([], []).
duplicate([H|T], [H|T1]) :-
    duplicate(T, T1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Prolog User's Handbook
%%
%%    Pg. 19 Maybe preserve order?...
%%    
delete_duplicates([], []).
delete_duplicates([X|List1], List2) :-
    delete_duplicates(List1, List2),
    member1(X, List2), !.
delete_duplicates([X|List1], [X|List2]) :-
    delete_duplicates(List1, List2).

delete_duplicates2([], []).
delete_duplicates2([X|List1], List3) :-
    delete_duplicates2(List1, List2),
    adjoin(X, List2, List3), !.
%% delete_duplicates2([X|List1], [X|List2]) :-
%%     delete_duplicates2(List1, List2).

%% adjoin(X, In, Out) :-
%%     adjoin(X, In, Out, In).
%% adjoin(X, [], [X|L], L).
%% adjoin(X, [X|_], Acc, Acc) :- !.
%% adjoin(X, [_|T], L, Acc) :-
%%     adjoin(X, T, L, Acc), !.

%%
%%    CLHS says: (adjoin item list :key fn)  ==  (if (member (fn item) list :key fn) list (cons item list))
%%    
adjoin(X, L, L) :-
    member(X, L), !.
adjoin(X, L, [X|L]).

%%
%%    Pg. 32 (Standard definition)
%%    
%% member(X, [X|_]).
%% member(X, [_|List]) :-
%%     member(X, List).

%%
%%    Pg. 57 No reason to preserve order...
%%    (Same as delete_duplicates/2 above)
%%    
list_to_set([], []).
list_to_set([X|List], Set) :-
    list_to_set(List, Set),
    element(X, Set), !.
list_to_set([X|List], [X|Set]) :-
    list_to_set(List, Set).

%%
%%    pg. 52 (Same as member/2)
%%    
element(X, [X|_]).
element(X, [_|Set]) :-
    element(X, Set).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
