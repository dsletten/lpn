#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               project7.pl
%
%   Started:            Tue Jun 29 15:13:37 2021
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
%   Notes: Grammar with lexicon, parse tree + pronouns + arbitrary prepositional phrases/adjectives, subject/object pronouns, intransitive pp, subject/verb agreement
%
%%

s(s(NP, VP)) --> np(subject, Person, Plural, NP), vp(Person, Plural, VP).

np(_, third, Plural, np(DET, N)) --> det(Plural, DET), n(Plural, N). % Redundant?
np(_, third, Plural, np(DET, N, PP)) --> det(Plural, DET), n(Plural, N), ppstar(PP). % Redundant?
np(_, third, Plural, np(DET, ADJ, N)) --> det(Plural, DET), adjstar(ADJ), n(Plural, N). % Redundant?
np(_, third, Plural, np(DET, ADJ, N, PP)) --> det(Plural, DET), adjstar(ADJ), n(Plural, N), ppstar(PP).
np(Case, Person, Plural, np(PRO)) --> pro(Case, Person, Plural, PRO).
np(Case, Person, Plural, np(PRO, PP)) --> pro(Case, Person, Plural, PRO), ppstar(PP).

vp(Person, Plural, vp(V, NP)) --> v(Person, Plural, V), np(object, _, _, NP).
vp(Person, Plural, vp(V)) --> v(Person, Plural, V).
vp(Person, Plural, vp(V, PP)) --> v(Person, Plural, V), ppstar(PP).

%ppstar(ppstar([])) --> [].
ppstar(ppstar(PP)) --> pp(PP). % This seems redundant, but how to otherwise eliminate ppstar([]) from parse tree?
ppstar(ppstar(PP0, PP1)) --> pp(PP0), ppstar(PP1).

pp(pp(P, NP)) --> prep(P), np(object, _, _, NP).

det(Plural, det(Word)) --> [Word], {lex(Word, Plural, det)}.

n(singular, n(Word)) --> [Word], {lex(Word, _, n)}.
n(plural, n(Word)) --> [Word], {lex(_, Word, n)}.

pro(subject, Person, Plural, pro(Word)) --> [Word], {lex(Word, _, Person, Plural, pro)}.
pro(object, Person, Plural, pro(Word)) --> [Word], {lex(_, Word, Person, Plural, pro)}.

v(third, singular, v(Word)) --> !, [Word], {lex(_, Word, v)}.
v(_, _, v(Word)) --> [Word], {lex(Word, _, v)}.

%adjstar(adjstar([])) --> [].
adjstar(adjstar([ADJ])) --> adj(ADJ).
adjstar(adjstar([A|As])) --> adj(A), adjstar(adjstar(As)).

adj(adj(Word)) --> [Word], {lex(Word, adj)}.

prep(prep(Word)) --> [Word], {lex(Word, prep)}.

lex(the, _, det).
lex(a, singular, det).

lex(woman, women, n). 
lex(man, men, n).
lex(pear, pears, n).
lex(apple, apples, n).
lex(dog, dogs, n).
lex(cat, cats, n).
lex(car, cars, n).
lex(person, persons, n).
lex(hamburger, hamburgers, n).
lex(book, boooks, n).
lex(teacher, teachers, n).
lex(child, children, n).
lex(song, songs, n).
lex(ball, balls, n).

lex(describe, describes, v).
lex(shoot, shoots, v).
lex(eat, eats, v).
lex(know, knows, v).
lex(speak, speaks, v).
lex(walk, walks, v).
lex(swim, swims, v).
lex(laugh, laughs, v).
lex(learn, learns, v).
lex(love, loves, v).
lex(hate, hates, v).

lex(i, me, first, singular, pro).
lex(you, you, second, _, pro).
lex(he, him, third, singular, pro).
lex(she, her, third, singular, pro).
lex(it, it, third, singular, pro).
lex(we, us, first, plural, pro).
lex(they, them, third, plural, pro).

lex(red, adj).
lex(beautiful, adj).
lex(tall, adj).
lex(unknown, adj).
lex(shiny, adj).
lex(big, adj).
lex(small, adj).
lex(adiabatic, adj).
lex(curly, adj).
lex(erratic, adj).
lex(sympathetic, adj).
lex(new, adj).

lex(on, prep).
lex(in, prep).
lex(under, prep).
lex(above, prep).
lex(inside, prep).
lex(below, prep).
lex(near, prep).
lex(along, prep).
lex(beside, prep).
lex(behind, prep).
lex(over, prep).
lex(with, prep).

