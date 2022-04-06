#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch11.pl
%
%   Started:            Thu Jul 29 11:11:29 2021
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
%%%    11.2
%%%    
q(blob, blug).
q(blob, blag).
q(blob, blig).
q(blaf, blag).
q(dang, dong).
q(dang, blug).
q(flab, blob).


%% ?- findall(X, q(blob, X), List).
%% List = [blug, blag, blig].

%% ?- findall(X, q(X, blug), List).
%% List = [blob, dang].

%% ?- findall(X, q(X, Y), List).
%% List = [blob, blob, blob, blaf, dang, dang, flab].

%% ?- bagof(X, q(X, Y), List).
%% Y = blag,
%% List = [blob, blaf] ;
%% Y = blig,
%% List = [blob] ;
%% Y = blob,
%% List = [flab] ;
%% Y = blug,
%% List = [blob, dang] ;
%% Y = dong,
%% List = [dang].

%% ?- setof(X, Y^q(X, Y), List).
%% List = [blaf, blob, dang, flab].

%%%
%%%    11.3
%%%
:- dynamic sigmares/2.

%%%
%%%    The book's version. Inconsistent with description in text.
%%%    Specifically, sigmares(1, 1) is cached when calling sigma(2, X).
%%%    
%% sigma(0, 0).
%% sigma(N, S) :-
%%     sigmares(N, S).
%% sigma(N, S) :-
%%     N > 0,
%%     \+ sigmares(N, S), % Weird... No cut above.
%%     N1 is N - 1,
%%     sigma(N1, S1),
%%     S is S1 + N,
%%     assertz(sigmares(N, S)).

sigma(N, S) :-
    sigmares(N, S), !.
sigma(1, 1) :- !. % This is only a green cut due to N > 1 goal below???
sigma(N, S) :-
    N > 1,
    N1 is N - 1,
    sigma(N1, S1),
    S is S1 + N,
    assertz(sigmares(N, S)).

proper_sigma(N, S) :-
    N > 0,
    S is N * (N + 1) / 2.

%%%
%%%    Practical Session
%%%
%%%    Obvious declarative definition. But this will not generate all subsets as the
%%%    book dictates. The problem is that whenever member/2 has the first arg uninstantiated,
%%%    it will match the first element of B.
%%%    
%subset([], _). Not quite right...
%% ?- subset([], 3).
%% true.

%% subset([], []).
%% subset([], [_|_]).
%% subset([H|T], B) :-
%%     member(H, B),
%%     subset(T, B).

%%%%%%%%%%%%%%%%%%%%%%%%
%%%    Other attempts...
%%%    
%% subset([H|T], B) :-
%%     member(H, B),
%%     subset(T, B).
%    \+ member(H, T).
%% subset([H1|T1], [H2|T2]) :-
%%     member(H1, T2),
%%     subset(T1

%% subset([], _).
%% subset([H], B) :-
%%     member(H, B).
%% subset([H|T], B) :-
%%     subset([H], B),
%%     subset(T, B).

%% subset([H|T], [H|B]) :-
%%     subset(T, B).
%% subset([H|T], [_|B]) :-
%%     member(H, B),
%%     subset(T, B).

%% subset([H], [H|_]).
%% subset([H|T], B) :-
%%     B \= [],
%%     append(L1, L2, B),
%%     (subset([H], L1); subset([H], L2)),
%%     (subset(T, L1); subset(T, L2)).

%% subset([], _).
%% subset(A, B) :-
%%     append(B1, B2, B),
%%     subst(A, B1).

%% %subst([], _).
%% subst([H|T], B) :-
%%     member(H, B),
%%     subst(T, B).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%%    Bingo!
%%%    
%% subset([H|T], B) :-
%%     subset(H, T, B, []).
%% subset(H, [], [H|_], _).
%% %% subset(H, [], [X|T1], T2) :-
%% %%     subset(H, [], T1, [X|T2]).
%% subset(H, [H1|T1], [H|T2], T3) :-
%%     subset(H1, T1, T2, [H|T3]).
%% %% subset(H, T, [X|T1], T2) :-
%% %%     append(T1, [X|T2], T3),
%% %%     subset([H|T], T3).
%% subset(H, T, [X|T1], T2) :-
%% %    T \= [],
%%     subset(H, T, T1, [X|T2]).
%% subset(H, T, [], T2) :-
%%     T \= [],
%%     subset(H, T, T2, []).

%%%
%%%    Two variants
%%%    
%% subset([H|T], B) :-
%%     subset(H, T, B, []).

%% %甲 Ok
%% subset(H, [], [H|_], _).
%% subset(H, [H1|T1], [H|T2], T3) :-
%%     subset(H1, T1, T2, [H|T3]).
%% subset(H, T, [X|T1], T2) :-
%%     subset(H, T, T1, [X|T2]).
%% %% % This clause is useless when top-level first arg is uninstantiated
%% subset(H, T, [], T2) :-
%%     T \= [],
%%     subset(H, T, T2, []).

%% ?- findall(X, subset(X, [a, b, c]), L), length(L, N).
%% L = [[], [a], [a, b], [a, b, c], [a, c], [b], [b, c], [c]],
%% N = 8.


%乙 Problems with left-recursive rule???
% Infinite loop!
% ?- subset([c, b, a], [a, b, c]).
% 
%% subset(H, [], [H|_], _).
%% subset(H, T, [X|T1], T2) :-
%%     subset(H, T, T1, [X|T2]).
%% subset(H, [H1|T1], [H|T2], T3) :-
%%     subset(H1, T1, T2, [H|T3]).
%% % This clause is useless when top-level first arg is uninstantiated
%% subset(H, T, [], T2) :-
%%     T \= [],
%%     subset(H, T, T2, []).

%% ?- findall(X, subset(X, [a, b, c]), L), length(L, N).
%% L = [[], [a], [b], [c], [b, c], [a, b], [a, c], [a, b, c]],
%% N = 8.

powerset(A, P) :-
    findall(X, subset(X, A), P).


%%%
%%%    Is this too slick?
%%%
subset([], []).
subset([], [_|_]).
subset([H|T], B) :-
    nonvar(H),
    nonvar(T),
    subset_([H|T], B).
subset([H|T], B) :-
    subset甲(H, T, B, []).

subset_([], _). % This is still needed despite first 2 subset/2 clauses...
subset_([H|T], B) :-
    member(H, B),
    subset_(T, B).

subset甲(H, [], [H|_], _).
subset甲(H, [H1|T1], [H|T2], T3) :-
    subset甲(H1, T1, T2, [H|T3]).
subset甲(H, T, [X|T1], T2) :-
    subset甲(H, T, T1, [X|T2]).
subset甲(H, T, [], T2) :-
    T \= [],
    subset甲(H, T, T2, []).

%%%
%%%    The last clause is needed to handled this. Still not quite right...
%%%
%% ?- subset([X|[b]], [a, b, c]).
%% X = a ;
%% X = c ;
%% X = a ;
%% X = c ;
%% X = a ;
%% X = c ;
%% X = a ;
%% X = c ;
%% X = a 

%%%
%%%    This is OK.
%%%    
%% ?- subset([H|T], [a, b, c]).
%% H = a,
%% T = [] ;
%% H = a,
%% T = [b] ;
%% H = a,
%% T = [b, c] ;
%% H = a,
%% T = [c] ;
%% H = b,
%% T = [] ;
%% H = b,
%% T = [c] ;
%% H = c,
%% T = [] ;
%% false.
