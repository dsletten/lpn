#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               arith.pl
%
%   Started:            Thu Sep 27 18:47:41 2012
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

numeral(0).
numeral(succ(X)) :- numeral(X).

pred(P, succ(P)).

%%%
%%%    0 + Y = Y
%%%    X + Y = Z => (X+1) + Y = (Z+1)
%%%    
%% plus(0, Y, Y).
%% plus(succ(X), Y, succ(Z)) :- plus(X, Y, Z).

%%%
%%%    SICP ex. 1.9
%%%    X + 0 = X
%%%    X + Y = Z => X + (Y+1) = (Z+1)
%%%    
plus1(X, 0, X).
plus1(X, succ(Y), succ(Z)) :- plus1(X, Y, Z).

add1(X, 0, X) :- !.
add1(X, Y, Z) :-
    Y1 is Y - 1,
    add1(X, Y1, Z1), !,
    Z is Z1 + 1.

%%%
%%%    X + 0 = X
%%%    X + (Y-1) = Z => X + Y = (Z+1)
%%%    
plus_1(X, 0, X).
plus_1(X, Y, succ(Z)) :- pred(Y1, Y), plus_1(X, Y1, Z).

%%%
%%%    X + 0 = X
%%%    (X+1) + Y = Z => X + (Y+1) = Z
%%%    
plus2(X, 0, X).
plus2(X, succ(Y), Z) :- plus2(succ(X), Y, Z).

add2(X, 0, X) :- !.
add2(X, Y, Z) :-
    X1 is X + 1,
    Y1 is Y - 1,
    add2(X1, Y1, Z), !.

plus2a(X, Y, Sum) :-
    plus2a2(Y, Sum, X).
plus2a2(0, Sum, Sum).
plus2a2(succ(N), Sum, Acc) :-
    plus2a2(N, Sum, succ(Acc)).

add2a(X, Y, Sum) :-
    add2a2(Y, Sum, X).
add2a2(0, Sum, Sum) :- !.
add2a2(N, Sum, Acc) :-
    N1 is N - 1,
    Acc1 is Acc + 1,
    add2a2(N1, Sum, Acc1), !.

%%%
%%%    X - 0 = X
%%%    X - Y = (Z+1) => X - (Y+1) = Z
%%%    
minus1(X, 0, X).
minus1(X, succ(Y), Z) :- minus1(X, Y, succ(Z)).

%%%
%%%    X - 0 = X
%%%    X - Y = Z => (X+1) - (Y+1) = Z
%%%    
minus2(X, 0, X).
minus2(succ(X), succ(Y), Z) :- minus2(X, Y, Z).

%%%
%%%    January 2012
%%%    
%% subtract(X, X, 0).
%% subtract(X, Y, succ(Z)) :- subtract(X, succ(Y), Z).
%%
%%    This is pretty slick, but it won't work with actual arithmetic--only these Peano numbers.
%% subtract(X, Y, Z) :- add(Z, Y, X).
%%%
%%%    X - X = 0
%%%    X - (Y + 1) = Z => X - Y = (Z+1)
%%%
minus3(X, X, 0) :- !. % Infinite loop after first successful result w/o cut.
minus3(X, Y, succ(Z)) :-
    minus3(X, succ(Y), Z).

minus4(X, Y, Z) :- plus2(Z, Y, X).

%% ?- plus1(succ(0), succ(0), Two), plus1(Two, Two, Four).
%% Two = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))).

%% ?- plus1(succ(0), succ(0), Two), plus1(Two, Two, Four), minus(Four, succ(0), Three).
%% Two = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))),
%% Three = succ(succ(succ(0))) ;
%% false.

%%%
%%%    First arg unknown:
%%%    
%% ?- plus2(succ(0), succ(0), Two), plus2(Two, Two, Four), plus2(Three, succ(0), Four).
%% Two = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))),
%% Three = succ(succ(succ(0))) ;
%% false.

%%%
%%%    Second arg unknown: (Infinite loop after first result!)
%%%    
%% ?- plus2(succ(0), succ(0), Two), plus2(Two, Two, Four), plus2(succ(0), Three, Four).
%% Two = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))),
%% Three = succ(succ(succ(0))) ;
%%   C-c C-cAction (h for help) ? 

%%%
%%%    X * 0 = 0
%%%    X * 1 = X  % Unnecessary
%%%    X * Y = P => X * (Y+1) = P + X
%%%    
times1(_, 0, 0).
%times1(X, succ(0), X).
times1(X, succ(Y), P1) :-
    times1(X, Y, P),
    plus1(P, X, P1). % X typically less than P? Faster to add this way.
%%     plus1(X, P, P1).

%% ?- plus2(succ(0), succ(0), Two), plus2(Two, Two, Four), times1(Two, Four, Eight).
%% Two = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))),
%% Eight = succ(succ(succ(succ(succ(succ(succ(succ(0)))))))) ;
%% false.

%%%
%%%    Invariant: X * N + Acc = X * Y
%%%
times2(X, Y, Z) :-
    times2(X, Y, Z, 0).
times2(_, 0, P, P).
times2(X, succ(N), Prod, Acc) :-
    plus2(Acc, X, Prod1),
    times2(X, N, Prod, Prod1).

%%%
%%%    X / Y = 0, X < Y
%%%    X / Y = ((X - Y) / Y) + 1
%%%
less(0, Y, true) :- Y \= 0, !.
less(_, 0, false) :- !. % This relies on cut above!
less(succ(X), succ(Y), T) :-
    less(X, Y, T).
%divide1(X, Y, 0) :- X < Y, !. % Oops. Not using actual numbers here!
divide1(X, Y, 0) :- less(X, Y, T), T, !.
divide1(X, Y, succ(Z)) :-
    minus2(X, Y, X1),
    divide1(X1, Y, Z).
    
divide2(X, Y, Z) :-
    divide2(X, Y, Z, 0).
divide2(X, Y, Q, Q) :- less(X, Y, T), T, !.
divide2(X, Y, succ(Z), Q) :-
    minus2(X, Y, X1),
    divide2(X1, Y, Z, Q).

%% ?- plus1(X, succ(succ(0)), succ(succ(succ(0)))).
%% X = succ(0) ;
%% false.

%% ?- plus2(X, succ(succ(0)), succ(succ(succ(0)))).
%% X = succ(0) ;
%% false.

%% ?- plus2a(X, succ(succ(0)), succ(succ(succ(0)))).
%% X = succ(0).

%% ?- plus1(succ(succ(0)), X, succ(succ(succ(0)))).
%% X = succ(0) ;
%% false.

%% ?- plus2(succ(succ(0)), X, succ(succ(succ(0)))).
%% X = succ(0) ;
%% ;
%%   C-c C-cAction (h for help) ? Unknown option (h for help)
%% Action (h for help) ? a:
%% abort
%% % Execution Aborted
%% ?- plus2a(succ(succ(0)), X, succ(succ(succ(0)))).
%% X = succ(0) ;
%%   C-c C-cAction (h for help) ? a:
%% abort
%% % Execution Aborted
%% ?- plus1(succ(succ(0)), succ(succ(succ(0))), X).
%% X = succ(succ(succ(succ(succ(0))))) ;
%% false.

%% ?- plus2(succ(succ(0)), succ(succ(succ(0))), X).
%% X = succ(succ(succ(succ(succ(0))))) ;
%% false.

%% ?- plus2a(succ(succ(0)), succ(succ(succ(0))), X).
%% X = succ(succ(succ(succ(succ(0))))).

