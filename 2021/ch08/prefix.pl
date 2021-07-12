#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               prefix.pl
%
%   Started:            Thu May 27 16:00:48 2021
%   Modifications:
%
%   Purpose:
%   Prefix notation grammar for binary operators. Concise DS&A ch. 7
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

%% e(e(N)) --> n(num(N)).
%% e(e(E1, OP, E2)) --> operator(OP), e(E1), e(E2).

%% n(num(N)) --> [N], {number(N)}.
%% operator(op(Op)) --> [Op], {lex(Op, operator)}.

e(N, e(N)) --> n(num(N)).
e(V, e(E1, Op, E2)) --> operator(op(Op)), e(V1, E1), e(V2, E2), {P =.. [Op, V1, V2], V is P}.

n(num(N)) --> [N], {number(N)}.
operator(op(Op)) --> [Op], {lex(Op, operator)}.

lex(+, operator).
lex(-, operator).
lex(*, operator).
lex(/, operator).
%lex('%', operator). % D'oh!
lex(mod, operator).


%% e(V, Tree, [9], []).
%% e(V, Tree, [+, 2, 3], []).
%% e(V, Tree, [*, 3, -6], []).
%% e(V, Tree, [*, +, 4, 5, 9], []).
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

%% 81 ?-  e(V, Tree, [9], []).
%% V = 9,
%% Tree = e(9) ;
%% false.

%% 82 ?-  e(V, Tree, [+, 2, 3], []).
%% V = 5,
%% Tree = e(e(2), +, e(3)) ;
%% false.

%% 83 ?-  e(V, Tree, [*, 3, -6], []).
%% V = -18,
%% Tree = e(e(3), *, e(-6)) 

%% 84 ?-  e(V, Tree, [*, +, 4, 5, 9], []).
%% V = 81,
%% Tree = e(e(e(4), +, e(5)), *, e(9)) 

%% 85 ?-  e(V, Tree, [*, +, 2, 8, mod, 7, 3], []).
%% V = 10,
%% Tree = e(e(e(2), +, e(8)), *, e(e(7), mod, e(3))) 

%% 86 ?-  e(V, Tree, [mod, +, *, 2, 3, 5, 4], []).
%% V = 3,
%% Tree = e(e(e(e(2), *, e(3)), +, e(5)), mod, e(4)) 

%% 87 ?- e(V, Tree, [+, mod, *, 2, 5, /, 6, 4, *, 2, 3], []).
%% ERROR: Type error: `integer' expected, found `1.5' (a float)
%% ERROR: In:
%% ERROR:   [10] _5064 is 10 mod 1.5
%% ERROR:    [9] e(_5096,e(e(...,*,...),mod,e(...,/,...)),[mod,*|...],_5102) at /home/slytobias/prolog/books/LearnPrologNow/2021/ch08/prefix.pl:33
%% ERROR:    [8] e(_5162,e(e(...,mod,...),+,_5176),[+,mod|...],[]) at /home/slytobias/prolog/books/LearnPrologNow/2021/ch08/prefix.pl:33
%% ERROR:    [7] <user>



%% 88 ?- e(V, Tree, [+, 1, +, 2, +, 3, 4], []).
%% V = 10,
%% Tree = e(e(1), +, e(e(2), +, e(e(3), +, e(4)))) 

%% 89 ?- e(V, Tree, [+, +, +, 1, 2, 3, 4], []).
%% V = 10,
%% Tree = e(e(e(e(1), +, e(2)), +, e(3)), +, e(4)) 




%% 90 ?- e(V, Tree, [-, 99, *, 7, 13], []).
%% V = 8,
%% Tree = e(e(99), -, e(e(7), *, e(13))) 

%% 91 ?- X is 99 - 7*13.
%% X = 8.



%% 93 ?- e(V, Tree, [+, 2, 3], []).

%% V = 5,
%% Tree = e(e(2), +, e(3)) 
%% 93 ?- e(V, Tree, [+, +, 1, 1, 3], []).

%% V = 5,
%% Tree = e(e(e(1), +, e(1)), +, e(3)) 
%% 94 ?- e(V, Tree, [+, +, /, 8, 8, 1, 3], []).

%% V = 5,
%% Tree = e(e(e(e(8), /, e(8)), +, e(1)), +, e(3)) 
%% 95 ?- e(V, Tree, [+, +, /, *, 4, 2, 8, 1, 3], []).

%% V = 5,
%% Tree = e(e(e(e(e(4), *, e(2)), /, e(8)), +, e(1)), +, e(3)) 



%% 96 ?- e(V, Tree, [+, 2, 3], []).

%% V = 5,
%% Tree = e(e(2), +, e(3)) 
%% 97 ?- e(V, Tree, [+, 2, +, 2, 1], []).

%% V = 5,
%% Tree = e(e(2), +, e(e(2), +, e(1))) 
%% 98 ?- e(V, Tree, [+, 2, +, 2, /, 8, 8], []).

%% V = 5,
%% Tree = e(e(2), +, e(e(2), +, e(e(8), /, e(8)))) 
%% 99 ?- e(V, Tree, [+, 2, +, 2, /, 8, *, 4, 2], []).

%% V = 5,
%% Tree = e(e(2), +, e(e(2), +, e(e(8), /, e(e(4), *, e(2))))) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%%    Conventional algorithm
%%%
operator(+).
operator(-).
operator(*).
operator(/).
operator(mod).

prefix(E, V) :-
    prefix(E, [], V).
prefix([N|Ts], Ts, N) :-
    number(N).
prefix([Op|Ts], Ts1, V) :-
    operator(Op),
    prefix(Ts, Ts2, V1),
    prefix(Ts2, Ts1, V2),
    P =.. [Op, V1, V2],
    V is P.

%% prefix([9], V).
%% prefix([+, 2, 3], V).
%% prefix([*, 3, -6], V).
%% prefix([*, +, 4, 5, 9], V).
%% prefix([*, +, 2, 8, mod, 7, 3], V).
%% prefix([mod, +, *, 2, 3, 5, 4], V).
%% %% prefix([+, mod, *, 2, 5, /, 6, 4, *, 2, 3], V).

%% prefix([+, 1, +, 2, +, 3, 4], V).
%% prefix([+, +, +, 1, 2, 3, 4], V).

%% prefix([-, 99, *, 7, 13], V).

%% prefix([+, 2, 3], V).
%% prefix([+, +, 1, 1, 3], V).
%% prefix([+, +, /, 8, 8, 1, 3], V).
%% prefix([+, +, /, *, 4, 2, 8, 1, 3], V).

%% prefix([+, 2, 3], V).
%% prefix([+, 2, +, 2, 1], V).
%% prefix([+, 2, +, 2, /, 8, 8], V).
%% prefix([+, 2, +, 2, /, 8, *, 4, 2], V).


%% ?- prefix([9], V).
%% V = 9.

%% ?- prefix([+, 2, 3], V).
%% V = 5.

%% ?- prefix([*, 3, -6], V).
%% V = -18.

%% ?- prefix([*, +, 4, 5, 9], V).
%% V = 81.

%% ?- prefix([*, +, 2, 8, mod, 7, 3], V).
%% V = 10.

%% ?- prefix([mod, +, *, 2, 3, 5, 4], V).
%% V = 3.

%% ?- prefix([+, 1, +, 2, +, 3, 4], V).
%% V = 10.

%% ?- prefix([+, +, +, 1, 2, 3, 4], V).
%% V = 10.

%% ?- prefix([-, 99, *, 7, 13], V).
%% V = 8.

%% ?- prefix([+, +, 1, 1, 3], V).
%% V = 5.

%% ?- prefix([+, +, /, 8, 8, 1, 3], V).
%% V = 5.

%% ?- prefix([+, +, /, *, 4, 2, 8, 1, 3], V).
%% V = 5.

%% ?- prefix([+, 2, +, 2, 1], V).
%% V = 5.

%% ?- prefix([+, 2, +, 2, /, 8, 8], V).
%% V = 5.

%% ?- prefix([+, 2, +, 2, /, 8, *, 4, 2], V).
%% V = 5.

