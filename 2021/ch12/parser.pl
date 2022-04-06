#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               parser.pl
%
%   Started:            Fri Aug  6 17:43:58 2021
%   Modifications:
%
%   Purpose:
%   This is the final grammar from ch. 8 (project9.pl) repackaged as a module.
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
%   Notes: Grammar with lexicon, parse tree + pronouns + arbitrary prepositional phrases/adjectives, subject/object pronouns, intransitive pp, subject/verb agreement,
%   transitive/intransitive verbs, conjunctions
%
%
%% ?- s(Tree, [the, small, frightened, woman, on, the, table, knows, the, big, fat, cow, under, the, shower], []).
%% Tree = s(np(det(the), adjstar([adj(small), adj(frightened)]), n(woman), ppstar(pp(prep(on), np(det(the), n(table))))), vp(v(knows), np(det(the), adjstar([adj(big), adj(fat)]), n(cow), ppstar(pp(prep(under), np(det(the), n(shower))))))) ;
%% false.
%%
%% ?- s(Tree, [the, teacher, walks, and, the, dog, sings], []).
%% Tree = s(np(det(the), n(teacher)), vp(v(walks)), conj(and), np(det(the), n(dog)), vp(v(sings))) 
%%
%%
%   TODO:
%   
%% ?- s(Tree, [the, woman, learns, new, languages], []).
%% false.
%% 
%% ?- s(Tree, [the, teacher, hates, children], []).
%% false.
%%

:- module(parser, [s/3]).

s(s(NP, VP)) --> simple_s(simple_s(NP, VP)).
s(s(NP1, VP1, conj(CON), NP2, VP2)) --> simple_s(simple_s(NP1, VP1)), conj(conj(CON)), s(s(NP2, VP2)).

simple_s(simple_s(NP, VP)) --> np(subject, Person, Plural, NP), vp(Person, Plural, VP).

np(_, third, Plural, np(DET, N)) --> det(Plural, DET), n(Plural, N). % Redundant?
np(_, third, Plural, np(DET, N, PP)) --> det(Plural, DET), n(Plural, N), ppstar(PP). % Redundant?
np(_, third, Plural, np(DET, ADJ, N)) --> det(Plural, DET), adjstar(ADJ), n(Plural, N). % Redundant?
np(_, third, Plural, np(DET, ADJ, N, PP)) --> det(Plural, DET), adjstar(ADJ), n(Plural, N), ppstar(PP).
np(Case, Person, Plural, np(PRO)) --> pro(Case, Person, Plural, PRO).
np(Case, Person, Plural, np(PRO, PP)) --> pro(Case, Person, Plural, PRO), ppstar(PP).

vp(Person, Plural, vp(V, NP)) --> v(Person, Plural, transitive, V), np(object, _, _, NP).
vp(Person, Plural, vp(V)) --> v(Person, Plural, intransitive, V).
vp(Person, Plural, vp(V, PP)) --> v(Person, Plural, intransitive, V), ppstar(PP).

conj(conj(Word)) --> [Word], {lex(Word, conj)}.

%ppstar(ppstar([])) --> [].
ppstar(ppstar(PP)) --> pp(PP). % This seems redundant, but how to otherwise eliminate ppstar([]) from parse tree?
ppstar(ppstar(PP0, PP1)) --> pp(PP0), ppstar(PP1).

pp(pp(P, NP)) --> prep(P), np(object, _, _, NP).

prep(prep(Word)) --> [Word], {lex(Word, prep)}.

det(Plural, det(Word)) --> [Word], {lex(Word, Plural, det)}.

n(singular, n(Word)) --> [Word], {lex(Word, _, n)}.
n(plural, n(Word)) --> [Word], {lex(_, Word, n)}.

pro(subject, Person, Plural, pro(Word)) --> [Word], {lex(Word, _, Person, Plural, pro)}.
pro(object, Person, Plural, pro(Word)) --> [Word], {lex(_, Word, Person, Plural, pro)}.

v(third, singular, Trans, v(Word)) --> !, [Word], {lex(_, Word, Trans, v)}. % Cut is cheating??
v(_, _, Trans, v(Word)) --> [Word], {lex(Word, _, Trans, v)}.

%adjstar(adjstar([])) --> [].
adjstar(adjstar([ADJ])) --> adj(ADJ).
adjstar(adjstar([A|As])) --> adj(A), adjstar(adjstar(As)).

adj(adj(Word)) --> [Word], {lex(Word, adj)}.

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
lex(language, languages, n).
lex(table, tables, n).
lex(cow, cows, n).
lex(shower, showers, n).

lex(describe, describes, transitive, v).
lex(shoot, shoots, transitive, v).
lex(eat, eats, transitive, v).
lex(know, knows, transitive, v).
lex(speak, speaks, transitive, v).
lex(sing, sings, transitive, v).
lex(walk, walks, transitive, v).
lex(swim, swims, transitive, v).
lex(learn, learns, transitive, v).
lex(love, loves, transitive, v).
lex(hate, hates, transitive, v).

lex(shoot, shoots, intransitive, v).
lex(eat, eats, intransitive, v).
lex(know, knows, intransitive, v).
lex(speak, speaks, intransitive, v).
lex(sing, sings, intransitive, v).
lex(walk, walks, intransitive, v).
lex(swim, swims, intransitive, v).
lex(laugh, laughs, intransitive, v).
lex(learn, learns, intransitive, v).
lex(love, loves, intransitive, v).
lex(hate, hates, intransitive, v).

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
lex(fat, adj).
lex(frightened, adj).
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

lex(and, conj).
lex(or, conj).
lex(but, conj).
