#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               exercises.pl
%
%   Started:            Sun Aug 18 01:07:18 2019
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
%    6.1
%
doubled(L) :- append(L1, L1, L).

% ?- doubled([a, b, c, a, b, c]).
% true ;
% false.

% ?- doubled([foo, gubble, foo, gubble]).
% true ;
% false.

% ?- doubled([foo, gubble, foo]).
% false.

% ?- doubled([a, b, c|L]).         
% L = [a, b, c] ;
% L = [_59608, a, b, c, _59608] ;    <--- Error?? No! L is the tail not the full list. This would be: [a, b, c, _59608, a, b, c, _59608]
% L = [_59608, _59620, a, b, c, _59608, _59620] 

%
%    6.2
%
palindrome(P) :- reverse(P, P).


% ?- palindrome([r, o, t, a, t, o, r]).
% true.

% ?- palindrome([n, u, r, s, e, s, r, u, n]).
% true.

% ?- palindrome([n, o, t, t, h, i, s]).
% false.

%
%    6.3
%
topTail(InList, OutList) :-
    append([_], L1, InList),
    append(OutList, [_], L1).

%% 2020
toptail(In, Out) :-
    [H|_] = In,
    append([H|Out], [_], In).

% Nice!! 2010
toptail(InList, OutList) :- 
    append([_|OutList], [_], InList). 

%%    Book version (Singleton H!)
% toptail([H|TInList], OutList) :- 
%     append(OutList, [_], InList).

% ?- topTail([a], T).
% false.

% ?- topTail([a, b], T).
% T = [] ;
% false.

% ?- topTail([a, b, c], T).
% T = [b] ;
% false.

% ?- topTail([a, b, c, d], T).
% T = [b, c] ;
% false.

%
%    6.4
%
last1(L, X) :-
    reverse(L, [X|_]).

% ?- last1([a, b, c], c).
% true.

% ?- last1([a, b], c).
% false.

last2([X], X).
last2([_|T], X) :-
    last2(T, X).

last2([Elt], Elt) :- !.
last2([H|T], Elt) :-
    H \= Elt,
    last2(T, Elt).


% ?- last2([a], a).
% true.

% ?- last2([a], b).
% false.

% ?- last2([a, b, c, d], d).
% true ;
% false.

% ?- last1([a, b, c, d], d).
% true.

%
%    6.5
%
swapfl1(L1, L2) :-
    L1 = [H1|T1],
    L2 = [H2|T2],
    append(T, [H2], T1),
    append(T, [H1], T2).

% 200506 This fails to enforce match of intervening elts!
swapfl2([H1|T1], [H2|T2]) :- 
    append(_, [H2], T1),
    append(_, [H1], T2).

%%%
%%%    Book's version
%%%    
% swapfl([H1|T1], [H2|T2]) :-
%     append(Middle, [H2], T1),
%     append(Middle, [H1], T2).


% ?- swapfl1([a, b, c, d], [d, b, c, a]).
% true ;
% false.

% ?- swapfl1([a, b, c, d], [d, b, c]).
% false.

% ?- swapfl1([a, b], [b, a]).
% true ;
% false.

% ?- swapfl1([a, b, c], [c, b, a]).
% true ;
% false.

% And this fails to enforce match of intervening elts!!!
swapfl2([H1|T1], [H2|T2]) :-
    swapfl2(T1, T2, H1, H2).
swapfl2([H2], [H1], H1, H2).
swapfl2([_|T1], [_|T2], H1, H2) :-
    swapfl2(T1, T2, H1, H2).

% 200506
swapfl([H1|T1], [H2|T2]) :-
    T1 \= [],
    T2 \= [],
    swapfl(T1, T2, H1, H2).

swapfl([B], [A], A, B).  % This must be hidden. Does not make any sense if called directly by user.
swapfl([H|T1], [H|T2], A, B) :-
    swapfl(T1, T2, A, B).

%%%
%%%    Book's version
%%%    
swapflb([First, Last], [Last, First]).
swapflb([First, Next|L1], [Last, Next|L2]) :-
    swapflb([First|L1], [Last|L2]).


% ?- swapfl2([a, b, c, d], [d, b, c, a]).
% true ;
% false.

% ?- swapfl2([a, b, c, d], [d, b, c]).
% false.

% ?- swapfl2([a, b], [b, a]).
% true ;
% false.

% ?- swapfl2([a, b, c], [c, b, a]).
% true ;
% false.

%
%    6.6
% append/3, prefix/2 already defined by SWIPL
suffix(S, L) :- append(_, S, L).
sublist(SubL, L) :- suffix(S, L), prefix(SubL, S).

zebra(Street) :-
    Street = [house(color(C1), nationality(N1), pet(P1)), house(color(C2), nationality(N2), pet(P2)), house(color(C3), nationality(N3), pet(P3))],
    house(color(C1), nationality(N1), pet(P1)),
    house(color(C2), nationality(N2), pet(P2)),
    house(color(C3), nationality(N3), pet(P3)),
    color(C1),
    color(C2),
    color(C3),
    C1 \= C2, C1 \= C3, C2 \= C3,
    pet(P1),
    pet(P2),
    pet(P3),
    P1 \= P2, P1 \= P3, P2 \= P3,
    nationality(N1),
    nationality(N2),
    nationality(N3),
    N1 \= N2, N1 \= N3, N2 \= N3,
    sublist([house(color(C6), nationality(N4), pet(snail)), house(color(C5), nationality(japanese), pet(P5))], Street),
    sublist([house(color(C6), nationality(N4), pet(snail)), house(color(blue), nationality(N6), pet(P6))], Street).
    
house(color(red), nationality(english), pet(_)).
house(color(_), nationality(spanish), pet(jaguar)).
house(color(_), nationality(japanese), pet(_)).

color(red).
color(blue).
color(green).

nationality(english).
nationality(japanese).
nationality(spanish).

pet(jaguar).
pet(snail).
pet(zebra).


%%
%%    This is flatten_no_append_a in flatten.pl (2012)
%%    
flatten1(In, Out) :-
    flatten1(In, Out, []).
flatten1([], Acc, Acc).
flatten1(Elt, [Elt|Acc], Acc) :-
    Elt \= [_|_],
    Elt \= [].
flatten1([H|T], F, Acc) :-
    flatten1(T, F1, Acc),
    flatten1(H, F, F1).
