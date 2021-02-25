#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               arithmetic.pl
%
%   Started:            Sun Jan 19 22:00:23 2020
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
%   Notes: See notes A-8 through A-10
%
%%

%%
%%    Book's version (No connection to numeral/1 defined earlier!)
%%
%%    1. 0 + y = y
%%    2. x + y = z => (x+1) + y = (z+1)
%%    
%% add(0, Y, Y).
%% add(succ(X), Y, succ(Z)) :-
%%     add(X, Y, Z).

%%
%%    Alternatively
%%    
%%    1. x + 0 = x
%%    2. x + y = z => x + (y+1) = (z+1)
%%    
add(X, 0, X).
add(X, succ(Y), succ(Z)) :-
    add(X, Y, Z).

%%
%%    1. x - 0 = x
%%    2. x - y = z => (x+1) - (y+1) = z
%%    
subtract(X, 0, X).
subtract(succ(X), succ(Y), Z) :-
    subtract(X, Y, Z).

%% ?- add(One, One, succ(succ(0))).
%% One = succ(0) ;
%% false.

%% ?- One = succ(0), add(One, One, Two), add(X, Y, Two).
%% One = succ(0),
%% Two = X, X = succ(succ(0)),
%% Y = 0 ;
%% One = X, X = Y, Y = succ(0),
%% Two = succ(succ(0)) ;
%% One = succ(0),
%% Two = Y, Y = succ(succ(0)),
%% X = 0 ;
%% false.

%% ?- One = succ(0), add(One, One, Two), add(Two, Two, Four), subtract(Four, One, Three).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))),
%% Three = succ(succ(succ(0))) ;
%% false.

%% ?- One = succ(0), add(One, One, Two), add(Two, Two, Four), subtract(Four, Three, One).
%% One = succ(0),
%% Two = succ(succ(0)),
%% Four = succ(succ(succ(succ(0)))),
%% Three = succ(succ(succ(0))) ;
%% false.


%%
%%    Book's version
%%    x + y = z => (x+1) + y = (z+1)
%%    
add1(0, Y, Y).
add1(succ(X), Y, succ(Z)) :-    % I.e., 1st term is not zero. Let's try again by reducing it (and 3rd term).
    add1(X, Y, Z).

%%
%%    My first
%%    x + y = z => x + (y+1) = (z+1)
%%    
add2(X, 0, X).
add2(X, succ(Y), succ(Z)) :-
    add2(X, Y, Z).

%%
%%    My variation
%%    (x+1) + y = z => x + (y+1) = z
%%    
add3(X, 0, X).
add3(X, succ(Y), Z) :-        % I.e., 2nd term is not zero. Try again by reducing it and compensating by increasing 1st term.
    add3(succ(X), Y, Z).

%%
%%    Book variation
%%    x + (y+1) = z => (x+1) + y = z
%%    
add4(0, Y, Y).
add4(succ(X), Y, Z) :-
    add4(X, succ(Y), Z).

%%%
%%%    Versions 1,2 both strip off a layer of succ/1 when the body replaces head as a goal. Both one addend and sum reduced.
%%%    Versions 3,4 strip off one layer while adding another to compensate. Each addend is changed.
%%%
%%%    All 4 are correct and declaratively equivalent. However, 3 and 4 do not terminate naturally after providing an initially
%%%    correct response.
%%%    

Simple cases:
add(Two, succ(succ(succ(0))), succ(succ(succ(succ(succ(0)))))). % 4 blows up on backtrack
add(succ(succ(succ(0))), Two, succ(succ(succ(succ(succ(0)))))). % 3 blows up...
add(succ(succ(0)), succ(succ(succ(0))), Five). % Nobody blows up

More complex cases:


Completely unconstrained:
add(X, Y, Z). % 1,4 and 2,3 behave the same here.



add1(One, One, succ(succ(0))).
add1(Two, Two, succ(succ(succ(succ(0))))).
One = succ(0), add1(One, One, Two), add1(X, Y, Two).
add1(succ(succ(succ(0))), One, succ(succ(succ(succ(0))))).
add1(One, succ(succ(succ(0))), succ(succ(succ(succ(0))))).
One = succ(0), add1(One, One, Two), add1(Two, Two, Four).
add1(succ(0), succ(0), Two), add1(Two, Two, Four).

add2(One, One, succ(succ(0))).
add2(Two, Two, succ(succ(succ(succ(0))))).
One = succ(0), add2(One, One, Two), add2(X, Y, Two).
add2(succ(succ(succ(0))), One, succ(succ(succ(succ(0))))).
add2(One, succ(succ(succ(0))), succ(succ(succ(succ(0))))).
One = succ(0), add2(One, One, Two), add2(Two, Two, Four).
add2(succ(0), succ(0), Two), add2(Two, Two, Four).

%%
%%    All succeed but stack overflow on backtrack.
%%    
add3(One, One, succ(succ(0))).
add3(Two, Two, succ(succ(succ(succ(0))))).
One = succ(0), add3(One, One, Two), add3(X, Y, Two).
add3(succ(succ(succ(0))), One, succ(succ(succ(succ(0))))).
add3(One, succ(succ(succ(0))), succ(succ(succ(succ(0))))).
One = succ(0), add3(One, One, Two), add3(Two, Two, Four).
add3(succ(0), succ(0), Two), add3(Two, Two, Four).

%%
%%    Same as add3/2
%%    
add4(One, One, succ(succ(0))).
add4(Two, Two, succ(succ(succ(succ(0))))).
One = succ(0), add4(One, One, Two), add4(X, Y, Two).
add4(succ(succ(succ(0))), One, succ(succ(succ(succ(0))))).
add4(One, succ(succ(succ(0))), succ(succ(succ(succ(0))))).
One = succ(0), add4(One, One, Two), add4(Two, Two, Four).
add4(succ(0), succ(0), Two), add4(Two, Two, Four).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    Subtraction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%    Since subtraction is not commutative, there are half as many options as with addition.
%%    The second argument (subtrahend) must progress towards the base case 0.
%%    

%%
%%    x - y = z => (x-1) - (y-1) = z
%%   ((x-1) - (y-1) = z => x - y = z)
%%   (x - y = z => (x+1) - (y+1) = z)
%%   
sub1(X, 0, X).
sub1(succ(X), succ(Y), Z) :-
    sub1(X, Y, Z).

%%
%%    x - y = z => (x - (y-1)) - 1 = z
%%   (x - y = z+1 => x - (y+1) = z)
sub2(X, 0, X).
sub2(X, succ(Y), Z) :-
    sub(X, Y, succ(Z)).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    Multiplication
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%    With addition, there is a possible symmetry in incrementing one addend while decrementing the other.
%%    But there is no such corresponding relationship between the factors in multiplication. (?)
%%    Consequently, there is only one definition with 2 variants due to commutativity.
%%
%%    Addition is defined in terms of the primitive operations of increment/decrement.
%%    Multiplication is defined in terms of addition.
%%

%%
%%    xy = z => x(y-1) + x = z
%%    xy = z => x(y+1) = z + x
%%
mult1(_, 0, 0). % ?
mult1(X, 1, X).
mult1(X, succ(Y), Z1) :-
    mult1(X, Y, Z),
    add(Z, X, Z1).

%%
%%    xy = z => (x-1)y + y = z
%%    xy = z => (x+1)y = z + y
%%
mult2(X, 1, X).
mult2(succ(X), Y, Z1) :-
    mult2(X, Y, Z),
    add(Z, Y, Z1).
