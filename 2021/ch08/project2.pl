#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               project2.pl
%
%   Started:            Mon Jun 28 03:30:18 2021
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
%   Notes: Grammar with lexicon.
%
%%

s --> np, vp.

np --> det, n.

vp --> v, np.
vp --> v.

det --> [Word], {lex(Word, det)}.

n --> [Word], {lex(Word, n)}.

v --> [Word], {lex(Word, v)}.

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
