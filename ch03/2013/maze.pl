#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               maze.pl
%
%   Started:            Mon Aug 12 20:21:46 2013
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

:- op(500, xfy, >>>).

connected(1, 2). 
connected(3, 4). 
connected(5, 6). 
connected(7, 8). 
connected(9, 10). 
connected(12, 13). 
connected(13, 14). 
connected(15, 16). 
connected(17, 18). 
connected(19, 20). 
connected(4, 1). 
connected(6, 3). 
connected(4, 7). 
connected(6, 11). 
connected(14, 9). 
connected(11, 15). 
connected(16, 12). 
connected(14, 17). 
connected(16, 19).

path(From, To) :- connected(From, To).
path(From, To) :-
    connected(From, X),
    path(X, To).

%% ?- path(X, X).
%% false.

%% path(From, To, go(From, To)) :-
%%     connected(From, To).
%% path(From, To, go(From, Route)) :-
%%     connected(From, X),
%%     path(X, To, Route).

path(From, To, From >>> To) :-
    connected(From, To).
path(From, To, From >>> Route) :-
    connected(From, X),
    path(X, To, Route).

%% ?- path(From, 13, R).
%% From = 12,
%% R = 12>>>13 ;
%% From = 5,
%% R = 5>>>6>>>11>>>15>>>16>>>12>>>13 ;
%% From = 15,
%% R = 15>>>16>>>12>>>13 ;
%% From = 6,
%% R = 6>>>11>>>15>>>16>>>12>>>13 ;
%% From = 11,
%% R = 11>>>15>>>16>>>12>>>13 ;
%% From = 16,
%% R = 16>>>12>>>13 ;
%% false.
