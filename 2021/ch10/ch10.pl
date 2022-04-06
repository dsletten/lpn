#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch10.pl
%
%   Started:            Wed Jul 21 11:08:48 2021
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
%%%    10.1
%%%    
p(1).
p(2) :- !.
p(3).

%%%
%%%    10.2
%%%
%% class(Number, positive) :- Number > 0.
%% class(0, zero).
%% class(Number, negative) :- Number < 0.

class(Number, positive) :- Number > 0, !.
class(0, zero) :- !.
class(Number, negative) :- Number < 0.  % The book adds a cut here too. That allows the rules to be re-ordered as necessary...

%%%
%%%    10.3
%%%
split([], [], []).
%% split([X|Xs], [X|P], N) :-
%%     X >= 0,
%%     split(Xs, P, N).
%% split([X|Xs], P, [X|N]) :-
%%     X < 0,
%%     split(Xs, P, N).
split([X|Xs], [X|P], N) :-
    class(X, positive), !,
    split(Xs, P, N).
split([X|Xs], [X|P], N) :-
    class(X, zero), !,
    split(Xs, P, N).
split([X|Xs], P, [X|N]) :-
    class(X, negative),
    split(Xs, P, N).

%%%
%%%    10.4
%%%
%% directTrain(saarbrücken, dudweiler).
%% directTrain(forbach, saarbrücken).
%% directTrain(freyming, forbach).
%% directTrain(stAvold, freyming).
%% directTrain(faulquemont, stAvold).
%% directTrain(metz, faulquemont).
%% directTrain(nancy, metz).

%%%
%%%    This one isn't actually correct...
%%%    
%% directTrain(A, B) :-
%%     directTrain(B, A), !.

%%%
%%%    Valid solutions are pruned!
%%%    
%% ?- directTrain(X, Y).
%% X = saarbrücken,
%% Y = dudweiler ;
%% X = forbach,
%% Y = saarbrücken ;
%% X = freyming,
%% Y = forbach ;
%% X = stAvold,
%% Y = freyming ;
%% X = faulquemont,
%% Y = stAvold ;
%% X = metz,
%% Y = faulquemont ;
%% X = nancy,
%% Y = metz ;
%% X = dudweiler,
%% Y = saarbrücken.

directTrain_(saarbrücken, dudweiler).
directTrain_(forbach, saarbrücken).
directTrain_(freyming, forbach).
directTrain_(stAvold, freyming).
directTrain_(faulquemont, stAvold).
directTrain_(metz, faulquemont).
directTrain_(nancy, metz).

directTrain(A, B) :-
    directTrain_(A, B).
directTrain(A, B) :-
    directTrain_(B, A).

%%%
%%%    My solution. The 3rd arg in route/4 builds the route in the correct
%%%    order from source (S) to destination (D). The 4th arg is an accumulator
%%%    to capture the path traveled so far. But it is in reverse order.
%%%
%%%    The book uses a slightly similar approach but calls route/4 with the
%%%    source/destination reversed, so the route is naturally built "backwards".
%%%    
route(S, D, R) :-
    route(S, D, R, []).

route(S, S, [S], _).
route(S, D, [S|R], R1) :-
    directTrain(S, D1),
    \+ member(D1, R1),
    route(D1, D, R, [S|R1]).

%% route(S, D, [S, D]) :- directTrain(S, D).
%% route(S, D, [S, D1|R]) :-
%%     directTrain(S, D1),
%%     directTrain(D1, D2),
%%     S \= D2,
%%     route(D2, D, R).


%%%
%%%    Practical session
%%%
%% (a)
%% nu(X, Y) :- \+ X = Y.

%% (b) ?
nu(X, Y) :-
    X = Y,
    fail.
nu(X, Y) :-
    X \= Y.

%% (c)
%% nu(X, X) :- !, fail.
%% nu(_, _).

%%%
%%%    I. Doesn't quite work. Instantiates variables.
%%%    
%% unifiable([], _, []).
%% unifiable([H|T1], Term, [H|T2]) :-
%%     H = Term,
%%     unifiable(T1, Term, T2).
%% unifiable([H|T1], Term, T2) :-
%%     H \= Term,
%%     unifiable(T1, Term, T2).

%%%
%%%    II. Works. Failed unification does not instantiate. But what about when failure fails????
%%%    
%% unifiable([], _, []).
%% unifiable([H|T1], Term, T2) :-
%%     \+ H = Term,
%%     !,
%%     unifiable(T1, Term, T2).
%% unifiable([H|T1], Term, [H|T2]) :-
%%     unifiable(T1, Term, T2).

%%%
%%%    III. Works. No cut. Same question as II.
%%%    
%% unifiable([], _, []).
%% unifiable([H|T1], Term, [H|T2]) :-
%%     \+ \+ H = Term,
%%     unifiable(T1, Term, T2).
%% unifiable([H|T1], Term, T2) :-
%%     \+ H = Term,
%%     unifiable(T1, Term, T2).

%%%
%%%    IV. Equivalent to III. Simply defining neg/1 explicitly rather than using \+/1
%%%    
%% neg(Goal) :- Goal, !, fail.
%% neg(Goal).

%% unifiable([], _, []).
%% unifiable([H|T1], Term, [H|T2]) :-
%%     neg(neg(H = Term)),
%%     unifiable(T1, Term, T2).
%% unifiable([H|T1], Term, T2) :-
%%     neg(H = Term),
%%     unifiable(T1, Term, T2).

%%%
%%%    V. Doesn't work. Instantiates as I. does!!
%%%    
unif(X, Y) :- X = Y.

unifiable([], _, []).
unifiable([H|T1], Term, [H|T2]) :-
    unif(H, Term),
    unifiable(T1, Term, T2).
unifiable([H|T1], Term, T2) :-
    \+ unif(H, Term),
    unifiable(T1, Term, T2).

%%%
%%%    Aha!
%%%    Assuming that \+/1 is defined as neg/1 above, calling Goal, e.g., X = Y
%%%    _does_ cause instantiation of the variables! But the fail/0 causes Prolog
%%%    to backtrack, which abandons the instantiation.
%%%    This can be seen by this jerry-rigged neg/1.
%%%    
neg(Goal) :- write(Goal), nl, Goal, write(Goal), nl, !, fail.
neg(Goal).


%% 121 ?- neg(X = Y).
%% _8605670=_8605672
%% _8605670=_8605670    % Instantiated
%% false.


%% 122 ?- neg(t(Y) = t(a)).
%% t(_8606340)=t(a)
%% t(a)=t(a)    % Instantiated
%% false.


%% 125 ?- neg(X = t(a)).
%% _8608482=t(a)
%% t(a)=t(a)    % Instantiated
%% false.
