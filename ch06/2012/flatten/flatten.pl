#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               flatten.pl
%
%   Started:            Mon Mar  5 01:12:46 2012
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
%   _The Craft of Prolog_ pg. 97
%   _The Art of Prolog_ pg. 286
%

%% (defun flatten-append (l)
%%   (cond ((null l) '())
%%         ((listp (first l)) (append (flatten-append (first l)) (flatten-append (rest l))))
%%         (t (cons (first l) (flatten-append (rest l)))) ))

%% (defun flatten-append (l)
%%   (cond ((null l) '())
%%         ((null (first l)) (flatten-append (rest l)))  ; First element is empty list, NIL
%%         ((consp (first l)) (append (flatten-append (first l)) (flatten-append (rest l)))) ; First element is a CONS
%%         (t (cons (first l) (flatten-append (rest l)))) )) ; First element is a non-NIL atom, i.e., not NIL and not CONS
flatten_append([], []).
flatten_append([[]|T], L) :- flatten_append(T, L).
flatten_append([[H|T]|T1], L) :-
    flatten_append([H|T], L1),
    flatten_append(T1, L2),
    append(L1, L2, L).
flatten_append([H|T], [H|L]) :-
    H \= [],
    H \= [_|_],
    flatten_append(T, L).

list([]).
list([_|_]).

flatten_append1([], []).
flatten_append1([H|T], L) :-
    list(H),
    flatten_append1(H, L1),
    flatten_append1(T, L2),
    append(L1, L2, L).
flatten_append1([H|T], [H|L]) :-
    H \= [],
    H \= [_|_],
    flatten_append1(T, L).

%% (defun flatten-append-a (obj)
%%   (cond ((null obj) '())
%%         ((atom obj) (list obj))
%%         (t (append (flatten-append-a (car obj))
%%                    (flatten-append-a (cdr obj)))) ))
%%%
%%%    See _Art of Prolog_ pg. 165
%%%    
flatten_append_a([], []).
flatten_append_a(X, [X]) :- X \= [_|_], X \= [].
flatten_append_a([H|T], L) :-
    flatten_append_a(H, L1),
    flatten_append_a(T, L2),
    append(L1, L2, L).

%% (defun flatten-no-append (l)
%%   (labels ((flatten-aux (l result)
%%              (cond ((null l) result)
%%                    ((listp (first l)) (flatten-aux (first l) (flatten-aux (rest l) result)))
%%                    (t (cons (first l) (flatten-aux (rest l) result)))) ))
%%     (flatten-aux l '())))

%% (defun flatten-no-append (l)
%%   (labels ((flatten-aux (l result)
%%              (cond ((null l) result)
%%                    ((null (first l)) (flatten-aux (rest l) result))
%%                    ((consp (first l)) (flatten-aux (first l) (flatten-aux (rest l) result)))
%%                    (t (cons (first l) (flatten-aux (rest l) result)))) ))
%%     (flatten-aux l '())))
flatten_no_append(L1, L2) :- flatten_no_append(L1, L2, []).
flatten_no_append([], L, L).
flatten_no_append([[]|T], L, Acc) :- flatten_no_append(T, L, Acc).
flatten_no_append([[H|T]|T1], L, Acc) :-
    flatten_no_append(T1, L1, Acc),
    flatten_no_append([H|T], L, L1).
flatten_no_append([H|T], [H|L], Acc) :-
    H \= [],
    H \= [_|_],
    flatten_no_append(T, L, Acc).

flatten_no_append1(L1, L2) :- flatten_no_append1(L1, L2, []).
flatten_no_append1([], L, L).
flatten_no_append1([H|T], L, Acc) :-
    list(H),
    flatten_no_append1(T, L1, Acc),
    flatten_no_append1(H, L, L1).
flatten_no_append1([H|T], [H|L], Acc) :-
    H \= [],
    H \= [_|_],
    flatten_no_append1(T, L, Acc).

%% *flatten-6
%% (defun flatten (obj)
%%   (labels ((flatten-aux (obj results)
%%              (cond ((null obj) results)
%%                    ((atom obj) (cons obj results))
%%                    (t (flatten-aux (car obj)
%%                                    (flatten-aux (cdr obj) results)))) ))
%%     (flatten-aux obj '())))
flatten_no_append_a(L1, L2) :- flatten_no_append_a(L1, L2, []).
flatten_no_append_a([], L, L).
flatten_no_append_a(X, [X|L], L) :- X \= [_|_], X \= [].
flatten_no_append_a([H|T], L, Acc) :- flatten_no_append_a(T, L1, Acc), flatten_no_append_a(H, L, L1).

%% (defun flatten-2012 (obj)
%%   (cond ((null obj) obj) 
%%         ((null (first obj)) (flatten-2012 (rest obj)))
%%         ((atom (first obj)) (cons (first obj) (flatten-2012 (rest obj))))
%%         (t (destructuring-bind ((head . tail) . rest) obj
%%              (flatten-2012 (list* head tail rest)))) ))
flatten_hoist([], []).
flatten_hoist([[]|T], L) :-
    flatten_hoist(T, L).
flatten_hoist([H|T], [H|L]) :-
    H \= [],
    H \= [_|_],
    flatten_hoist(T, L).
flatten_hoist([[H|T]|T1], L) :-
    flatten_hoist([H, T|T1], L).

%%%
%%%    No append!
%%%    
%% flatten([], []).
%% flatten([[]|T], L) :- flatten(T, L).
%% flatten([H|T], [H|L]) :-
%%     H \= [],
%%     H \= [_|_],
%%     flatten(T, L).
%% flatten([H|T], L) :-
%%     H \= [],
%%     H = [H1|T1],
%%     flatten([H1, T1 |T], L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  This is nothing more than flatten_hoist/2 above with a useless accumulator!!!!
%%  Nothing ever happens to the 3rd argument!
%%  
% %%%
% %%%    No append and tail recursive!
% %%%    
% flattenA(In, Out) :- flattenA(In, Out, []).
% flattenA([], L, L).
% flattenA([[]|T], L, Acc) :- flattenA(T, L, Acc).
% flattenA([H|T], [H|L], Acc) :-
%     H \= [],
%     H \= [_|_],
%     flattenA(T, L, Acc).
% flattenA([H|T], L, Acc) :-
%     H \= [],       % <----- Unnecessary!!
%     H = [H1|T1],
%     flattenA([H1, T1 |T], L, Acc).

% flattenB(In, Out) :- flattenB(In, Out, []).
% flattenB([], L, L).
% flattenB([[]|T], L, Acc) :- flattenB(T, L, Acc).
% flattenB([H|T], [H|L], Acc) :-
%     H \= [],
%     H \= [_|_],
%     flattenB(T, L, Acc).
% flattenB([[H1|T1]|T], L, Acc) :-
%     flattenB([H1, T1 |T], L, Acc).



flatten_craft_wrong(T, L) :-
    flatten_craft_wrong(T, L, []).

flatten_craft_wrong([], L, L) :- !.
flatten_craft_wrong([H|T], L, L1) :- !,
    flatten_craft_wrong(H, L, L2),
    flatten_craft_wrong(T, L2, L1).
flatten_craft_wrong(X, [X|L], L).

flatten_craft_right(T, L) :-
    flatten_craft_right(T, L, []).

flatten_craft_right([], L, L1) :- !,
    L = L1.
flatten_craft_right([H|T], L, L1) :- !,
    flatten_craft_right(H, L, L2),
    flatten_craft_right(T, L2, L1).
flatten_craft_right(X, [X|L], L).

flatten_craft_better(T, L) :-
    flatten_craft_better(T, L, []).

flatten_craft_better([], L, L).
flatten_craft_better([H|T], L, L1) :-
    flatten_craft_better(H, L, L2),
    flatten_craft_better(T, L2, L1).
flatten_craft_better(X, [X|L], L) :-
    X \= [],
    X \= [_|_].


%%%
%%%    WTF?! 3 flattens and 2 appends?!
%%%    
%% flatten([], []).
%% flatten(X, [X]) :- X \= [], X \= [_|_].
%% flatten([[]|T], L) :- flatten(T, L).
%% flatten([H|T], [H|L]) :-
%%     H \= [],
%%     H \= [_|_],
%%     flatten(T, L).
%% flatten([[X|T1]|T], L) :-
%%     flatten(X, L1),
%%     flatten(T1, L2),
%%     flatten(T, L3),
%%     append(L1, L2, L4),
%%     append(L4, L3, L).

flatten_art(Xs, Ys) :- flatten_dl(Xs, Ys-[]).
flatten_dl([X|Xs], Ys-Zs) :-
    flatten_dl(X, Ys-Ys1),
    flatten_dl(Xs, Ys1-Zs).
flatten_dl(X, [X|Xs]-Xs) :-
    X \= [],
    X \= [_|_].
flatten_dl([], Xs-Xs).
