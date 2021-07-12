#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               postfix.pl
%
%   Started:            Sun May 30 23:17:04 2021
%   Modifications:
%
%   Purpose:
%   Postfix notation grammar for binary operators. Concise DS&A ch. 7
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
%   Notes: Problems with left-recursive rules!
%
%%

%% e(N, e(N)) --> n(num(N)).
%% %e(V, e(E1, Op, E2)) --> e(V1, E1), e(V2, E2), operator(op(Op)), {P =.. [Op, V1, V2], V is P}.

%% %e(V, e(E1, Op, E2)) --> n(num(E1)), n(num(E2)), operator(op(Op)), {P =.. [Op, E1, E2], V is P}.
%% e(V, e(E1, Op, E2)) --> e(V1, E1), n(num(E2)), operator(op(Op)), {P =.. [Op, V1, E2], V is P}.  % Must be first for greedy evaluation.
%% e(V, e(E1, Op, E2)) --> n(num(E1)), e(V2, E2), operator(op(Op)), {P =.. [Op, E1, V2], V is P}.
%% e(V, e(E1, Op, E2)) --> e(V1, E1), e(V2, E2), operator(op(Op)), {P =.. [Op, V1, V2], V is P}.

%% e(V, e(E1, Op, E2)) --> expr(V1, E1), expr(V2, E2), operator(op(Op)), {P =.. [Op, V1, V2], V is P}.

%% expr(V, expr(E)) --> e(V, E).


%%%
%%%    This works (Tree is weird...)
%%%    
%% e(V, e(N)) --> expr(V, N).
%% e(V, e(E1, Op, E2)) --> expr(V1, E1), expr(V2, E2), operator(op(Op)), {P =.. [Op, V1, V2], V is P}.

%% expr(N, expr(N)) --> n(num(N)).
%% expr(V, expr(e(N1), Op, e(N2))) --> n(num(N1)), n(num(N2)), operator(op(Op)), {P =.. [Op, N1, N2], V is P}.


%%%
%%%    This kinda works...
%%%    
%% e(N, e(N)) --> n(num(N)).
%% e(V, e(E1, Op, E2)) --> expr(V, expr(E1, Op, E2)).

%% expr(V, expr(e(E1), Op, e(E2))) --> e(V1, E1), e(V2, E2), operator(op(Op)), {P =.. [Op, V1, V2], V is P}.

%e(V) --> n(num(V)).
%% e(V) --> expr(V).

%% expr(V) --> n(num(V)).
%% expr(V) --> n(num(V1)), n(num(V2)), operator(op(Op)), {P =.. [Op, V1, V2], V is P}.
%% expr(V) --> e(V1), e(V2), operator(op(Op)), {P =.. [Op, V1, V2], V is P}.

e(V) --> expr(V).
e(V) --> expr(V1), e(V2), operator(op(Op)), {P =.. [Op, V1, V2], V is P}.

expr(V) --> n(num(V)).
%expr(V) --> expr(V1), expr(V2), operator(op(Op)), {P =.. [Op, V1, V2], V is P}.


n(num(N)) --> [N], {number(N)}.
operator(op(Op)) --> [Op], {lex(Op, operator)}.

lex(+, operator).
lex(-, operator).
lex(*, operator).
lex(/, operator).
%lex('%', operator). % D'oh!
lex(mod, operator).


%% e(V, Tree, [4, 5, +, 9, *], []).
%% e(V, Tree, [*, +, 2, 8, mod, 7, 3], []).
%% e(V, Tree, [mod, +, *, 2, 3, 5, 4], []).
%% %e(V, Tree, [+, mod, *, 2, 5, /, 6, 4, *, 2, 3], []).

%% e(V, Tree, [+, 1, +, 2, +, 3, 4], []).
%% e(V, Tree, [+, +, +, 1, 2, 3, 4], []).

%% e(V, Tree, [-, 99, *, 7, 13], []).

%% e(V, Tree, [+, 2, 3], []).
%% e(V, Tree, [+, +, 1, 1, 3], []).
%% e(V, Tree, [+, +, /, 8, 8, 1, 3], []).
%% e(V, Tree, [+, +, /, *, 4, 2, 8, 1, 3], []).

%% e(V, Tree, [+, 2, 3], []).
%% e(V, Tree, [+, 2, +, 2, 1], []).
%% e(V, Tree, [+, 2, +, 2, /, 8, 8], []).
%% e(V, Tree, [+, 2, +, 2, /, 8, *, 4, 2], []).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%%    Conventional algorithm
%%%
operator(+).
operator(-).
operator(*).
operator(/).
operator(mod).

postfix(E, V) :-
    postfix(E, [], V).

postfix([N|Ts], Ts1, V) :-
    number(N),
    postfix1(Ts, N, Ts1, V).

postfix1([], N, [], N).
postfix1([N|Ts], Op1, Ts1, V) :-
    number(N),
    postfix2(Ts, Op1, N, Ts2, V1),
    postfix1(Ts2, V1, Ts1, V).

postfix2([N|Ts], Op1, Op2, Ts1, V) :-
    number(N),
    postfix2(Ts, Op2, N, Ts2, V1),
    postfix2(Ts2, Op1, V1, Ts1, V).
postfix2([Op|Ts], Op1, Op2, Ts, V) :-
    operator(Op),
    P =.. [Op, Op1, Op2],
    V is P.

%% postfix([9], 9).
%% postfix([2, 3, +], 5).
%% postfix([3, -6, *], -18).
%% postfix([4, 5, +, 9, *], 81).
%% postfix([2, 8, +, 7, 3, mod, *], 10).
%% postfix([2, 3, *, 5, +, 4, mod], 3).
%% %% postfix([2, 5, *, 6, 4, /, mod, 2, 3, *, +], 7).

%% postfix([1, 2, 3, 4, +, +, +], 10).
%% postfix([1, 2, +, 3, +, 4, +], 10).

%% postfix([99, 7, 13, *, -], 8).

%% postfix([2, 3, +], 5).
%% postfix([1, 1, +, 3, +], 5).
%% postfix([8, 8, /, 1, +, 3, +], 5).
%% postfix([4, 2, *, 8, /, 1, +, 3, +], 5).

%% postfix([2, 3, +], 5).
%% postfix([2, 2, 1, +, +], 5).
%% postfix([2, 2, 8, 8, /, +, +], 5).
%% postfix([2, 2, 8, 4, 2, *, /, +, +], 5).
