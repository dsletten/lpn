#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               remove_duplicates.pl
%
%   Started:            Fri May 29 23:27:27 2020
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
member1(X, [_|T]) :-
    member1(X, T).

% delete_duplicates/2 w/o the cut...
remove_duplicates1([], []).
remove_duplicates1([H|T], S) :-
    remove_duplicates1(T, S),     % Why flipped??
    member(H, S).
remove_duplicates1([H|T], [H|S]) :-
    remove_duplicates1(T, S).

% remove_duplicates4/2 w/o the cut...
remove_duplicates2([], []).
remove_duplicates2([H|T1], T2) :- 
    member1(H, T1), 
    remove_duplicates2(T1, T2).
remove_duplicates2([H|T1], [H|T2]) :-
    remove_duplicates2(T1, T2).

remove_duplicates4([], []).
remove_duplicates4([H|T], T1) :-
    member1(H, T),
    remove_duplicates4(T, T1), !.
remove_duplicates4([H|T], [H|T1]) :-
    remove_duplicates4(T, T1).



remove_duplicates3(In, Out) :-
    remove_duplicates3(In, Out, []).

% Nonsense??
remove_duplicates3([], L, L).
remove_duplicates3([H|T1], T2, L) :- 
    remove_duplicates3(T1, T2, L), 
    member1(H, T2).
remove_duplicates3([H|T1], [H|T2], L) :- 
    remove_duplicates3(T1, T2, L).

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
