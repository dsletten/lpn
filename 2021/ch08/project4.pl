#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               project4.pl
%
%   Started:            Mon Jun 28 14:30:51 2021
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
%   Notes: Grammar with lexicon, parse tree + pronouns + (single) prepositional phrases/adjectives
%
%%

s(s(NP, VP)) --> np(NP), vp(VP).

np(np(DET, N)) --> det(DET), n(N).
np(np(DET, N, PP)) --> det(DET), n(N), pp(PP).
np(np(DET, ADJ, N)) --> det(DET), adj(ADJ), n(N).
np(np(DET, ADJ, N, PP)) --> det(DET), adj(ADJ), n(N), pp(PP).
np(np(PRO)) --> pro(PRO).

vp(vp(V, NP)) --> v(V), np(NP).
vp(vp(V)) --> v(V).

pp(pp(P, NP)) --> prep(P), np(NP).

det(det(Word)) --> [Word], {lex(Word, det)}.

n(n(Word)) --> [Word], {lex(Word, n)}.

pro(pro(Word)) --> [Word], {lex(Word, pro)}.

v(v(Word)) --> [Word], {lex(Word, v)}.

adj(adj(Word)) --> [Word], {lex(Word, adj)}.

prep(prep(Word)) --> [Word], {lex(Word, prep)}.

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

lex(i, pro).
lex(you, pro).
lex(he, pro).
lex(she, pro).
lex(it, pro).
lex(we, pro).
lex(they, pro).

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
