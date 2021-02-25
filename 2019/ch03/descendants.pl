#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               descendants.pl
%
%   Started:            Sun Jul 28 01:04:04 2019
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

child(anne, bridget).
child(bridget, caroline).
child(caroline, donna).
child(donna, emily).

%
%    There are 8 variants of this relation corresponding to the 2 possible ways to organize the
%    following 3 issues:
%    1. a. Direct child/recursive descendant:
%          X -> Z -> ... -> Y
%       b. Recursive descendant/child:
%          X -> ... -> Z -> Y
%    2. a. Base clause first
%       b. Recursive clause first
%    3. a. Base goal first
%       b. Recursive goal first
%
%    All of the XaX predicates naturally return the 4 base cases first: a->b, b->c, c->d, d->e
%    Likewise, these are the last 4 results returned by the XbX predicates (Only 2 of which return
%    anything. abb and bbb simply overflow the stack...)
%
%    The book points out that the XXb definitions should fail due to their left recursive rules.
%    Furthermore, criterion 2. should have no impact (except in cases that otherwise fail to terminate).
%    Criterion 1. makes no difference whatsoever.
%
%    In other words:
%      - aaa (baa) is legit.
%      - aba (bba) is a little sketchy since base clause is not first.
%      - aab (bab) is jacked up
%      - abb (bbb) is garbage

descend_aaa(X, Y) :-
    child(X, Y).
descend_aaa(X, Y) :-
    child(X, Z),
    descend_aaa(Z, Y).

descend_aba(X, Y) :-
    child(X, Z),
    descend_aba(Z, Y).
descend_aba(X, Y) :-
    child(X, Y).

% Correct results -> Stack overflow
descend_aab(X, Y) :-
    child(X, Y).
descend_aab(X, Y) :-
    descend_aab(Z, Y),
    child(X, Z).

% Complete failure
descend_abb(X, Y) :-
    descend_abb(Z, Y),
    child(X, Z).
descend_abb(X, Y) :-
    child(X, Y).

descend_baa(X, Y) :-
    child(X, Y).
descend_baa(X, Y) :-
    child(Z, Y),         % In a way, this looks backwards since we are trying to find the descendant of X but immediately focus on the bottom of the tree.
    descend_baa(X, Z).   % But flipping the goals and focusing on X first is what breaks bab!

descend_bba(X, Y) :-
    child(Z, Y),
    descend_bba(X, Z).
descend_bba(X, Y) :-
    child(X, Y).

% Correct results -> Stack overflow
descend_bab(X, Y) :-
    child(X, Y).
descend_bab(X, Y) :-
    descend_bab(X, Z),
    child(Z, Y).

% Complete failure
descend_bbb(X, Y) :-
    descend_bbb(X, Z),
    child(Z, Y).
descend_bbb(X, Y) :-
    child(X, Y).

%
%    Exercise 3.1
%
descend_xxx(X, Y) :-
    child(X, Y).
descend_xxx(X, Y) :-
    descend_xxx(X, Z),
    descend_xxx(Z, Y).

%%%    At first glance, the above looks like it just might work--as though it simply requires an additional
%%%    layer of processing to get from descend_xxx(X, Z) -> child(X, Z) (Compared to aaa). However, this
%%%    is wrong. In aaa child(X, Z) is a conjunct in the recursive clause. When it fails, it stops evaluation
%%%    of the 2nd recursive goal, descend(Z, Y). So for a given candidate parent X, if there is no fact child(X, Y)
%%%    the query fails. But xxx lacks this gatekeeper, so if X has no child, the query simply dives deeper and
%%%    deeper recursively.
%%%    I encountered this in the query descend_xxx(X, Y). After successfully finding the pairs a/b, b/c, c/d, d/e, a/c, a/d, a/e,
%%%    the search then nosedived trying to satisfy descend_xxx(emily, Y). emily is in the knowledge base but not as a parent.
%%%    Thus, stack overflow... The book raises an alternative example descend(rose, Y) for a person not even in the KB.
%%%    Of course they would have no child either.

% ?- descend_aaa(X, Y).
% X = anne,
% Y = bridget ;
% X = bridget,
% Y = caroline ;
% X = caroline,
% Y = donna ;
% X = donna,
% Y = emily ;
% X = anne,
% Y = caroline ;
% X = anne,
% Y = donna ;
% X = anne,
% Y = emily ;
% X = bridget,
% Y = donna ;
% X = bridget,
% Y = emily ;
% X = caroline,
% Y = emily ;
% false.

% ?- descend_aba(X, Y).
% X = anne,
% Y = emily ;
% X = anne,
% Y = donna ;
% X = anne,
% Y = caroline ;
% X = bridget,
% Y = emily ;
% X = bridget,
% Y = donna ;
% X = caroline,
% Y = emily ;
% X = anne,
% Y = bridget ;
% X = bridget,
% Y = caroline ;
% X = caroline,
% Y = donna ;
% X = donna,
% Y = emily.

% ?- descend_aab(X, Y).
% X = anne,
% Y = bridget ;
% X = bridget,
% Y = caroline ;
% X = caroline,
% Y = donna ;
% X = donna,
% Y = emily ;
% X = anne,
% Y = caroline ;
% X = bridget,
% Y = donna ;
% X = caroline,
% Y = emily ;
% X = anne,
% Y = donna ;
% X = bridget,
% Y = emily ;
% X = anne,
% Y = emily ;
% ERROR: Stack limit (1.0Gb) exceeded
% ERROR:   Stack sizes: local: 1.0Gb, global: 12Kb, trail: 0Kb
% ERROR:   Stack depth: 12,197,642, last-call: 0%, Choice points: 5
% ERROR:   In:
% ERROR:     [12,197,642] user:child(_3262, bridget)
% ERROR:     [12,197,641] user:descend_aab(_3282, caroline)
% ERROR:     [12,197,640] user:descend_aab(_3302, caroline)
% ERROR:     [12,197,639] user:descend_aab(_3322, caroline)
% ERROR:     [12,197,638] user:descend_aab(_3342, caroline)
% ERROR: 
% ERROR: Use the --stack_limit=size[KMG] command line option or
% ERROR: ?- set_prolog_flag(stack_limit, 2_147_483_648). to double the limit.
% ?- descend_abb(X, Y).
% ERROR: Stack limit (1.0Gb) exceeded
% ERROR:   Stack sizes: local: 1.0Gb, global: 15Kb, trail: 0Kb
% ERROR:   Stack depth: 6,708,658, last-call: 0%, Choice points: 6,708,653
% ERROR:   Probable infinite recursion (cycle):
% ERROR:     [6,708,658] user:descend_abb(_4134, _4136)
% ERROR:     [6,708,657] user:descend_abb(_4154, _4156)
%    Exception: (6,705,776) descend_abb(_4184, _3828) ? nodebug.
% ?- descend_baa(X, Y).
% X = anne,
% Y = bridget ;
% X = bridget,
% Y = caroline ;
% X = caroline,
% Y = donna ;
% X = donna,
% Y = emily ;
% X = anne,
% Y = caroline ;
% X = bridget,
% Y = donna ;
% X = anne,
% Y = donna ;
% X = caroline,
% Y = emily ;
% X = bridget,
% Y = emily ;
% X = anne,
% Y = emily ;
% false.

% ?- descend_bba(X, Y).
% X = anne,
% Y = caroline ;
% X = anne,
% Y = donna ;
% X = bridget,
% Y = donna ;
% X = anne,
% Y = emily ;
% X = bridget,
% Y = emily ;
% X = caroline,
% Y = emily ;
% X = anne,
% Y = bridget ;
% X = bridget,
% Y = caroline ;
% X = caroline,
% Y = donna ;
% X = donna,
% Y = emily.

% ?- descend_bab(X, Y).
% X = anne,
% Y = bridget ;
% X = bridget,
% Y = caroline ;
% X = caroline,
% Y = donna ;
% X = donna,
% Y = emily ;
% X = anne,
% Y = caroline ;
% X = bridget,
% Y = donna ;
% X = caroline,
% Y = emily ;
% X = anne,
% Y = donna ;
% X = bridget,
% Y = emily ;
% X = anne,
% Y = emily ;
% ERROR: Stack limit (1.0Gb) exceeded
% ERROR:   Stack sizes: local: 1.0Gb, global: 22Kb, trail: 0Kb
% ERROR:   Stack depth: 12,197,410, last-call: 0%, Choice points: 5
% ERROR:   Probable infinite recursion (cycle):
% ERROR:     [12,197,409] user:descend_bab(anne, _5768)
% ERROR:     [12,197,408] user:descend_bab(anne, _5788)
% ?- descend_bbb(X, Y).
% ERROR: Stack limit (1.0Gb) exceeded
% ERROR:   Stack sizes: local: 1.0Gb, global: 25Kb, trail: 0Kb
% ERROR:   Stack depth: 6,708,530, last-call: 0%, Choice points: 6,708,525
% ERROR:   Probable infinite recursion (cycle):
% ERROR:     [6,708,530] user:descend_bbb(_6578, _6580)
% ERROR:     [6,708,529] user:descend_bbb(_6598, _6600)
%    Exception: (6,705,715) descend_bbb(_6270, _6630) ? nodebug.

% ?- descend_xxx(X, Y).
% X = anne,
% Y = bridget ;
% X = bridget,
% Y = caroline ;
% X = caroline,
% Y = donna ;
% X = donna,
% Y = emily ;
% X = anne,
% Y = caroline ;
% X = anne,
% Y = donna ;
% X = anne,
% Y = emily ;
% ERROR: Stack limit (1.0Gb) exceeded
% ERROR:   Stack sizes: local: 1.0Gb, global: 23Kb, trail: 0Kb
% ERROR:   Stack depth: 12,197,358, last-call: 0%, Choice points: 8
% ERROR:   Probable infinite recursion (cycle):
% ERROR:     [12,197,358] user:descend_xxx(emily, _6148)
% ERROR:     [12,197,357] user:descend_xxx(emily, _6168)





%%%%%%%%%%%%%%%% Older -- less systematic

%    Depth first search
%    
%    X -> Z -> ... -> Y
%    
descend1(X, Y) :-
    child(X, Y).
descend1(X, Y) :-
    child(X, Z),
    descend1(Z, Y).

%
%    Reverse depth first search
%    
descend2(X, Y) :-
    child(X, Z),
    descend2(Z, Y).
descend2(X, Y) :-
    child(X, Y).

%
%    Stack overflow
%    
descend3(X, Y) :-
    descend3(Z, Y),
    child(X, Z).
descend3(X, Y) :-
    child(X, Y).

descend4(X, Y) :-
    child(X, Y).
descend4(X, Y) :-
    descend4(Z, Y),
    child(X, Z).

%
%
%
%    X -> ... -> Z -> Y
%    
descend5(X, Y) :-
    child(X, Y).
descend5(X, Y) :-
    child(Z, Y),
    descend5(X, Z).

descend5a(X, Y) :-
    child(X, Y).
descend5a(X, Y) :-
    descend5a(X, Z),
    child(Z, Y).

descend6(X, Y) :-
    child(Z, Y),
    descend6(X, Z).
descend6(X, Y) :-
    child(X, Y).


% ?- descend1(X, Y).
% X = anne,
% Y = bridget ;
% X = bridget,
% Y = caroline ;
% X = caroline,
% Y = donna ;
% X = donna,
% Y = emily ;
% X = anne,
% Y = caroline ;
% X = anne,
% Y = donna ;
% X = anne,
% Y = emily ;
% X = bridget,
% Y = donna ;
% X = bridget,
% Y = emily ;
% X = caroline,
% Y = emily ;
% false.

% ?- descend2(X, Y).
% X = anne,
% Y = emily ;
% X = anne,
% Y = donna ;
% X = anne,
% Y = caroline ;
% X = bridget,
% Y = emily ;
% X = bridget,
% Y = donna ;
% X = caroline,
% Y = emily ;
% X = anne,
% Y = bridget ;
% X = bridget,
% Y = caroline ;
% X = caroline,
% Y = donna ;
% X = donna,
% Y = emily.

% ?- descend3(X, Y).
% ERROR: Stack limit (1.0Gb) exceeded
% ERROR:   Stack sizes: local: 1.0Gb, global: 19Kb, trail: 0Kb
% ERROR:   Stack depth: 6,708,607, last-call: 0%, Choice points: 6,708,602
% ERROR:   Probable infinite recursion (cycle):
% ERROR:     [6,708,607] user:descend3(_5166, _5168)
% ERROR:     [6,708,606] user:descend3(_5186, _5188)
%    Exception: (6,705,751) descend3(_5216, _4864) ? 
%    Exception: (6,705,750) descend3(_5216, _4864) ? 
%    Exception: (6,705,749) descend3(_5216, _4864) ? 
%    Exception: (6,705,748) descend3(_5216, _4864) ? nodebug.
% ?- descend4(X, Y).
% X = anne,
% Y = bridget ;
% X = bridget,
% Y = caroline ;
% X = caroline,
% Y = donna ;
% X = donna,
% Y = emily ;
% X = anne,
% Y = caroline ;
% X = bridget,
% Y = donna ;
% X = caroline,
% Y = emily ;
% X = anne,
% Y = donna ;
% X = bridget,
% Y = emily ;
% X = anne,
% Y = emily ;
% ERROR: Stack limit (1.0Gb) exceeded
% ERROR:   Stack sizes: local: 1.0Gb, global: 23Kb, trail: 0Kb
% ERROR:   Stack depth: 12,197,363, last-call: 0%, Choice points: 5
% ERROR:   Probable infinite recursion (cycle):
% ERROR:     [12,197,362] user:descend4(_5974, caroline)
% ERROR:     [12,197,361] user:descend4(_5994, caroline)
% ?- descend5(X, Y).
% X = anne,
% Y = bridget ;
% X = bridget,
% Y = caroline ;
% X = caroline,
% Y = donna ;
% X = donna,
% Y = emily ;
% X = anne,
% Y = caroline ;
% X = bridget,
% Y = donna ;
% X = anne,
% Y = donna ;
% X = caroline,
% Y = emily ;
% X = bridget,
% Y = emily ;
% X = anne,
% Y = emily ;
% false.

% ?-
% descend6(X, Y).
% X = anne,
% Y = caroline ;
% X = anne,
% Y = donna ;
% X = bridget,
% Y = donna ;
% X = anne,
% Y = emily ;
% X = bridget,
% Y = emily ;
% X = caroline,
% Y = emily ;
% X = anne,
% Y = bridget ;
% X = bridget,
% Y = caroline ;
% X = caroline,
% Y = donna ;
% X = donna,
% Y = emily.
