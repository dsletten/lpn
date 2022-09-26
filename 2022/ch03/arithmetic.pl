#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               arithmetic.pl
%
%   Started:            Mon Apr 25 02:30:02 2022
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

%:- module(arithmetic, []).

add(X, 0, X).
add(X, succ(Y), succ(Z)) :-
    add(X, Y, Z).

%% ?- add(0, 0, 0).
%% true ;
%% false.

%% ?- One = succ(0), add(0, One, One).
%% One = succ(0) ;
%% false.

%% ?- One = succ(0), add(One, 0, One).
%% One = succ(0) ;
%% false.

%% ?- One = succ(0), add(One, One, Two).
%% One = succ(0),
%% Two = succ(succ(0)) ;
%% false.

%% ?- One = succ(0), add(One, One, Two), add(One, Two, Three).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))) ;
%% false.

subtract(X, 0, X).
subtract(succ(X), succ(Y), Z) :-
    subtract(X, Y, Z).

%% ?- One = succ(0), subtract(One, 0, One).
%% One = succ(0) ;
%% false.

%% ?- subtract(0, 0, 0).
%% true.

%% ?- One = succ(0), add(One, One, Two), subtract(Two, 0, Two).
%% One = succ(0),
%% Two = succ(succ(0)) ;
%% false.

%% ?- One = succ(0), add(One, One, Two), subtract(Two, Two, 0).
%% One = succ(0),
%% Two = succ(succ(0)) ;
%% false.

%% ?- One = succ(0), add(One, One, Two), subtract(Two, One, One).
%% One = succ(0),
%% Two = succ(succ(0)) ;
%% false.

multiply(_, 0, 0).
multiply(X, succ(Y), Z) :-
    multiply(X, Y, W),
    add(X, W, Z).

%% ?- add(0, 0, One), add(One, One, Two), add(Two, One, Three), multiply(Two, Three, Six).
%% One = Two, Two = Three, Three = Six, Six = 0 ;
%% false.

%% ?- One = succ(0), add(One, One, Two), add(Two, One, Three), multiply(Two, Three, Six).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))),
%% Six = succ(succ(succ(succ(succ(succ(0)))))) ;
%% false.

%% ?- One = succ(0), add(One, One, Two), add(Two, One, Three), multiply(Two, 0, 0).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))) ;
%% false.

%% ?- One = succ(0), add(One, One, Two), add(Two, One, Three), multiply(0, Two, 0).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))) ;
%% false.

%% ?- One = succ(0), add(One, One, Two), add(Two, One, Three), multiply(One, One, One).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))) ;
%% false.

%% ?- One = succ(0), add(One, One, Two), add(Two, One, Three), multiply(One, Two, Two).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))) ;
%% false.

%% ?- One = succ(0), add(One, One, Two), add(Two, One, Three), multiply(Two, One, Two).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))) ;
%% false.

%% ?- One = succ(0), add(One, One, Two), add(Two, One, Three), add(One, Three, Four), multiply(Two, Two, Four).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))),
%% Four = succ(succ(succ(succ(0)))) ;
%% false.

less_than(0, succ(_)).
less_than(succ(X), succ(Y)) :-
    less_than(X, Y).

%% ?- One = succ(0), add(One, One, Two), add(Two, One, Three), add(One, Three, Four), less_than(0, 0).
%% false.

%% ?- One = succ(0), add(One, One, Two), add(Two, One, Three), add(One, Three, Four), less_than(One, 0).
%% false.

%% ?- One = succ(0), add(One, One, Two), add(Two, One, Three), add(One, Three, Four), less_than(0, One).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))),
%% Four = succ(succ(succ(succ(0)))) ;
%% false.

%% ?- One = succ(0), add(One, One, Two), add(Two, One, Three), add(One, Three, Four), less_than(One, One).
%% false.

%% ?- One = succ(0), add(One, One, Two), add(Two, One, Three), add(One, Three, Four), less_than(One, Two).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))),
%% Four = succ(succ(succ(succ(0)))) ;
%% false.

%% ?- One = succ(0), add(One, One, Two), add(Two, One, Three), add(One, Three, Four), less_than(One, Three).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))),
%% Four = succ(succ(succ(succ(0)))) ;
%% false.

%% ?- One = succ(0), add(One, One, Two), add(Two, One, Three), add(One, Three, Four), less_than(Three, Four).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))),
%% Four = succ(succ(succ(succ(0)))) ;
%% false.

divide(X, Y, 0) :-
    less_than(X, Y).
divide(X, Y, succ(Z)) :-
    subtract(X, Y, X1),
    divide(X1, Y, Z).

%% ?- One = succ(0), add(One, One, Two), add(Two, One, Three), add(One, Three, Four), divide(One, One, One).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))),
%% Four = succ(succ(succ(succ(0)))) ;
%% false.

%% ?- One = succ(0), add(One, One, Two), add(Two, One, Three), add(One, Three, Four), divide(Four, Two, Two).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))),
%% Four = succ(succ(succ(succ(0)))) ;
%% false.

%% ?- One = succ(0), add(One, One, Two), add(Two, One, Three), add(One, Three, Four), divide(Four, Four, One).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))),
%% Four = succ(succ(succ(succ(0)))) ;
%% false.

%% ?- One = succ(0), add(One, One, Two), add(Two, One, Three), add(One, Three, Four), divide(One, Three, Zero).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))),
%% Four = succ(succ(succ(succ(0)))),
%% Zero = 0 ;
%% false.
