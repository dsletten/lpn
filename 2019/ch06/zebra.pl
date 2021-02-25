#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               zebra.pl
%
%   Started:            Sun May 17 00:02:55 2020
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
%
%%

prefix(P, L) :-
    append(P, _, L).

suffix(S, L) :-
    append(_, S, L).

sublist(S, L) :-
    suffix(L1, L),
    prefix(S, L1).

zebra(Hs) :-
    Hs = [H1, H2, H3],
    sublist([house(N1, C1, snail), house(japanese, C2, P2)], Hs),
    sublist([house(N3, C3, snail), house(N4, blue, P4)], Hs),
    member(house(english, red, P5), Hs),
    member(house(spanish, C5, jaguar), Hs),
    member(house(N6, green, P6), Hs),
    member(house(N7, C7, zebra), Hs).

%%%
%%%    Book's solution
%%%    Better use of anonymous variables (sort of ...)
%%%    
zebra_book(N) :-
    Street = [H1, H2, H3], % Singletons!
    member(house(red, _, _), Street),  % Three existence claims
    member(house(blue, _, _), Street),
    member(house(green, _, _), Street),
    member(house(red, english, _), Street),
    member(house(_, spanish, jaguar), Street),
    sublist([house(_, _, snail), house(_, japanese, _)], Street),
    sublist([house(_, _, snail), house(blue, _, _)], Street),
    member(house(_, N, zebra), Street).
