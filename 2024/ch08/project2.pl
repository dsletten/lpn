#!/opt/local/bin/swipl -q -t main -f
%%  -*- Mode: Prolog -*-
%   Name:               project2.pl
%
%   Started:            Wed Aug 28 02:25:44 2024
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
%   - Transitive/intransitive verb
%
%%

%:- module(project2, []).

either(_, Number) :- Number \= singular.
either(Person, _) :- Person \= third.

initial([], _, I, I).
initial([_|_], I, _, I).

third_person_singular(third, singular).

s(S) --> simple_s(S).
s(s(S1, C, S2)) --> simple_s(S1),
                    conj(C),
                    s(S2).
simple_s(S) --> np(NP, subject, Person, Number),
                pp_star(PREP),
                vp(VP, Person, Number),
                {append([s, NP|PREP], [VP], L),
                 S =.. L}.

np(NP, _, third, Number) --> det(DET, Number, Initial),
                             adj_star(ADJ, InitialA),
                             n(N, Number, InitialN),
                             {initial(ADJ, InitialA, InitialN, Initial),
                              append([np,DET|ADJ], [N], L),
                              NP =.. L}.
np(NP, _, third, plural) --> adj_star(ADJ, InitialA),
                             n(N, Number, InitialN),
                             {initial(ADJ, InitialA, InitialN, Initial),
                              append([np|ADJ], [N], L),
                              NP =.. L}.
np(np(PRO), Case, Person, Number) --> pro(PRO, Case, Person, Number).

vp(VP, Person, Number) --> v(V, Person, Number),
                           np(NP, object, _, _),
                           pp_star(PREP),
                           {VP =.. [vp,V,NP|PREP]}.
vp(vp(V), Person, Number) --> v(V, Person, Number).

pp_star([]) --> [].
pp_star(PREP) --> prep(PREP1),
                  np(NP, object, _, _),
                  pp_star(PREP2),
                  {append([pp(PREP1, NP)], PREP2, PREP)}.

adj_star([], _) --> [].
adj_star(ADJ, Initial) --> adj(ADJ1, Initial), adj_star(ADJ2, _), {append([ADJ1], ADJ2, ADJ)}.

det(det(Word), Number, Initial) --> [Word], {lex(Word, det, Number, Initial)}.

n(n(Word), Number, Initial) --> [Word], {lex(Word, n, Number, Initial)}.

pro(pro(Word), Case, Person, Number) --> [Word], {lex(Word, pro, Case, Person, Number)}.

v(v(Word), third, singular) --> [Word], {lex(Word, v, third, singular)}.
%v(v(Word), Person, Number) --> [Word], {lex(Word, v, any, any), either(Person, Number)}.
v(v(Word), Person, Number) --> [Word], {lex(Word, v, any, any), \+ third_person_singular(Person, Number)}.

prep(prep(Word)) --> [Word], {lex(Word, prep)}.

adj(adj(Word), Initial) --> [Word], {lex(Word, adj, Initial)}.

conj(conj(Word)) --> [Word], {lex(Word, conj)}.

lex(the, det, _, _).
lex(a, det, singular, consonant).
lex(an, det, singular, vowel).

lex(woman, n, singular, consonant).
lex(women, n, plural, consonant).
lex(man, n,singular, consonant).
lex(men, n, plural, consonant).
lex(apple, n, singular, vowel).
lex(pear, n, singular, consonant).
lex(dog, n, singular, consonant).
lex(dogs, n, plural, consonant).
lex(tree, n, singular, consonant).
lex(car, n, singular, consonant).
lex(house, n, singular, consonant).
lex(room, n, singular, consonant).
lex(street, n, singular, consonant).
lex(pool, n, singular, consonant).
lex(child, n, singular, consonant).
lex(children, n, plural, consonant).
lex(table, n, singular, consonant).
lex(cow, n, singular, consonant).
lex(shower, n, singular, consonant).
lex(boy, n, singular, consonant).
lex(boys, n, plural, consant).
lex(girl, n, singular, consonant).
lex(girls, n, plural, consant).
lex(kid, n, singular, consonant).
lex(kids, n, plural, consant).
lex(teacher, n, singular, consonant).
lex(teachers, n, plural, consant).
lex(language, n, singular, consonant).
lex(languages, n, plural, consant).

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
lex(likes, v, third, singular).
lex(like, v, any, any).
lex(watches, v, third, singular).
lex(watch, v, any, any).
lex(hates, v, third, singular).
lex(love, v, any, any).
lex(loves, v, third, singular).
lex(hate, v, any, any).
lex(learns, v, third, singular).
lex(learn, v, any, any).

lex(good, adj, consonant).
lex(bad, adj, consonant).
lex(small, adj, consonant).
lex(frightened, adj, consonant).
lex(big, adj, consonant).
lex(fat, adj, consonant).
lex(ample, adj, vowel).
lex(eclectic, adj, vowel).
lex(invisible, adj, vowel).
lex(overblown, adj, vowel).
lex(unpredictable, adj, vowel).
lex(strange, adj, consonant).
lex(adorable, adj, vowel).
lex(putrid, adj, consonant).
lex(new, adj, consonant).
lex(old, adj, vowel).
lex(honorable, adj, vowel).
lex(gloomy, adj, consonant).
lex(cheerful, adj, consonant).
lex(adventurous, adj, vowel).

lex(on, prep).
lex(in, prep).
lex(under, prep).
lex(over, prep).
lex(behind, prep).
lex('in front of', prep).
lex(beside, prep).
lex(by, prep).
lex(from, prep).
lex(to, prep).
lex(within, prep).
lex(outside, prep).

lex(and, conj).
lex(but, conj).
