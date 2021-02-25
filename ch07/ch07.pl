#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch07.pl
%
%   Started:            Fri Mar 30 00:30:01 2012
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
%%%    7.1
%%%
s --> foo, bar, wiggle.
foo --> [choo].
foo --> foo, foo.
bar --> mar, zar.
mar --> me, my.
me --> [i].
my --> [am].
zar --> blar, car.
blar --> [a].
car --> [train].
wiggle --> [toot].
wiggle --> wiggle, wiggle.

%% blar([a|A], A).

%% my([am|A], A).

%% car([train|A], A).

%% me([i|A], A).

%% zar(A, C) :-
%% 	blar(A, B),
%% 	car(B, C).

%% mar(A, C) :-
%% 	me(A, B),
%% 	my(B, C).

%% wiggle([toot|A], A).
%% wiggle(A, C) :-
%% 	wiggle(A, B),
%% 	wiggle(B, C).

%% bar(A, C) :-
%% 	mar(A, B),
%% 	zar(B, C).

%% foo([choo|A], A).
%% foo(A, C) :-
%% 	foo(A, B),
%% 	foo(B, C).

%% s(A, D) :-
%% 	foo(A, B),
%% 	bar(B, C),
%% 	wiggle(C, D).

%%%
%%%    7.2
%%%
s --> l, r.
s --> l, s, r.
l --> [a].
r --> [b].

%% ?- s([], []).
%% false.

%% ?- s([a], []).
%% false.

%% ?- s([a, b], []).
%% true ;
%% false.

%% ?- s([a, a, b], []).
%% false.

%% ?- s([a, a, b, b], []).
%% true ;
%% false.

%% ?- s([a, a, a, b, b], []).
%% false.

%% ?- s([a, a, a, b, b, b], []).
%% true ;
%% false.

%% ?- s(X, []).
%% X = [a, b] ;
%% X = [a, a, b, b] ;
%% X = [a, a, a, b, b, b] ;
%% X = [a, a, a, a, b, b, b, b] ;
%% X = [a, a, a, a, a, b, b, b, b|...] ;

%%%
%%%    7.3
%%%
s2 --> l, r, r.
s2 --> l, s2, r, r.

%% ?- s2([], []).
%% false.

%% ?- s2([a], []).
%% false.

%% ?- s2([a, b], []).
%% false.

%% ?- s2([a, b, b], []).
%% true ;
%% false.

%% ?- s2([a, a, b, b], []).
%% false.

%% ?- s2([a, a, b, b, b], []).
%% false.

%% ?- s2([a, a, b, b, b, b], []).
%% true ;
%% false.

%% ?- s2(X, []).
%% X = [a, b, b] ;
%% X = [a, a, b, b, b, b] ;
%% X = [a, a, a, b, b, b, b, b, b] ;
%% X = [a, a, a, a, b, b, b, b, b|...] ;

%%%
%%%    Practical 1
%%%
s3 --> [].
s3 --> l, s3, l.

%% ?- s3([], []).
%% true ;
%% false.

%% ?- s3([a], []).
%% false.

%% ?- s3([a, b], []).
%% false.

%% ?- s3([a, a], []).
%% true ;
%% false.

%% ?- s3([a, a, a], []).
%% false.

%% ?- s3([a, a, a, a], []).
%% true ;
%% false.

%% ?- s3(X, []).
%% X = [] ;
%% X = [a, a] ;
%% X = [a, a, a, a] ;
%% X = [a, a, a, a, a, a] ;
%% X = [a, a, a, a, a, a, a, a] ;
%% X = [a, a, a, a, a, a, a, a, a|...] 

%%%
%%%    Practical 2
%%%
o --> l1, r2.
o --> l1, i, r2.
o --> l1, o, r2.

i --> [].
i --> l2, l2, r1, r1.
i --> l2, l2, i, r1, r1.

l1 --> [a].
l2 --> [b].
r1 --> [c].
r2 --> [d].

