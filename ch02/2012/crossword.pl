#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               crossword.pl
%
%   Started:            Thu Sep 20 20:37:52 2012
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
%       Why have I never commented before that this solution produces nonsense
%       crossword puzzles with duplicate words?!
%
%%

word(astante, a, s, t, a, n, t, e).
word(astoria, a, s, t, o, r, i, a).
word(baratto, b, a, r, a, t, t, o).
word(cobalto, c, o, b, a, l, t, o).
word(pistola, p, i, s, t, o, l, a).
word(statale, s, t, a, t, a, l, e).

%%%
%%%    This appears to be adequate to weed out duplicates.
%%%    What about a more general solution for uniqueness?
%%%    
crossword(V1, V2, V3, H1, H2, H3) :-
    word(V1, _, X1, _, X2, _, X3, _),
    word(V2, _, X4, _, X5, _, X6, _),
    word(V3, _, X7, _, X8, _, X9, _),
    word(H1, _, X1, _, X4, _, X7, _),
    word(H2, _, X2, _, X5, _, X8, _),
    word(H3, _, X3, _, X6, _, X9, _),
    V1 \= H1, V2 \= H2, V3 \= H3.

%% crossword(V1, V2, V3, H1, H2, H3) :-
%%     word(V1, _, X1, _, X2, _, X3, _),
%%     word(V2, _, X4, _, X5, _, X6, _),
%%     word(V3, _, X7, _, X8, _, X9, _),
%%     word(H1, _, X1, _, X4, _, X7, _),
%%     word(H2, _, X2, _, X5, _, X8, _),
%%     word(H3, _, X3, _, X6, _, X9, _).

%% crossword(V1, V2, V3, H1, H2, H3) :-
%%     word(V1, V11, H12, V13, H22, V15, H32, V17),
%%     word(V2, V21, H14, V23, H24, V25, H34, V27),
%%     word(V3, V31, H16, V33, H26, V35, H36, V37),
%%     word(H1, H11, H12, H13, H14, H15, H16, H17),
%%     word(H2, H21, H22, H23, H24, H25, H26, H27),
%%     word(H3, H31, H32, H33, H34, H35, H36, H37).

%% crossword(H1, H2, H3, V1, V2, V3) :-
%%     word(H1, H11, H12, H13, H14, H15, H16, H17),
%%     word(H2, H21, H22, H23, H24, H25, H26, H27),
%%     word(H3, H31, H32, H33, H34, H35, H36, H37),
%%     word(V1, V11, H12, V13, H22, V15, H32, V17),
%%     word(V2, V21, H14, V23, H24, V25, H34, V27),
%%     word(V3, V31, H16, V33, H26, V35, H36, V37).

%%%
%%%    D'oh!
%%%    
%% crossword(word(H1, H11, H12, H13, H14, H15, H16, H17),
%%           word(H2, H21, H22, H23, H24, H25, H26, H27),
%%           word(H3, H31, H32, H33, H34, H35, H36, H37),
%%           word(V1, V11, H12, V13, H22, V15, H32, V17),
%%           word(V2, V21, H14, V23, H24, V25, H34, V27),
%%           word(V3, V31, H16, V33, H26, V35, H36, V37)).
