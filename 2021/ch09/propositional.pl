#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               propositional.pl
%
%   Started:            Mon Jul 12 18:17:56 2021
%   Modifications:
%
%   Purpose:
%   Update of ch. 7 version to use operators.
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
%   Epp pg. 24
%   Precedence of connectives
%   1 ¬ 
%   2 ∧, ∨
%   3 →, ↔
%
%   These look nice, but they are a pain to input!
%%

:- op(500, xfx, [→, ↔]).
:- op(400, xfx, [∧, ∨]).
:- op(200, fy, ¬).

prop --> sym.
prop --> lpar, prop, ∨, prop, rpar.
prop --> lpar, prop, ∧, prop, rpar.
prop --> lpar, prop, →, prop, rpar.
prop --> ¬, prop.

lpar --> ['('].
rpar --> [')'].

∨ --> [∨].

∧ --> [∧].

→ --> [→].

¬ --> [¬].

sym --> [p].
sym --> [q].
sym --> [r].

%%
%%    Operator doesn't help with parser!
%%

%% 218 ?- display(¬(p → q)).
%% ¬(→(p,q))
%% true.

%% 219 ?- display(¬p → q).
%% →(¬(p),q)
%% true.

%% 220 ?- display((¬p ∨ q) ∧ (¬q ∨ p)).
%% ∧(∨(¬(p),q),∨(¬(q),p))
%% true.

%% 221 ?- prop((¬p ∨ q) ∧ (¬q ∨ p), []).   % Can't use this syntax!
%% false.

%% 222 ?- prop([¬, p], []).
%% true ;
%% false.
