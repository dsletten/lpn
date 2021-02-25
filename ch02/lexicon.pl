%#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   NAME:               lexicon.pl
%
%   STARTED:            Wed Jul 28 02:00:01 2010
%   MODIFICATIONS:
%
%   PURPOSE:
%
%
%
%   CALLING SEQUENCE:
%
%
%   INPUTS:
%
%   OUTPUTS:
%
%   EXAMPLE:
%
%   NOTES:
%
%%

word(determiner, a).
word(determiner, every).
word(noun, criminal).
word(noun, 'big kahuna burger').
word(verb, eats).
word(verb, likes).

sentence(Word1, Word2, Word3, Word4, Word5) :-
    word(determiner, Word1),
    word(noun, Word2),
    word(verb, Word3),
    word(determiner, Word4),
    word(noun, Word5).

%
% a criminal eats a criminal
%                   'big kahuna burger'
%                 every criminal
%                       'big kahuna burger'
%            likes a criminal
%                    'big kahuna burger'
%                  every criminal
%                        'big kahuna burger'
%   'big kahuna burger' eats a criminal
%                              'big kahuna burger'
%                            every criminal
%                                  'big kahuna burger'
%                       likes a criminal
%                               'big kahuna burger'
%                             every criminal
%                                   'big kahuna burger'
% every ...

%% ?- sentence(W1, W2, W3, W4, W5).
%% W1 = a,
%% W2 = criminal,
%% W3 = eats,
%% W4 = a,
%% W5 = criminal ;
%% W1 = a,
%% W2 = criminal,
%% W3 = eats,
%% W4 = a,
%% W5 = 'big kahuna burger' ;
%% W1 = a,
%% W2 = criminal,
%% W3 = eats,
%% W4 = every,
%% W5 = criminal ;
%% W1 = a,
%% W2 = criminal,
%% W3 = eats,
%% W4 = every,
%% W5 = 'big kahuna burger' ;
%% W1 = a,
%% W2 = criminal,
%% W3 = likes,
%% W4 = a,
%% W5 = criminal ;
%% W1 = a,
%% W2 = criminal,
%% W3 = likes,
%% W4 = a,
%% W5 = 'big kahuna burger' ;
%% W1 = a,
%% W2 = criminal,
%% W3 = likes,
%% W4 = every,
%% W5 = criminal ;
%% W1 = a,
%% W2 = criminal,
%% W3 = likes,
%% W4 = every,
%% W5 = 'big kahuna burger' ;
%% W1 = a,
%% W2 = 'big kahuna burger',
%% W3 = eats,
%% W4 = a,
%% W5 = criminal ;
%% W1 = a,
%% W2 = 'big kahuna burger',
%% W3 = eats,
%% W4 = a,
%% W5 = 'big kahuna burger' ;
%% W1 = a,
%% W2 = 'big kahuna burger',
%% W3 = eats,
%% W4 = every,
%% W5 = criminal ;
%% W1 = a,
%% W2 = 'big kahuna burger',
%% W3 = eats,
%% W4 = every,
%% W5 = 'big kahuna burger' ;
%% W1 = a,
%% W2 = 'big kahuna burger',
%% W3 = likes,
%% W4 = a,
%% W5 = criminal ;
%% W1 = a,
%% W2 = 'big kahuna burger',
%% W3 = likes,
%% W4 = a,
%% W5 = 'big kahuna burger' ;
%% W1 = a,
%% W2 = 'big kahuna burger',
%% W3 = likes,
%% W4 = every,
%% W5 = criminal ;
%% W1 = a,
%% W2 = 'big kahuna burger',
%% W3 = likes,
%% W4 = every,
%% W5 = 'big kahuna burger' ;
%% W1 = every,
%% W2 = criminal,
%% W3 = eats,
%% W4 = a,
%% W5 = criminal ;
%% W1 = every,
%% W2 = criminal,
%% W3 = eats,
%% W4 = a,
%% W5 = 'big kahuna burger' ;
%% W1 = every,
%% W2 = criminal,
%% W3 = eats,
%% W4 = every,
%% W5 = criminal ;
%% W1 = every,
%% W2 = criminal,
%% W3 = eats,
%% W4 = every,
%% W5 = 'big kahuna burger' ;
%% W1 = every,
%% W2 = criminal,
%% W3 = likes,
%% W4 = a,
%% W5 = criminal ;
%% W1 = every,
%% W2 = criminal,
%% W3 = likes,
%% W4 = a,
%% W5 = 'big kahuna burger' ;
%% W1 = every,
%% W2 = criminal,
%% W3 = likes,
%% W4 = every,
%% W5 = criminal ;
%% W1 = every,
%% W2 = criminal,
%% W3 = likes,
%% W4 = every,
%% W5 = 'big kahuna burger' ;
%% W1 = every,
%% W2 = 'big kahuna burger',
%% W3 = eats,
%% W4 = a,
%% W5 = criminal ;
%% W1 = every,
%% W2 = 'big kahuna burger',
%% W3 = eats,
%% W4 = a,
%% W5 = 'big kahuna burger' ;
%% W1 = every,
%% W2 = 'big kahuna burger',
%% W3 = eats,
%% W4 = every,
%% W5 = criminal ;
%% W1 = every,
%% W2 = 'big kahuna burger',
%% W3 = eats,
%% W4 = every,
%% W5 = 'big kahuna burger' ;
%% W1 = every,
%% W2 = 'big kahuna burger',
%% W3 = likes,
%% W4 = a,
%% W5 = criminal ;
%% W1 = every,
%% W2 = 'big kahuna burger',
%% W3 = likes,
%% W4 = a,
%% W5 = 'big kahuna burger' ;
%% W1 = every,
%% W2 = 'big kahuna burger',
%% W3 = likes,
%% W4 = every,
%% W5 = criminal ;
%% W1 = every,
%% W2 = 'big kahuna burger',
%% W3 = likes,
%% W4 = every,
%% W5 = 'big kahuna burger'.

%% ?- 