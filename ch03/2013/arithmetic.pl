#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               arithmetic.pl
%
%   Started:            Mon Jul 29 01:58:00 2013
%   Modifications:
%
%   Purpose:
%     Exercises with interns at Near Infinity.
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
%   - The book starts out on the wrong foot. The 2nd arg should decrease
%     towards zero in order to facilitate non-commutative operations (subtraction/division).
%   - Definitions should take care to be tail-recursive!
%
%%

%% pred(X, succ(X)).

%%%
%%%    Jeff (intern)
%%%
equals(X, X).

%% ?- equals(X, succ(X)). This is infinite loop for my version!
%% X = succ(**).

%% equals(0, 0).
%% equals(succ(X), succ(Y)) :- equals(X, Y).

%% ?- equals(succ(succ(0)), succ(succ(0))).
%% true.

%% ?- equals(succ(succ(0)), succ(0)).
%% false.

less_than(0, succ(_)).
less_than(succ(X), succ(Y)) :- less_than(X, Y).

greater_than(succ(_), 0).
greater_than(succ(X), succ(Y)) :- greater_than(X, Y).

%% ?- less_than(succ(0), succ(succ(0))).
%% true.

%% ?- less_than(succ(succ(0)), succ(succ(0))).
%% false.

%% ?- greater_than(succ(succ(0)), succ(0)).
%% true ;  ?????????????????
%% false.

%% ?- greater_than(succ(succ(0)), succ(succ(0))).
%% false.

add(X, 0, X).
add(X, succ(Y), succ(Z)) :- add(X, Y, Z).

%% ?- add(succ(0), succ(0), Two).
%% Two = succ(succ(0)) ;
%% false.

%% ?- add(succ(0), succ(0), Two), add(Two, Two, Four).
%% Two = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))) ;
%% false.

%% ?- add(succ(0), succ(0), Two), add(Two, Two, Four), add(X, Two, Four).  <---- Trace
%% Two = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))),
%% X = succ(succ(0)) ;
%% false.

%%%
%%%    Original
%%%    x - 0 = x
%%%    x - y = z => (x+1) - (y+1) = z
%%%    
%% subtract(X, 0, X).
%% subtract(succ(X), succ(Y), Z) :- subtract(X, Y, Z).

%% ?- add(succ(0), succ(0), Two), add(Two, succ(0), Three), subtract(Three, Two, One).
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))),
%% One = succ(0) ;
%% false.

%% ?- One = succ(0), add(One, One, Two), add(Two, Two, Four), subtract(Four, Three, One).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))),
%% Three = succ(succ(succ(0))) ;
%% false.

%% ?- add(succ(0), succ(0), Two), add(Two, succ(0), Three), subtract(Two, Three, One).
%% false.

%% ?- One = succ(0), add(One, One, Two), add(Two, Two, Four), subtract(Five, Four, One).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))),
%% Five = succ(succ(succ(succ(succ(0))))) ;
%% false.

%%%
%%%    Rebecca
%%%    y - y = 0
%%%    x - y = z => (x+1) - y = (z+1)
%%%
%% subtract(Y, Y, 0).
%% subtract(succ(X), Y, succ(Z)) :- subtract(X, Y, Z).

%%%
%%%    Jeff
%%%
%%%    Infinite loop after initial result: subtract(Four, Three, One). (2nd arg uninstantiated)
%%%    All others OK (i.e., 1st, 3rd arg uninstantiated--no problem.)
%%%    x - 0 = x
%%%    x - y = (z+1) => x - (y+1) = z
%%%
%% subtract(X, 0, X).
%% subtract(X, succ(Y), Z) :- subtract(X, Y, succ(Z)).

%%%
%%%    From 2012 version
%%%
%%%    x - x = 0
%%%    x - (y+1) = z => x - y = (z+1)
%%%
%%%    Infinite loop after initial result: subtract(Three, Two, One). (3rd arg uninstantiated)
%%%    Can't handle subtract(Two, Three, One) properly!
%%%    
%% subtract(X, X, 0).
%% subtract(X, Y, succ(Z)) :- subtract(X, succ(Y), Z).

%%%
%%%    This handles all of the queries above with no problems!
%%%    
%% subtract(X, Y, Z) :- add(Z, Y, X).
%%%
%%%    So does this.
%%%    
subtract(X, Y, Z) :- add(Y, Z, X).

multiply(_, 0, 0).
%%%
%%%    This is tail-recursive, but goes into infinite loop after first result.
%%%    
%% multiply(X, succ(Y), Z1) :-
%%     add(X, Z, Z1),
%%     multiply(X, Y, Z).
%% multiply(X, succ(Y), Z1) :-
%%     add(X, Z, Z1),
%%     multiply(X, Y, Z), !.
%%%
%%%    Not tail-recursive! But terminates after first result!
%%%    ?- add(succ(0), succ(0), Two), multiply(Two, Two, Four), multiply(Four, Four, Sixteen), multiply(Sixteen, Sixteen, TwoFiftySix), multiply(TwoFiftySix, TwoFiftySix, X65536), multiply(X65536, X65536, Overflow).
%%%    ERROR: Out of global stack
%%%    ?- add(succ(0), succ(0), Two), multiply(Two, Two, Four), multiply(Four, Four, Sixteen), multiply(Sixteen, Sixteen, TwoFiftySix), multiply(TwoFiftySix, TwoFiftySix, X65536), multiply(X65536, TwoFiftySix, Overflow).
%%%    ERROR: Out of global stack
%%%    
%% multiply(X, succ(Y), Z1) :-
%%     multiply(X, Y, Z),
%%     add(X, Z, Z1).
%%%
%%%    Tail-recursive and terminates!
%%%
%%%    This succeeds below but fails with the above definition:
%%%    ?- add(succ(0), succ(0), Two), multiply(Two, Two, Four), multiply(Four, Four, Sixteen), multiply(Sixteen, Sixteen, TwoFiftySix), multiply(TwoFiftySix, TwoFiftySix, X65536), multiply(X65536, Sixteen, X1048576), multiply(X1048576, Four, Overflow).
%%%
%%%    However, this fails for both:
%%%    ?- add(succ(0), succ(0), Two), multiply(Two, Two, Four), multiply(Four, Four, Sixteen), multiply(Sixteen, Sixteen, TwoFiftySix), multiply(TwoFiftySix, TwoFiftySix, X65536), multiply(X65536, Sixteen, X1048576), multiply(X1048576, Sixteen, Overflow).
%%%    [FATAL ERROR:
%%%    	   Sorry, failed to recover from global-overflow]
%%%    
%% multiply(X, succ(Y), Z) :-
%%     subtract(Z, X, Z1),
%%     multiply(X, Y, Z1).

multiply(X, succ(Y), Z1) :-
    subtract(Z1, X, Z),
    multiply(X, Y, Z).

%% ?- add(succ(0), succ(0), Two), add(Two, succ(0), Three), multiply(Two, Three, Six), multiply(Six, 0, X).
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))),
%% Six = succ(succ(succ(succ(succ(succ(0)))))),
%% X = 0 ;
%% false.

divide(X, Y, 0) :- less_than(X, Y).
%% divide(X1, Y, succ(Z)) :-
%%     subtract(X1, Y, X),
%%     divide(X, Y, Z).
%%%
%%%    Inspired by modulus/3 below.
%%%    
divide(X, Y, succ(Z)) :-
    subtract(X, Y, X1),
    divide(X1, Y, Z).
%%%
%%%    This works initially, but goes into infinite loop if second result is requested (;).
%% divide(X1, Y, succ(Z)) :-
%%     divide(X, Y, Z),
%%     add(X, Y, X1).

%%%
%%%    This works the same as the subtract version above.
%%%    
%% divide(X1, Y, succ(Z)) :-
%%     add(X, Y, X1),
%%     divide(X, Y, Z).

%% ?- add(succ(0), succ(0), Two), add(Two, succ(0), Three), multiply(Two, Two, Four), multiply(Three, Four, Twelve), divide(Twelve, Two, Six).
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))),
%% Four = succ(succ(succ(succ(0)))),
%% Twelve = succ(succ(succ(succ(succ(succ(succ(succ(succ(succ(...)))))))))),
%% Six = succ(succ(succ(succ(succ(succ(0)))))) ;
%% false.


%% ?- add(succ(0), succ(0), Two), add(Two, succ(0), Three), multiply(Two, Two, Four), multiply(Three, Four, Twelve), divide(Twelve, X, Three).
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))),
%% Four = succ(succ(succ(succ(0)))),
%% Twelve = succ(succ(succ(succ(succ(succ(succ(succ(succ(succ(...)))))))))),
%% X = succ(succ(succ(succ(0)))) ;
%% false.

%%%
%%%    Why 4 answers?
%%%    
%% ?- add(succ(0), succ(0), Two), add(Two, succ(0), Three), multiply(Two, Two, Four), multiply(Three, Four, Twelve), divide(X, Four, Three).
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))),
%% Four = succ(succ(succ(succ(0)))),
%% Twelve = succ(succ(succ(succ(succ(succ(succ(succ(succ(succ(...)))))))))),
%% X = succ(succ(succ(succ(succ(succ(succ(succ(succ(succ(...)))))))))) ;
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))),
%% Four = succ(succ(succ(succ(0)))),
%% Twelve = succ(succ(succ(succ(succ(succ(succ(succ(succ(succ(...)))))))))),
%% X = succ(succ(succ(succ(succ(succ(succ(succ(succ(succ(...)))))))))) ;
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))),
%% Four = succ(succ(succ(succ(0)))),
%% Twelve = succ(succ(succ(succ(succ(succ(succ(succ(succ(succ(...)))))))))),
%% X = succ(succ(succ(succ(succ(succ(succ(succ(succ(succ(...)))))))))) ;
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))),
%% Four = succ(succ(succ(succ(0)))),
%% Twelve = succ(succ(succ(succ(succ(succ(succ(succ(succ(succ(...)))))))))),
%% X = succ(succ(succ(succ(succ(succ(succ(succ(succ(succ(...)))))))))) ;
%% false.

modulus(X, Y, X) :- less_than(X, Y).
modulus(X, Y, Z) :-
    subtract(X, Y, X1),
    modulus(X1, Y, Z).

%% ?- add(succ(0), succ(0), Two), add(Two, succ(0), Three), multiply(Two, Two, Four), modulus(Four, Three, X).
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))),
%% Four = succ(succ(succ(succ(0)))),
%% X = succ(0) ;
%% false.

%% ?- add(succ(0), succ(0), Two), add(Two, succ(0), Three), multiply(Two, Two, Four), modulus(Three, Four, X).
%% Two = succ(succ(0)),
%% Three = succ(succ(succ(0))),
%% Four = succ(succ(succ(succ(0)))),
%% X = succ(succ(succ(0))) ;
%% false.

even(X) :- modulus(X, succ(succ(0)), 0).
odd(X) :- modulus(X, succ(succ(0)), succ(0)).

%% ?- even(succ(succ(0))).
%% true ;
%% false.

%% ?- odd(succ(succ(0))).
%% false.

%% ?- odd(succ(0)).
%% true ;
%% false.

%% ?- even(succ(0)).
%% false.

%% ?- even(0).
%% true ;
%% false.

%% ?- odd(0).
%% false.
