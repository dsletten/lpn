#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               symmetric.pl
%
%   Started:            Thu Jul 22 15:14:47 2021
%   Modifications:
%
%   Purpose:
%   Two different ways to define a symmetric relation in Prolog.
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

r(a, b).
r(c, d).
r(h, i).

r(A, B) :- r(B, A), !. % Red cut. See below.


%% ?- r(h, X).
%% X = i ;  % 1st clause
%% X = i.   % 2nd clause

%%%
%%%    Extreme??
%%%    
r1(a, b) :- !.
r1(c, d) :- !.
r1(h, i) :- !.

r1(A, B) :- r1(B, A), !.


%% ?- r1(h, X).
%% X = i.        % Only 1st clause considered.

%%%
%%%    This is the correct way.
%%%    
p(a, b).
p(c, d).
p(h, i).

q(A, B) :- p(A, B).
q(A, B) :- p(B, A).

%%%
%%%    There are consequences for using cut!
%%%

%% ?- r(X, Y).
%% X = a,
%% Y = b ;
%% X = c,
%% Y = d ;
%% X = h,
%% Y = i ;
%% X = b,  % Rest of results discarded
%% Y = a.

%% ?- q(X, Y).
%% X = a,
%% Y = b ;
%% X = c,
%% Y = d ;
%% X = h,
%% Y = i ;
%% X = b,
%% Y = a ;
%% X = d,
%% Y = c ;
%% X = i,
%% Y = h.

%% ?- r1(X, Y).
%% X = a,
%% Y = b. % Extreme pruning!


