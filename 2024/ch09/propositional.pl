#!/opt/local/bin/swipl -q -t main -f
%%  -*- Mode: Prolog -*-
%   Name:               propositional.pl
%
%   Started:            Wed Oct  2 13:03:53 2024
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

% :- module(propositional, []).

%% :- op(100, fy, not).
%% :- op(200, yfx, and).
%% :- op(300, yfx, or).
%% :- op(400, xfx, implies).

%% prop --> [p].
%% prop --> [q].
%% prop --> [r].
%% %% prop --> [not], prop.
%% %% prop --> ['('], prop, [and], prop, [')'].
%% %% prop --> ['('], prop, [or], prop, [')'].
%% %% prop --> ['('], prop, [implies], prop, [')'].
%% prop --> not prop.
%% %% prop --> {prop and prop}.
%% %% prop --> {prop or prop}.
%% %% prop --> {prop implies prop}.

%%%
%%%    Extending 2021 solution
%%%    
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

prop(P) --> variable(P).
prop(P ∨ Q) --> lpar, prop(P), ∨, prop(Q), rpar.
prop(P ∧ Q) --> lpar, prop(P), ∧, prop(Q), rpar.
prop(P → Q) --> lpar, prop(P), →, prop(Q), rpar.
prop(¬ P) --> ¬, prop(P).

lpar --> ['('].
rpar --> [')'].

∨ --> [∨].

∧ --> [∧].

→ --> [→].

¬ --> [¬].

variable(V) --> [V], {lex(V, variable)}.

lex(p, variable).
lex(q, variable).
lex(r, variable).

%% ?- prop(P, ['(', '(', p, ∧, '(', q, ∨, ¬, r, ')', ')', →, q, ')'], []), display(P).
%% →(∧(p,∨(q,'¬'(r))),q)
%% P = p∧(q∨'¬'r)→q ;
%% false.
