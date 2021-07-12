#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               infix.pl
%
%   Started:            Sun May 30 23:16:59 2021
%   Modifications:
%
%   Purpose:
%   Infix notation grammar for binary operators. Concise DS&A ch. 7
%   Nearly identical to prefix.pl!!
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
%%%    Expression must be fully-parenthesized!
%%%    
e(N, e(N)) --> n(num(N)).
%e(V, e(E1, Op, E2)) --> '(', e(V1, E1), operator(op(Op)), e(V2, E2), ')', {P =.. [Op, V1, V2], V is P}.
%e(V, e(E1, Op, E2)) --> lpar, e(V1, E1), operator(op(Op)), e(V2, E2), rpar, {P =.. [Op, V1, V2], V is P}.
e(V, e(E1, Op, E2)) --> ['('], e(V1, E1), operator(op(Op)), e(V2, E2), [')'], {P =.. [Op, V1, V2], V is P}.

n(num(N)) --> [N], {number(N)}.

lpar --> ['('].
rpar --> [')'].

operator(op(Op)) --> [Op], {lex(Op, operator)}.

lex(+, operator).
lex(-, operator).
lex(*, operator).
lex(/, operator).
%lex('%', operator). % D'oh!
lex(mod, operator).


%e(V, Tree, [+, mod, *, 2, 5, /, 6, 4, *, 2, 3], []).


%% 109 ?- e(V, Tree, [9], []).
%% V = 9,
%% Tree = e(9) 

%% 110 ?- e(V, Tree, [2, +, 3], []).
%% false.

%% 111 ?- e(V, Tree, ['(', 2, +, 3, ')'], []).
%% V = 5,
%% Tree = e(e(2), +, e(3)) 

%% 112 ?- e(V, Tree, ['(', 3, *, -6, ')'], []).
%% V = -18,
%% Tree = e(e(3), *, e(-6)) 

%% 113 ?- e(V, Tree, ['(', '(', 4, +, 5, ')', *, 9, ')'], []).
%% V = 81,
%% Tree = e(e(e(4), +, e(5)), *, e(9)) 

%% 114 ?- e(V, Tree, ['(', '(', 2, +, 8, ')', *, '(', 7, mod, 3, ')', ')'], []).
%% V = 10,
%% Tree = e(e(e(2), +, e(8)), *, e(e(7), mod, e(3))) 

%% 115 ?- e(V, Tree, ['(', '(', '(', 2, *, 3, ')', +, 5, ')', mod, 4, ')'], []).
%% V = 3,
%% Tree = e(e(e(e(2), *, e(3)), +, e(5)), mod, e(4)) 




%% 116 ?- e(V, Tree, ['(', 1, +, '(', 2, +, '(', 3, +, 4, ')', ')', ')'], []).
%% V = 10,
%% Tree = e(e(1), +, e(e(2), +, e(e(3), +, e(4)))) 

%% 117 ?- e(V, Tree, ['(', '(', '(', 1, +, 2, ')', +, 3, ')', +, 4, ')'], []).
%% V = 10,
%% Tree = e(e(e(e(1), +, e(2)), +, e(3)), +, e(4)) 




%% 118 ?- e(V, Tree, ['(', 99, -, '(', 7, *, 13, ')', ')'], []).
%% V = 8,
%% Tree = e(e(99), -, e(e(7), *, e(13))) 




%% 119 ?- e(V, Tree, ['(', 2, +, 3, ')'], []).
%% V = 5,
%% Tree = e(e(2), +, e(3)) 

%% 120 ?- e(V, Tree, ['(', '(', 1, +, 1, ')', +, 3, ')'], []).
%% V = 5,
%% Tree = e(e(e(1), +, e(1)), +, e(3)) 

%% 121 ?- e(V, Tree, ['(', '(', '(', 8, /, 8, ')', +, 1, ')', +, 3, ')'], []).
%% V = 5,
%% Tree = e(e(e(e(8), /, e(8)), +, e(1)), +, e(3)) 

%% 122 ?- e(V, Tree, ['(', '(', '(', '(', 4, *, 2, ')', /, 8, ')', +, 1, ')', +, 3, ')'], []).
%% V = 5,
%% Tree = e(e(e(e(e(4), *, e(2)), /, e(8)), +, e(1)), +, e(3)) 





%% 119 ?- e(V, Tree, ['(', 2, +, 3, ')'], []).
%% V = 5,
%% Tree = e(e(2), +, e(3)) 

%% 123 ?- e(V, Tree, ['(', 2, +, '(', 2, +, 1, ')', ')'], []).
%% V = 5,
%% Tree = e(e(2), +, e(e(2), +, e(1))) 

%% 124 ?- e(V, Tree, ['(', 2, +, '(', 2, +, '(', 8, /, 8, ')', ')', ')'], []).
%% V = 5,
%% Tree = e(e(2), +, e(e(2), +, e(e(8), /, e(8)))) 

%% 125 ?- e(V, Tree, ['(', 2, +, '(', 2, +, '(', 8, /, '(', 4, *, 2, ')', ')', ')', ')'], []).
%% V = 5,
%% Tree = e(e(2), +, e(e(2), +, e(e(8), /, e(e(4), *, e(2))))) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    Sedgewick Algorithms 4e pg. 129
%%    Must be fully parenthesized.
operator(+).
operator(-).
operator(*).
operator(/).
operator(mod).

stack_eval_infix(E, V) :-
    stack_eval_expression(E, [], [], V). % 2nd arg is operator stack, 3rd is operand stack.

stack_eval_expression([], [], [V], V).
stack_eval_expression(['('|Ts], S1, S2, V) :- % Ignore '('...
    stack_eval_expression(Ts, S1, S2, V).
stack_eval_expression([')'|Ts], S1, S2, V) :-
    stack_evaluate_op(S1, S2, S1a, S2a),
    stack_eval_expression(Ts, S1a, S2a, V).
stack_eval_expression([N|Ts], S1, S2, V) :-
    number(N),
    stack_eval_expression(Ts, S1, [N|S2], V).
stack_eval_expression([Op|Ts], S1, S2, V) :-
    operator(Op),
    stack_eval_expression(Ts, [Op|S1], S2, V).

stack_evaluate_op([Op|S1], [Op2, Op1|S2], S1, [V|S2]) :-
    P =.. [Op, Op1, Op2],
    V is P.

%% stack_eval_infix([9], 9).
%% stack_eval_infix(['(', 10, /, 5, ')'], 2).
%% stack_eval_infix(['(', 10, /, -5, ')'], -2).
%% stack_eval_infix(['(', 9, *, 8, ')'], 72).
%% stack_eval_infix(['(', 2, +, 3, ')'], 5).
%% stack_eval_infix(['(', 3, *, -6, ')'], -18).
%% stack_eval_infix(['(', '(', 4, +, 5, ')', *, 9, ')'], 81).
%% stack_eval_infix(['(', '(', 2, +, 8, ')', *, '(', 7, mod, 3, ')', ')'], 10).
%% stack_eval_infix(['(', '(', '(', 2, *, 3, ')', +, 5, ')', mod, 4, ')'], 3).
%% %   stack_eval_infix(['(', '(', '(', 2 * 5, ')' mod '(', 6 / 4, ')', ')' + '(', 2 * 3, ')', ')'], 7)
%% V = 10, stack_eval_infix(['(', 1, +, '(', 2, +, '(', 3, +, 4, ')', ')', ')'], V), stack_eval_infix(['(', '(', '(', 1, +, 2, ')', +, 3, ')', +, 4, ')'], V).
%% stack_eval_infix(['(', '(', 1,  +,  2, ')', +, 3, ')'], 6).
%% stack_eval_infix(['(', 99, -, '(', 7, *, 13, ')', ')'], 8).
%% V = 5, stack_eval_infix(['(', 2, +, 3, ')'], V), stack_eval_infix(['(', '(', 1, +, 1, ')', +, 3, ')'], V), stack_eval_infix(['(', '(', '(', 8, /, 8, ')', +, 1, ')', +, 3, ')'], V), stack_eval_infix(['(', '(', '(', '(', 4, *, 2, ')', /, 8, ')', +, 1, ')', +, 3, ')'], V).
%% V = 5, stack_eval_infix(['(', 2, +, 3, ')'], V), stack_eval_infix(['(', 2, +, '(', 2, +, 1, ')', ')'], V), stack_eval_infix(['(', 2, +, '(', 2, +, '(', 8, /, 8, ')', ')', ')'], V), stack_eval_infix(['(', 2, +, '(', 2, +, '(', 8, /, '(', 4, *, 2, ')', ')', ')', ')'], V).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%%    Recursive descent algorithm (Art of Java)
%%%    Does not require fully-parenthesized expressions.
%%%
eval_infix(Ts, V) :-
    eval_expression(Ts, V, []).

%%
%%    Input tokens [T1|Ts]
%%    Result is value V with remaining tokens Xs.
%%    
eval_expression([T1|Ts], V, Xs) :-
    eval_term(T1, Ts, V, Xs).

eval_term(T1, Ts, V, []) :-
    eval_factor(T1, Ts, V, []).
eval_term(T1, Ts, V, Xs) :-
    eval_factor(T1, Ts, Op1, [NT1|NTs]),
    eval_additive(Op1, NT1, NTs, V, Xs).

eval_additive(Op1, Op, [T1|Ts], V, []) :-
    member(Op, [+, -]),
    eval_factor(T1, Ts, Op2, []),
    P =.. [Op, Op1, Op2],
    V is P.
eval_additive(Op1, Op, [T1|Ts], V, Xs) :-
    member(Op, [+, -]), !,
    eval_factor(T1, Ts, Op2, [NT1|NTs]),
    P =.. [Op, Op1, Op2],
    V1 is P,
    eval_additive(V1, NT1, NTs, V, Xs).
eval_additive(Op1, Op, Ts, Op1, [Op|Ts]). % Push back token we shouldn't have consumed.

eval_factor(T1, Ts, V, []) :-
    eval_parenthesized(T1, Ts, V, []).
eval_factor(T1, Ts, V, Xs) :-
    eval_parenthesized(T1, Ts, Op1, [NT1|NTs]),
    eval_multiplicative(Op1, NT1, NTs, V, Xs).

eval_multiplicative(Op1, Op, [T1|Ts], V, []) :-
    member(Op, [*, /, mod]),
    eval_parenthesized(T1, Ts, Op2, []), % Can this wind up doing a lot of work before failing?! (I.e., not at the end yet--use next clause)
    P =.. [Op, Op1, Op2],
    V is P.
eval_multiplicative(Op1, Op, [T1|Ts], V, Xs) :-
    member(Op, [*, /, mod]), !,
    eval_parenthesized(T1, Ts, Op2, [NT1|NTs]),
    P =.. [Op, Op1, Op2],
    V1 is P,
    eval_multiplicative(V1, NT1, NTs, V, Xs).
eval_multiplicative(Op1, Op, Ts, Op1, [Op|Ts]). % Push back token we shouldn't have consumed.

eval_parenthesized('(', Ts, V, Xs) :-
    eval_expression(Ts, V, [')'|Xs]), !.
eval_parenthesized(T, Ts, V, Xs) :-
    eval_atom(T, Ts, V, Xs).

eval_atom(T, Ts, T, Ts) :-
    number(T).

%% eval_infix([9], 9).
%% eval_infix(['(', 9, ')'], 9). % Superfluous ()
%% eval_infix(['(', 10, /, 5, ')'], 2).
%% eval_infix([10, /, 5], 2).
%% eval_infix(['(', 10, /, -5, ')'], -2).
%% eval_infix([10, /, -5], -2).
%% eval_infix(['(', 9, *, 8, ')'], 72).
%% eval_infix([9, *, 8], 72).
%% eval_infix([2, +, 3], 5).
%% eval_infix([3, *, -6], -18).
%% eval_infix(['(', 4, +, 5, ')', *, 9], 81).
%% eval_infix(['(', '(', 2, +, 8, ')', *, '(', 7, mod, 3, ')', ')'], 10).
%% eval_infix(['(', 2, +, 8, ')', *, '(', 7, mod, 3, ')'], 10).
%% eval_infix(['(', '(', '(', 2, *, 3, ')', +, 5, ')', mod, 4, ')'], 3).
%% eval_infix(['(', 2, *, 3, +, 5, ')', mod, 4], 3).
%% %   eval_infix(['(', '(', '(', 2 * 5, ')' mod '(', 6 / 4, ')', ')' + '(', 2 * 3, ')', ')'], 7)
%% %eval_infix(['(', 2, *, 5, mod, '(', 6, /, 4, ')', ')', +, 2, *, 3], 7).
%% V = 10, eval_infix(['(', 1, +, '(', 2, +, '(', 3, +, 4, ')', ')', ')'], V), eval_infix(['(', '(', '(', 1, +, 2, ')', +, 3, ')', +, 4, ')'], V), eval_infix([1, +, '(', 2, +, '(', 3, +, 4, ')', ')'], V), eval_infix(['(', '(', 1, +, 2, ')', +, 3, ')', +, 4], V), eval_infix([1, +, 2, +, 3, +, 4], V).
%% eval_infix(['(', '(', '(', 1,  +,  2, ')', +, 3, ')', ')'], 6). % Superfluous ()
%% eval_infix([99, -, 7, *, 13], V), V is 99 - (7 * 13).
%% V = 5, eval_infix([2, +, 3], V), eval_infix(['(', 1, +, 1, ')', +, 3], V), eval_infix(['(', 8, /, 8, +, 1, ')', +, 3], V), eval_infix([4, *, 2, /, 8, +, 1, +, 3], V).
%% V = 5, eval_infix([2, +, 3], V), eval_infix([2, +, '(', 2, +, 1, ')'], V), eval_infix([2, +, '(', 2, +, 8, /, 8, ')'], V), eval_infix([2, +, '(', 2, +, 8, /, '(', 4, *, 2, ')', ')'], V).
