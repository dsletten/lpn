#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               project.pl
%
%   Started:            Wed May 12 04:55:47 2021
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
%   Plural is either singular or plural.
%   Person is either base or third.
%   Case is either subject or object.
%
%   Only regular verbs (present tense) handled: transitive or intransitive
%   (Lexicon includes "eat", which is not really regular: eat -> ate)
%   Ha! The only actual regular verb is "walk"!!!
%   shoot -> shot
%   eat -> ate
%   know -> knew
%   speak -> spoke
%   walk -> walked
%   swim -> swam
%
%%

s(s(NP, VP)) --> np(subject, _, Person, NP), vp(Person, VP).

%np(_, Plural, third, np(DET, N))  --> det(Plural, DET), n(Plural, N).
np(_, Plural, third, np(DET, ADJ, N, PP))  --> det(Plural, DET), ap(ADJ), n(Plural, N), pp(PP).
np(Case, Plural, Person, np(PRO)) --> pro(Case, Plural, Person, PRO).

ap([]) --> [].
ap([Word|ADJ]) --> adj(Word), ap(ADJ).
adj(adj(Word)) --> [Word], {lex(Word, adj)}.

vp(Person, vp(V, NP)) --> v(transitive, Person, V), np(object, _, _, NP).
vp(Person, vp(V))     --> v(intransitive, Person, V).

pp([]) --> [].
pp([P, NP|PP]) --> prep(P), np(_, _, _, NP), pp(PP).
prep(prep(Word)) --> [Word], {lex(Word, prep)}.

det(Plural, det(Word)) --> [Word], {lex(Word, Plural, det)}.

n(singular, n(Word)) --> [Word], {lex(Word, _, n)}.
n(plural, n(Word))   --> [Word], {lex(_, Word, n)}.
%n(P, n(Word)) --> [Word], {lex(Word, P, n)}.

%% pro(subject, singular, pro(Word)) --> [Word], {lex(Word, _, _, _, pro)}.
%% pro(object, singular, pro(Word)) --> [Word], {lex(_, Word, _, _, pro)}.
%% pro(subject, plural, pro(Word)) --> [Word], {lex(_, _, Word, _, pro)}.
%% pro(object, plural, pro(Word)) --> [Word], {lex(_, _, _, Word, pro)}.

pro(subject, singular, base, pro(Word))  --> [Word], {lex(Word, _, singular, base, pro)}.
pro(subject, singular, third, pro(Word)) --> [Word], {lex(Word, _, singular, third, pro)}.
pro(subject, plural, base, pro(Word))    --> [Word], {lex(Word, _, plural, base, pro)}.

pro(object, singular, base, pro(Word))   --> [Word], {lex(_, Word, singular, base, pro)}.
pro(object, plural, base, pro(Word))     --> [Word], {lex(_, Word, plural, base, pro)}.

% Regular verbs
v(transitive, base, v(Word))    --> [Word], {lex(transitive, Word, _, v)}.
v(transitive, third, v(Word))   --> [Word], {lex(transitive, _, Word, v)}.

v(intransitive, base, v(Word))  --> [Word], {lex(intransitive, Word, _, v)}.
v(intransitive, third, v(Word)) --> [Word], {lex(intransitive, _, Word, v)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%    
%%%    Lexicon
%%%    
lex(the, _, det).
lex(a, singular, det).

%% det(_, det(the)) --> [the].
%% det(singular, det(a)) --> [a].

%
%    We lose 1st-arg indexing for plurals...
%    
lex(woman, women, n). 
lex(man, men, n).
lex(pear, pears, n).
lex(apple, apples, n).
lex(dog, dogs, n).
lex(cat, cats, n).
lex(car, cars, n).
lex(person, people, n).
lex(hamburger, hamburgers, n).
lex(book, books, n).
lex(teacher, teachers, n).
lex(child, children, n).
lex(song, songs, n).
lex(ball, balls, n).

%% n(singular, n(woman)) --> [woman].
%% n(singular, n(man)) --> [man].
%% n(singular, n(pear)) --> [pear].
%% n(singular, n(apple)) --> [apple].
%% n(plural, n(women)) --> [women].
%% n(plural, n(men)) --> [men].
%% n(plural, n(pears)) --> [pears].
%% n(plural, n(apples)) --> [apples].

%% lex(woman, singular, n). 
%% lex(man, singular, n).
%% lex(pear, singular, n).
%% lex(apple, singular, n).
%% lex(women, plural, n).
%% lex(men, plural, n).
%% lex(pears, plural, n).
%% lex(apples, plural, n).

lex(i, me, singular, base, pro).
lex(you, you, _, base, pro).
lex(he, him, singular, third, pro).
lex(she, her, singular, third, pro).
lex(it, it, singular, third, pro).
lex(we, us, plural, base, pro).
lex(they, them, plural, base, pro).

%% pro(subject, singular, pro(i)) --> [i].
%% pro(_, _, pro(you)) --> [you].
%% pro(subject, singular, pro(he)) --> [he].
%% pro(subject, singular, pro(she)) --> [she].
%% pro(_, singular, pro(it)) --> [it].
%% pro(subject, plural, pro(we)) --> [we].
%% pro(subject, plural, pro(they)) --> [they].
%% pro(object, singular, pro(me)) --> [me].
%% pro(object, singular, pro(him)) --> [him].
%% pro(object, singular, pro(her)) --> [her].
%% pro(object, plural, pro(us)) --> [us].
%% pro(object, plural, pro(them)) --> [them].

%% v(singular, v(shoots)) --> [shoots].
%% v(singular, v(eats)) --> [eats].
%% v(singular, v(knows)) --> [knows].
%% v(plural, v(shoot)) --> [shoot].
%% v(plural, v(eat)) --> [eat].
%% v(plural, v(know)) --> [know].

lex(transitive, shoot, shoots, v).
lex(transitive, eat, eats, v).
lex(transitive, know, knows, v).
lex(transitive, describe, describes, v).
lex(transitive, learn, learns, v).
lex(transitive, love, loves, v).
lex(transitive, hate, hates, v).

lex(intransitive, shoot, shoots, v).
lex(intransitive, eat, eats, v).
lex(intransitive, know, knows, v).
lex(intransitive, speak, speaks, v).
lex(intransitive, walk, walks, v).
lex(intransitive, swim, swims, v).
lex(intransitive, laugh, laughs, v).
lex(intransitive, learn, learns, v).
lex(intransitive, love, loves, v).
lex(intransitive, hate, hates, v).

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
