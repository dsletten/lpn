#!/opt/local/bin/swipl -q -t main -f
%%  -*- Mode: Prolog -*-
%   Name:               project1.pl
%
%   Started:            Sun Aug 25 17:12:25 2024
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
%   Notes: Practical session ex. 1
%   DCG w/ subject/object distinction, singular/plural distinction, parser, lexicon
%
%%

%:- module(project1, []).

either(_, Number) :- Number \= singular.
either(Person, _) :- Person \= third.


s(s(NP, VP)) --> np(NP, subject, Person, Number), vp(VP, Person, Number).

np(np(DET, N), _, third, Number) --> det(DET, Number, Initial), n(N, Number, Initial).
np(np(PRO), Case, Person, Number) --> pro(PRO, Case, Person, Number).

vp(vp(V, NP), Person, Number) --> v(V, Person, Number), np(NP, object, _, _).
vp(vp(V), Person, Number) --> v(V, Person, Number).

det(det(Word), Number, Initial) --> [Word], {lex(Word, det, Number, Initial)}.
n(n(Word), Number, Initial) --> [Word], {lex(Word, n, Number, Initial)}.
pro(pro(Word), Case, Person, Number) --> [Word], {lex(Word, pro, Case, Person, Number)}.
v(v(Word), third, singular) --> [Word], {lex(Word, v, third, singular)}.
v(v(Word), Person, Number) --> [Word], {lex(Word, v, any, any), either(Person, Number)}.

lex(the, det, _, _).
lex(a, det, singular, consonant).
lex(an, det, singular, vowel).

lex(woman, n, singular, consonant).
lex(man, n,singular, consonant).
lex(apple, n, singular, vowel).
lex(pear, n, singular, consonant).
lex(men, n, plural, consonant).
lex(women, n, plural, consonant).
lex(dogs, n, plural, consonant).

lex(i, pro, subject, first, singular).
lex(you, pro, subject, second, singular).
lex(he, pro, subject, third, singular).
lex(she, pro, subject, third, singular).
lex(it, pro, subject, third, singular).
lex(we, pro, subject, first, plural).
lex(you, pro, subject, second, plural).
lex(they, pro, subject, third, plural).

lex(me, pro, object, first, singular).
lex(you, pro, object, second, singular).
lex(him, pro, object, third, singular).
lex(her, pro, object, third, singular).
lex(it, pro, object, third, singular).
lex(us, pro, object, first, plural).
lex(you, pro, object, second, plural).
lex(them, pro, object, third, plural).

% (In)Transitive?
lex(eats, v, third, singular).
lex(eat, v, any, any).
lex(knows, v, third, singular).
lex(know, v, any, any).


