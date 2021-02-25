#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               exercises.pl
%
%   Started:            Sun Aug 11 21:53:24 2019
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
%    3.2
%
directlyIn(katarina, olga).
directlyIn(olga, natasha).
directlyIn(natasha, irina).

in(X, Y) :-
    directlyIn(X, Y).
in(X, Y) :-
    directlyIn(X, Z),
    in(Z, Y).

%
%    3.3
%
directTrain(saarbruecken, dudweiler).
directTrain(forbach, saarbruecken).
directTrain(freyming, forbach).
directTrain(stAvold, freyming).
directTrain(fahlquemont, stAvold).
directTrain(metz, fahlquemont).
directTrain(nancy, metz).

travelFromTo(From, To) :-
    directTrain(From, To).
travelFromTo(From, To) :-
    directTrain(From, Stop),
    travelFromTo(Stop, To).

%%%
%%%    200405
%%%    I worked through this again and tried to tackle the idea that a direct train ride should be
%%%    symmetric. The existing KB only explicitly defines 1-way routes. However, I didn't know how
%%%    to use cut properly and kept winding up with stack overflows! Turns out that ch. 10 revisits
%%%    this exercise specifically with this improvement in mind. We'll come back...
%%%
directTrain(saarbrücken, dudweiler).
directTrain(forbach, saarbrücken).
directTrain(freyming, forbach).
directTrain(stAvold, freyming).
directTrain(faulquemont, stAvold).
directTrain(metz, faulquemont).
directTrain(nancy, metz).
%directTrain(A, B) :- directTrain(B, A), !, fail. % Symmetric travel.

travelFromTo(S, D) :- directTrain(S, D).
travelFromTo(S, D) :-
    directTrain(S, D1),
    travelFromTo(D1, D).
%    travelFromTo(D1, D), !.




%
%    3.4
%
greater_than(succ(_), 0).
greater_than(succ(X), succ(Y)) :-
    greater_than(X, Y).


% ?- greater_than(succ(0), 0).
% true.

% ?- greater_than(succ(succ(0)), 0).
% true.

% ?- greater_than(succ(succ(succ(0))), succ(0)).
% true.

% ?- greater_than(X, 0).
% X = succ(_3220).

% ?- greater_than(X, Y).
% X = succ(_3654),
% Y = 0 ;
% X = succ(succ(_3662)),
% Y = succ(0) ;
% X = succ(succ(succ(_3670))),
% Y = succ(succ(0)) ;
% X = succ(succ(succ(succ(_3678)))),
% Y = succ(succ(succ(0))) ;
% X = succ(succ(succ(succ(succ(_3686))))),
% Y = succ(succ(succ(succ(0)))) ;
% X = succ(succ(succ(succ(succ(succ(_3694)))))),
% Y = succ(succ(succ(succ(succ(0))))) 

% ?- trace.
% true.

% [trace]  ?- greater_than(succ(succ(succ(succ(0)))), succ(succ(0))).
%    Call: (8) greater_than(succ(succ(succ(succ(0)))), succ(succ(0))) ? 
%    Call: (9) greater_than(succ(succ(succ(0))), succ(0)) ? 
%    Call: (10) greater_than(succ(succ(0)), 0) ? 
%    Exit: (10) greater_than(succ(succ(0)), 0) ? 
%    Exit: (9) greater_than(succ(succ(succ(0))), succ(0)) ? 
%    Exit: (8) greater_than(succ(succ(succ(succ(0)))), succ(succ(0))) ? 
% true.

% [trace]  ?- nodebug.
% true.

% ?- greater_than(0, succ(0)).
% false.

% ?- greater_than(succ(0), succ(0)).
% false.

% ?- greater_than(succ(0), succ(succ(0))).
% false.

%
%    3.5
%
swap(leaf(Label), leaf(Label)).
swap(tree(L1, R1), tree(L2, R2)) :-
    swap(L1, R2),
    swap(R1, L2).

% ?- swap(leaf(1), X).
% X = leaf(1).

% ?- swap(tree(leaf(1), leaf(2)), T).
% T = tree(leaf(2), leaf(1)).

% ?- swap(tree(tree(leaf(1), leaf(2)), leaf(4)), T).
% T = tree(leaf(4), tree(leaf(2), leaf(1))).

% ?- swap(T, tree(tree(leaf(1), leaf(2)), leaf(4))).
% T = tree(leaf(4), tree(leaf(2), leaf(1))).

% ?- swap(T, tree(leaf(1), leaf(2))).
% T = tree(leaf(2), leaf(1)).

% ?- swap(tree(tree(leaf(1), leaf(2)), tree(leaf(4), leaf(8))), T).
% T = tree(tree(leaf(8), leaf(4)), tree(leaf(2), leaf(1))).
