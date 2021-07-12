#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               project3.pl
%
%   Started:            Mon Jun 28 03:36:37 2021
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
%   Notes: Grammar with lexicon, parse tree
%
%%

s(s(NP, VP)) --> np(NP), vp(VP).

np(np(DET, N)) --> det(DET), n(N).

vp(vp(V, NP)) --> v(V), np(NP).
vp(vp(V)) --> v(V).

det(det(Word)) --> [Word], {lex(Word, det)}.

n(n(Word)) --> [Word], {lex(Word, n)}.

v(v(Word)) --> [Word], {lex(Word, v)}.

lex(the, det).
lex(a, det).

lex(woman, n). 
lex(man, n).
lex(pear, n).
lex(apple, n).
lex(dog, n).
lex(cat, n).
lex(car, n).
lex(person, n).
lex(hamburger, n).
lex(book, n).
lex(teacher, n).
lex(child, n).
lex(song, n).
lex(ball, n).

lex(describes, v).
lex(shoots, v).
lex(eats, v).
lex(knows, v).
lex(speaks, v).
lex(walks, v).
lex(swims, v).
lex(laughs, v).
lex(learns, v).
lex(loves, v).
lex(hates, v).
