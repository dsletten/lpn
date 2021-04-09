#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               arithmetic.pl
%
%   Started:            Fri Mar 12 20:16:35 2021
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

%%%
%%%    Add 2 numbers represented as applications of the successor predicate: 0, succ(0), succ(succ(0))
%%%    
%add(X, Y, Z) :- add(X, Y, 0, Z).
add(X, 0, X).
%add(X, 0, X) :- !.
add(X, succ(Y), succ(Z)) :- add(X, Y, Z).


%% 18 ?- add(0, 0, Z).
%% Z = 0.

%% 19 ?- add(succ(0), 0, Z).
%% Z = succ(0).

%% 20 ?- add(succ(0), succ(0), Two), add(succ(0), Two, Z).
%% Two = succ(succ(0)),
%% Z = succ(succ(succ(0))).

%% 21 ?- add(succ(0), succ(0), Two), add(Two, Two, Z).
%% Two = succ(succ(0)),
%% Z = succ(succ(succ(succ(0)))).

%% 22 ?- add(succ(0), succ(0), Two), add(Two, Two, Four).
%% Two = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))).

%% 23 ?- add(succ(0), succ(0), Two), add(Two, Two, Four), add(Four, succ(0), Five).
%% Two = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))),
%% Five = succ(succ(succ(succ(succ(0))))).

%% 24 ?- add(succ(0), succ(0), Two), add(Two, Two, Four), add(succ(0), Four, Five).
%% Two = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))),
%% Five = succ(succ(succ(succ(succ(0))))).

%% 29 ?- add(succ(0), succ(0), Two), add(Two, Two, Four), add(Two, S, Four).
%% Two = S, S = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))).

%% 30 ?- add(succ(0), succ(0), Two), add(Two, Two, Four), add(S, Two, Four).
%% Two = S, S = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))).

%% 32 ?- add(succ(0), succ(0), Two), add(Two, Two, Four), add(0, Two, T).
%% Two = T, T = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))).

%%%
%%%    Whoops?
%%%    Flipping Y and Z causes problems.
%%%    
%% subtract(X, 0, X).
%% %subtract(X, 0, X) :- !.
%% subtract(X, Y, Z) :- add(Y, Z, X).

%%
%%    With the cuts:
%%
%% 36 ?- subtract(X, succ(0), Y).
%% X = succ(0),
%% Y = 0.

%%
%%    Without cuts:
%%    

%% 38 ?- subtract(X, succ(0), Y).
%% X = succ(0),
%% Y = 0 ;
%% X = succ(succ(0)),
%% Y = succ(0) ;
%% X = succ(succ(succ(0))),
%% Y = succ(succ(0)) ;
%% X = succ(succ(succ(succ(0)))),
%% Y = succ(succ(succ(0))) 


%%%
%%%    X - Y = Z <=> X = Y + Z <=> X = Z + Y
%%%    
subtract(X, Y, Z) :- add(Z, Y, X).

%%%    Much better....
%%%    
%% 58 ?- subtract(succ(succ(0)), 0, Z).
%% Z = succ(succ(0)).

%% 59 ?- subtract(succ(succ(0)), succ(0), Z).
%% Z = succ(0).

%% 60 ?- subtract(X, succ(0), Y).
%% X = succ(Y).

%% 61 ?- One = succ(0), add(One, One, Two), add(Two, Two, Four), subtract(Four, X, Y).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Four = Y, Y = succ(succ(succ(succ(0)))),
%% X = 0 ;
%% One = X, X = succ(0),
%% Two = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))),
%% Y = succ(succ(succ(0))) ;
%% One = succ(0),
%% Two = X, X = Y, Y = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))) ;
%% One = Y, Y = succ(0),
%% Two = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))),
%% X = succ(succ(succ(0))) ;
%% One = succ(0),
%% Two = succ(succ(0)),
%% Four = X, X = succ(succ(succ(succ(0)))),
%% Y = 0 ;
%% false.

%% 62 ?- One = succ(0), add(One, One, Two), add(Two, Two, Four), subtract(X, One, Two).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))),
%% X = succ(succ(succ(0))).

%% 63 ?- One = succ(0), add(One, One, Two), add(Two, Two, Four), subtract(X, Two, One).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))),
%% X = succ(succ(succ(0))).

%% 64 ?- One = succ(0), add(One, One, Two), add(Two, Two, Four), subtract(X, Two, Two).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Four = X, X = succ(succ(succ(succ(0)))).



%multiply(X, succ(0), X).
%multiply(X, succ(0), X) :- !.
multiply(_, 0, 0).
%% multiply(X, Y, Z) :- add(X, Z1, Z),
%%                      subtract(Y, succ(0), Y1),
%%                      multiply(X, Y1, Z1).
%% multiply(X, Y, Z) :- subtract(Y, succ(0), Y1),
%%                      multiply(X, Y1, Z1),
%%                      add(X, Z1, Z).
%%%
%%%    X * Y = Z1 ^ X + Z1 = Z <=> X * (Y + 1) = XY + X = Z1 + X = Z
%%%    
multiply(X, succ(Y), Z) :-  multiply(X, Y, Z1),
                            add(X, Z1, Z).


multiply2(X, Y, Z) :- multiply2(X, Y, Z, 0).
multiply2(_, 0, P, P).
multiply2(X, succ(Y), Z, P) :- add(X, P, P1),
                               multiply2(X, Y, Z, P1).



%% 68 ?- add(succ(0), succ(0), Two), multiply(Two, Two, Four).
%% Two = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))) ;
%% false.

%% 68 ?- add(succ(0), succ(0), Two), add(Two, Two, Four), multiply(S, Two, Four).
%% Two = S, S = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))) ;
%% false.

%% 69 ?- add(succ(0), succ(0), Two), add(Two, Two, Four), multiply(Two, S, Four).
%% Two = S, S = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))) ;
%%   C-c C-cAction (h for help) ? a:
%% abort
%% % Execution Aborted
%% 70 ?- add(succ(0), succ(0), Two), add(Two, Two, Four), multiply(Two, Two, S).
%% Two = succ(succ(0)),
%% Four = S, S = succ(succ(succ(succ(0)))) ;
%% false.

%%%
%%%    From notes A-3
%%%
multiply_jia(_, 0, 0).
multiply_jia(X, succ(Y), Z1) :- add(X, Z, Z1),
                                multiply_jia(X, Y, Z).

multiply_yi(_, 0, 0).
multiply_yi(X, succ(Y), Z1) :- multiply_yi(X, Y, Z),
                               add(X, Z, Z1).

subtract_bing(X, 0, X).
subtract_bing(succ(X), succ(Y), Z) :- subtract_bing(X, Y, Z).

multiply_bing(_, 0, 0).
multiply_bing(X, succ(Y), Z1) :- subtract_bing(Z1, X, Z),
                                 multiply_bing(X, Y, Z).
