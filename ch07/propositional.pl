#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               propositional.pl
%
%   Started:            Fri Apr 13 13:13:31 2012
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
%   Notes: See PAIP ex. 2.3
%
%%

prop --> [p].
prop --> [q].
prop --> [r].
prop --> neg, prop.
prop --> ['('], prop, binary, prop, [')'].

binary --> conj.
binary --> disj.
binary --> impl.

neg --> [not].

conj --> [and].
disj --> [or].
impl --> [implies].

%% impl([implies|A], A).

%% disj([or|A], A).

%% conj([and|A], A).

%% binary(A, B) :-
%% 	conj(A, B).
%% binary(A, B) :-
%% 	disj(A, B).
%% binary(A, B) :-
%% 	impl(A, B).

%% neg([not|A], A).

%% prop([p|A], A).
%% prop([q|A], A).
%% prop([r|A], A).
%% prop(A, C) :-
%% 	neg(A, B),
%% 	prop(B, C).
%% prop(['('|A], E) :-
%% 	prop(A, B),
%% 	binary(B, C),
%% 	prop(C, D),
%% 	D=[')'|E].




%% prop --> [p].
%% prop --> [q].
%% prop --> [r].

%% prop --> neg, prop.
%% %prop --> conj, prop, prop.

%% prop --> ['('], prop, binary, prop, [')'].

%% binary --> conj.
%% binary --> disj.
%% binary --> impl.

%% %% prop --> ['('], prop, conj, prop, [')'].
%% %% prop --> ['('], prop, disj, prop, [')'].
%% %% prop --> ['('], prop, impl, prop, [')'].

%% %prop --> conj_before, prop, conj_between, prop, conj_after.

%% %% conj_before --> ['('].
%% %% conj_between --> [and].
%% %% conj_after --> [')'].

%% neg --> [not].

%% conj --> [and].
%% disj --> [or].
%% impl --> [implies].
