#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               zebra.pl
%
%   Started:            Mon Apr  5 13:58:49 2021
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

% SWIPL defines prefix/2
suffix(S, L) :- append(_, S, L).
sublist(SubL, L) :- suffix(S, L), prefix(SubL, S).

%%%
%%%    Book's solution
%%%    
zebra_book(N) :-
    Street = [H1, H2, H3], % Singletons!
    member(house(red, _, _), Street),  % Five existence claims. First 2 are redundant.
    member(house(blue, _, _), Street),
    member(house(green, _, _), Street),
    member(house(red, english, _), Street),
    member(house(_, spanish, jaguar), Street),
    sublist([house(_, _, snail), house(_, japanese, _)], Street),
    sublist([house(_, _, snail), house(blue, _, _)], Street),
    member(house(_, N, zebra), Street). % Why is this last?

%%%
%%%    Interesting observation from 2012
%%%    
%    member(house(blue, _, _), [house(_, _, jaguar), house(_, _, zebra)]),

%%%
%%%    Does this work? How? 2013
%%%    Nope...
%%%
house(green, _, _).
house(_, _, zebra).
house(red, english, _).
house(_, spanish, jaguar).

street(L) :-
    sublist([house(C1, N1, snail), house(C2, japanese, P2)], L),
    sublist([house(C1, N1, snail), house(blue, N3, P3)], L).

zebra2013(N) :- house(_, N, zebra).

%%%
%%%    2020 (2019 is a mess!)
%%%
zebra2020(Hs) :-
    Hs = [H1, H2, H3],
    sublist([house(N1, C1, snail), house(japanese, C2, P2)], Hs),
    sublist([house(N3, C3, snail), house(N4, blue, P4)], Hs),
    member(house(english, red, P5), Hs),
    member(house(spanish, C5, jaguar), Hs),
    member(house(N6, green, P6), Hs),
    member(house(N7, C7, zebra), Hs).

%%%
%%%    2021
%%%
street2021([H1, H2, H3]) :- % Why do I keep ignoring the instructions?! zebra(N) :- 
    sublist([house(color(Sn), nationality(Nsn), pet(snail)), house(color(J), nationality(japanese), pet(Pj))], [H1, H2, H3]),
    sublist([house(color(Sn), nationality(Nsn), pet(snail)), house(color(blue), nationality(X), pet(Pj))], [H1, H2, H3]),
    member(house(color(red), nationality(english), pet(E)), [H1, H2, H3]),
    member(house(color(S), nationality(spanish), pet(jaguar)), [H1, H2, H3]),
    member(house(color(blue), nationality(_), pet(_)), [H1, H2, H3]),
    member(house(color(green), nationality(_), pet(_)), [H1, H2, H3]),
    member(house(color(_), nationality(_), pet(zebra)), [H1, H2, H3]).

%%%
%%%    Cleaned up
%%%
zebra2021(N) :-
    sublist([house(_, _, snail), house(_, japanese, _)], [H1, H2, H3]),
    sublist([house(_, _, snail), house(blue, _, _)], [H1, H2, H3]),
    member(house(red, english, _), [H1, H2, H3]),
    member(house(_, spanish, jaguar), [H1, H2, H3]),
    member(house(green, _, _), [H1, H2, H3]),
    member(house(_, N, zebra), [H1, H2, H3]).


%%%
%%%    Explore by adding one goal at a time.
%%%
%%%    Both solutions reach the right conclusion once all goals are present.
%%%    But how to explicitly disallow for example, duplicate pets with fewer than all goals? (Uniqueness constraint)
%%%    Example - see 140 below:
%% H1 = house(red, english, snail),
%% H2 = house(green, japanese, snail),
%%%    
%%%    
%% % Actual book
%% Street = [H1, H2, H3], member(house(red, _, _), Street), member(house(blue, _, _), Street), member(house(green, _, _), Street), member(house(red, english, _), Street), member(house(_, spanish, jaguar), Street).
%% Street = [H1, H2, H3], member(house(red, _, _), Street), member(house(blue, _, _), Street), member(house(green, _, _), Street), member(house(red, english, _), Street), member(house(_, spanish, jaguar), Street), sublist([house(_, _, snail), house(_, japanese, _)], Street).
%% Street = [H1, H2, H3], member(house(red, _, _), Street), member(house(blue, _, _), Street), member(house(green, _, _), Street), member(house(red, english, _), Street), member(house(_, spanish, jaguar), Street), sublist([house(_, _, snail), house(_, japanese, _)], Street), sublist([house(_, _, snail), house(blue, _, _)], Street).
%% Street = [H1, H2, H3], member(house(red, _, _), Street), member(house(blue, _, _), Street), member(house(green, _, _), Street), member(house(red, english, _), Street), member(house(_, spanish, jaguar), Street), sublist([house(_, _, snail), house(_, japanese, _)], Street), sublist([house(_, _, snail), house(blue, _, _)], Street), member(house(_, N, zebra), Street).

%% 138 ?- Street = [H1, H2, H3], member(house(red, _, _), Street), member(house(blue, _, _), Street), member(house(green, _, _), Street), member(house(red, english, _), Street), member(house(_, spanish, jaguar), Street).
%% Street = [house(red, english, _3268), house(blue, spanish, jaguar), house(green, _3294, _3296)],
%% H1 = house(red, english, _3268),
%% H2 = house(blue, spanish, jaguar),
%% H3 = house(green, _3294, _3296) ;
%% Street = [house(red, english, _3268), house(blue, _3280, _3282), house(green, spanish, jaguar)],
%% H1 = house(red, english, _3268),
%% H2 = house(blue, _3280, _3282),
%% H3 = house(green, spanish, jaguar) ;
%% Street = [house(red, english, _3268), house(green, spanish, jaguar), house(blue, _3280, _3282)],
%% H1 = house(red, english, _3268),
%% H2 = house(green, spanish, jaguar),
%% H3 = house(blue, _3280, _3282) ;
%% Street = [house(red, english, _3268), house(green, _3294, _3296), house(blue, spanish, jaguar)],
%% H1 = house(red, english, _3268),
%% H2 = house(green, _3294, _3296),
%% H3 = house(blue, spanish, jaguar) ;
%% Street = [house(blue, spanish, jaguar), house(red, english, _3268), house(green, _3294, _3296)],
%% H1 = house(blue, spanish, jaguar),
%% H2 = house(red, english, _3268),
%% H3 = house(green, _3294, _3296) ;
%% Street = [house(blue, _3280, _3282), house(red, english, _3268), house(green, spanish, jaguar)],
%% H1 = house(blue, _3280, _3282),
%% H2 = house(red, english, _3268),
%% H3 = house(green, spanish, jaguar) ;
%% Street = [house(green, spanish, jaguar), house(red, english, _3268), house(blue, _3280, _3282)],
%% H1 = house(green, spanish, jaguar),
%% H2 = house(red, english, _3268),
%% H3 = house(blue, _3280, _3282) ;
%% Street = [house(green, _3294, _3296), house(red, english, _3268), house(blue, spanish, jaguar)],
%% H1 = house(green, _3294, _3296),
%% H2 = house(red, english, _3268),
%% H3 = house(blue, spanish, jaguar) ;
%% Street = [house(blue, spanish, jaguar), house(green, _3294, _3296), house(red, english, _3268)],
%% H1 = house(blue, spanish, jaguar),
%% H2 = house(green, _3294, _3296),
%% H3 = house(red, english, _3268) ;
%% Street = [house(blue, _3280, _3282), house(green, spanish, jaguar), house(red, english, _3268)],
%% H1 = house(blue, _3280, _3282),
%% H2 = house(green, spanish, jaguar),
%% H3 = house(red, english, _3268) ;
%% Street = [house(green, spanish, jaguar), house(blue, _3280, _3282), house(red, english, _3268)],
%% H1 = house(green, spanish, jaguar),
%% H2 = house(blue, _3280, _3282),
%% H3 = house(red, english, _3268) ;
%% Street = [house(green, _3294, _3296), house(blue, spanish, jaguar), house(red, english, _3268)],
%% H1 = house(green, _3294, _3296),
%% H2 = house(blue, spanish, jaguar),
%% H3 = house(red, english, _3268) ;
%% false.

%% 139 ?- Street = [H1, H2, H3], member(house(red, _, _), Street), member(house(blue, _, _), Street), member(house(green, _, _), Street), member(house(red, english, _), Street), member(house(_, spanish, jaguar), Street), sublist([house(_, _, snail), house(_, japanese, _)], Street).
%% Street = [house(red, english, snail), house(blue, japanese, _7126), house(green, spanish, jaguar)],
%% H1 = house(red, english, snail),
%% H2 = house(blue, japanese, _7126),
%% H3 = house(green, spanish, jaguar) ;
%% Street = [house(red, english, snail), house(green, japanese, _7140), house(blue, spanish, jaguar)],
%% H1 = house(red, english, snail),
%% H2 = house(green, japanese, _7140),
%% H3 = house(blue, spanish, jaguar) ;
%% Street = [house(blue, spanish, jaguar), house(red, english, snail), house(green, japanese, _7140)],
%% H1 = house(blue, spanish, jaguar),
%% H2 = house(red, english, snail),
%% H3 = house(green, japanese, _7140) ;
%% Street = [house(green, spanish, jaguar), house(red, english, snail), house(blue, japanese, _7126)],
%% H1 = house(green, spanish, jaguar),
%% H2 = house(red, english, snail),
%% H3 = house(blue, japanese, _7126) ;
%% false.

%% 140 ?- Street = [H1, H2, H3], member(house(red, _, _), Street), member(house(blue, _, _), Street), member(house(green, _, _), Street), member(house(red, english, _), Street), member(house(_, spanish, jaguar), Street), sublist([house(_, _, snail), house(_, japanese, _)], Street), sublist([house(_, _, snail), house(blue, _, _)], Street).
%% Street = [house(red, english, snail), house(blue, japanese, _204), house(green, spanish, jaguar)],
%% H1 = house(red, english, snail),
%% H2 = house(blue, japanese, _204),
%% H3 = house(green, spanish, jaguar) ;
%% Street = [house(red, english, snail), house(green, japanese, snail), house(blue, spanish, jaguar)],
%% H1 = house(red, english, snail),
%% H2 = house(green, japanese, snail),
%% H3 = house(blue, spanish, jaguar) ;
%% Street = [house(green, spanish, jaguar), house(red, english, snail), house(blue, japanese, _204)],
%% H1 = house(green, spanish, jaguar),
%% H2 = house(red, english, snail),
%% H3 = house(blue, japanese, _204) ;
%% false.

%% 141 ?- Street = [H1, H2, H3], member(house(red, _, _), Street), member(house(blue, _, _), Street), member(house(green, _, _), Street), member(house(red, english, _), Street), member(house(_, spanish, jaguar), Street), sublist([house(_, _, snail), house(_, japanese, _)], Street), sublist([house(_, _, snail), house(blue, _, _)], Street), member(house(_, N, zebra), Street).
%% Street = [house(red, english, snail), house(blue, japanese, zebra), house(green, spanish, jaguar)],
%% H1 = house(red, english, snail),
%% H2 = house(blue, japanese, zebra),
%% H3 = house(green, spanish, jaguar),
%% N = japanese ;
%% Street = [house(green, spanish, jaguar), house(red, english, snail), house(blue, japanese, zebra)],
%% H1 = house(green, spanish, jaguar),
%% H2 = house(red, english, snail),
%% H3 = house(blue, japanese, zebra),
%% N = japanese ;
%% false.











%% % Minimal book
%% Street = [H1, H2, H3], member(house(green, _, _), Street).
%% Street = [H1, H2, H3], member(house(green, _, _), Street), member(house(red, english, _), Street).
%% Street = [H1, H2, H3], member(house(green, _, _), Street), member(house(red, english, _), Street), member(house(_, spanish, jaguar), Street).
%% Street = [H1, H2, H3], member(house(green, _, _), Street), member(house(red, english, _), Street), member(house(_, spanish, jaguar), Street), sublist([house(_, _, snail), house(_, japanese, _)], Street).
%% Street = [H1, H2, H3], member(house(green, _, _), Street), member(house(red, english, _), Street), member(house(_, spanish, jaguar), Street), sublist([house(_, _, snail), house(_, japanese, _)], Street), sublist([house(_, _, snail), house(blue, _, _)], Street).
%% Street = [H1, H2, H3], member(house(green, _, _), Street), member(house(red, english, _), Street), member(house(_, spanish, jaguar), Street), sublist([house(_, _, snail), house(_, japanese, _)], Street), sublist([house(_, _, snail), house(blue, _, _)], Street), member(house(_, N, zebra), Street).

%% 142 ?- Street = [H1, H2, H3], member(house(green, _, _), Street), member(house(red, english, _), Street), member(house(_, spanish, jaguar), Street).
%% Street = [house(green, spanish, jaguar), house(red, english, _7504), H3],
%% H1 = house(green, spanish, jaguar),
%% H2 = house(red, english, _7504) ;
%% Street = [house(green, _7488, _7490), house(red, english, _7504), house(_7514, spanish, jaguar)],
%% H1 = house(green, _7488, _7490),
%% H2 = house(red, english, _7504),
%% H3 = house(_7514, spanish, jaguar) ;
%% Street = [house(green, spanish, jaguar), H2, house(red, english, _7504)],
%% H1 = house(green, spanish, jaguar),
%% H3 = house(red, english, _7504) ;
%% Street = [house(green, _7488, _7490), house(_7514, spanish, jaguar), house(red, english, _7504)],
%% H1 = house(green, _7488, _7490),
%% H2 = house(_7514, spanish, jaguar),
%% H3 = house(red, english, _7504) ;
%% Street = [house(red, english, _7504), house(green, spanish, jaguar), H3],
%% H1 = house(red, english, _7504),
%% H2 = house(green, spanish, jaguar) ;
%% Street = [house(red, english, _7504), house(green, _7488, _7490), house(_7514, spanish, jaguar)],
%% H1 = house(red, english, _7504),
%% H2 = house(green, _7488, _7490),
%% H3 = house(_7514, spanish, jaguar) ;
%% Street = [house(_7514, spanish, jaguar), house(green, _7488, _7490), house(red, english, _7504)],
%% H1 = house(_7514, spanish, jaguar),
%% H2 = house(green, _7488, _7490),
%% H3 = house(red, english, _7504) ;
%% Street = [H1, house(green, spanish, jaguar), house(red, english, _7504)],
%% H2 = house(green, spanish, jaguar),
%% H3 = house(red, english, _7504) ;
%% Street = [house(red, english, _7504), house(_7514, spanish, jaguar), house(green, _7488, _7490)],
%% H1 = house(red, english, _7504),
%% H2 = house(_7514, spanish, jaguar),
%% H3 = house(green, _7488, _7490) ;
%% Street = [house(red, english, _7504), H2, house(green, spanish, jaguar)],
%% H1 = house(red, english, _7504),
%% H3 = house(green, spanish, jaguar) ;
%% Street = [house(_7514, spanish, jaguar), house(red, english, _7504), house(green, _7488, _7490)],
%% H1 = house(_7514, spanish, jaguar),
%% H2 = house(red, english, _7504),
%% H3 = house(green, _7488, _7490) ;
%% Street = [H1, house(red, english, _7504), house(green, spanish, jaguar)],
%% H2 = house(red, english, _7504),
%% H3 = house(green, spanish, jaguar) ;
%% false.

%% 143 ?- Street = [H1, H2, H3], member(house(green, _, _), Street), member(house(red, english, _), Street), member(house(_, spanish, jaguar), Street), sublist([house(_, _, snail), house(_, japanese, _)], Street).
%% Street = [house(green, spanish, jaguar), house(red, english, snail), house(_210, japanese, _214)],
%% H1 = house(green, spanish, jaguar),
%% H2 = house(red, english, snail),
%% H3 = house(_210, japanese, _214) ;
%% Street = [house(red, english, snail), house(green, japanese, _158), house(_182, spanish, jaguar)],
%% H1 = house(red, english, snail),
%% H2 = house(green, japanese, _158),
%% H3 = house(_182, spanish, jaguar) ;
%% Street = [house(red, english, snail), house(_210, japanese, _214), house(green, spanish, jaguar)],
%% H1 = house(red, english, snail),
%% H2 = house(_210, japanese, _214),
%% H3 = house(green, spanish, jaguar) ;
%% Street = [house(_182, spanish, jaguar), house(red, english, snail), house(green, japanese, _158)],
%% H1 = house(_182, spanish, jaguar),
%% H2 = house(red, english, snail),
%% H3 = house(green, japanese, _158) ;
%% false.

%% 144 ?- Street = [H1, H2, H3], member(house(green, _, _), Street), member(house(red, english, _), Street), member(house(_, spanish, jaguar), Street), sublist([house(_, _, snail), house(_, japanese, _)], Street), sublist([house(_, _, snail), house(blue, _, _)], Street).
%% Street = [house(green, spanish, jaguar), house(red, english, snail), house(blue, japanese, _3920)],
%% H1 = house(green, spanish, jaguar),
%% H2 = house(red, english, snail),
%% H3 = house(blue, japanese, _3920) ;
%% Street = [house(red, english, snail), house(green, japanese, snail), house(blue, spanish, jaguar)],
%% H1 = house(red, english, snail),
%% H2 = house(green, japanese, snail),
%% H3 = house(blue, spanish, jaguar) ;
%% Street = [house(red, english, snail), house(blue, japanese, _3920), house(green, spanish, jaguar)],
%% H1 = house(red, english, snail),
%% H2 = house(blue, japanese, _3920),
%% H3 = house(green, spanish, jaguar) ;
%% false.

%% 145 ?- Street = [H1, H2, H3], member(house(green, _, _), Street), member(house(red, english, _), Street), member(house(_, spanish, jaguar), Street), sublist([house(_, _, snail), house(_, japanese, _)], Street), sublist([house(_, _, snail), house(blue, _, _)], Street), member(house(_, N, zebra), Street).
%% Street = [house(green, spanish, jaguar), house(red, english, snail), house(blue, japanese, zebra)],
%% H1 = house(green, spanish, jaguar),
%% H2 = house(red, english, snail),
%% H3 = house(blue, japanese, zebra),
%% N = japanese ;
%% Street = [house(red, english, snail), house(blue, japanese, zebra), house(green, spanish, jaguar)],
%% H1 = house(red, english, snail),
%% H2 = house(blue, japanese, zebra),
%% H3 = house(green, spanish, jaguar),
%% N = japanese ;
%% false.


%% % 2021
%% sublist([house(_, _, snail), house(_, japanese, _)], [H1, H2, H3]).
%% sublist([house(_, _, snail), house(_, japanese, _)], [H1, H2, H3]), sublist([house(_, _, snail), house(blue, _, _)], [H1, H2, H3]).
%% sublist([house(_, _, snail), house(_, japanese, _)], [H1, H2, H3]), sublist([house(_, _, snail), house(blue, _, _)], [H1, H2, H3]), member(house(red, english, _), [H1, H2, H3]).
%% sublist([house(_, _, snail), house(_, japanese, _)], [H1, H2, H3]), sublist([house(_, _, snail), house(blue, _, _)], [H1, H2, H3]), member(house(red, english, _), [H1, H2, H3]), member(house(_, spanish, jaguar), [H1, H2, H3]).
%% sublist([house(_, _, snail), house(_, japanese, _)], [H1, H2, H3]), sublist([house(_, _, snail), house(blue, _, _)], [H1, H2, H3]), member(house(red, english, _), [H1, H2, H3]), member(house(_, spanish, jaguar), [H1, H2, H3]), member(house(green, _, _), [H1, H2, H3]).
%% sublist([house(_, _, snail), house(_, japanese, _)], [H1, H2, H3]), sublist([house(_, _, snail), house(blue, _, _)], [H1, H2, H3]), member(house(red, english, _), [H1, H2, H3]), member(house(_, spanish, jaguar), [H1, H2, H3]), member(house(green, _, _), [H1, H2, H3]), member(house(_, N, zebra), [H1, H2, H3]).

%% 146 ?- sublist([house(_, _, snail), house(_, japanese, _)], [H1, H2, H3]).
%% H1 = house(_96, _98, snail),
%% H2 = house(_110, japanese, _114) ;
%% H2 = house(_96, _98, snail),
%% H3 = house(_110, japanese, _114) ;
%% false.

%% 147 ?- sublist([house(_, _, snail), house(_, japanese, _)], [H1, H2, H3]), sublist([house(_, _, snail), house(blue, _, _)], [H1, H2, H3]).
%% H1 = house(_2176, _2178, snail),
%% H2 = house(blue, japanese, _2194) ;
%% H1 = house(_2176, _2178, snail),
%% H2 = house(_2190, japanese, snail),
%% H3 = house(blue, _2244, _2246) ;
%% H1 = house(_2228, _2230, snail),
%% H2 = house(blue, _2178, snail),
%% H3 = house(_2190, japanese, _2194) ;
%% H2 = house(_2176, _2178, snail),
%% H3 = house(blue, japanese, _2194) ;
%% false.

%% 148 ?- sublist([house(_, _, snail), house(_, japanese, _)], [H1, H2, H3]), sublist([house(_, _, snail), house(blue, _, _)], [H1, H2, H3]), member(house(red, english, _), [H1, H2, H3]).
%% H1 = house(red, english, snail),
%% H2 = house(blue, japanese, _4854) ;
%% H1 = house(_4836, _4838, snail),
%% H2 = house(blue, japanese, _4854),
%% H3 = house(red, english, _4944) ;
%% H1 = house(red, english, snail),
%% H2 = house(_4850, japanese, snail),
%% H3 = house(blue, _4904, _4906) ;
%% H1 = house(red, english, snail),
%% H2 = house(blue, _4838, snail),
%% H3 = house(_4850, japanese, _4854) ;
%% H1 = house(red, english, _4944),
%% H2 = house(_4836, _4838, snail),
%% H3 = house(blue, japanese, _4854) ;
%% H2 = house(red, english, snail),
%% H3 = house(blue, japanese, _4854) ;
%% false.

%% 149 ?- sublist([house(_, _, snail), house(_, japanese, _)], [H1, H2, H3]), sublist([house(_, _, snail), house(blue, _, _)], [H1, H2, H3]), member(house(red, english, _), [H1, H2, H3]), member(house(_, spanish, jaguar), [H1, H2, H3]).
%% H1 = house(red, english, snail),
%% H2 = house(blue, japanese, _8126),
%% H3 = house(_8244, spanish, jaguar) ;
%% H1 = house(red, english, snail),
%% H2 = house(_8122, japanese, snail),
%% H3 = house(blue, spanish, jaguar) ;
%% H1 = house(_8244, spanish, jaguar),
%% H2 = house(red, english, snail),
%% H3 = house(blue, japanese, _8126) ;
%% false.

%% 150 ?- sublist([house(_, _, snail), house(_, japanese, _)], [H1, H2, H3]), sublist([house(_, _, snail), house(blue, _, _)], [H1, H2, H3]), member(house(red, english, _), [H1, H2, H3]), member(house(_, spanish, jaguar), [H1, H2, H3]), member(house(green, _, _), [H1, H2, H3]).
%% H1 = house(red, english, snail),
%% H2 = house(blue, japanese, _164),
%% H3 = house(green, spanish, jaguar) ;
%% H1 = house(red, english, snail),
%% H2 = house(green, japanese, snail),
%% H3 = house(blue, spanish, jaguar) ;
%% H1 = house(green, spanish, jaguar),
%% H2 = house(red, english, snail),
%% H3 = house(blue, japanese, _164) ;
%% false.

%% 151 ?- sublist([house(_, _, snail), house(_, japanese, _)], [H1, H2, H3]), sublist([house(_, _, snail), house(blue, _, _)], [H1, H2, H3]), member(house(red, english, _), [H1, H2, H3]), member(house(_, spanish, jaguar), [H1, H2, H3]), member(house(green, _, _), [H1, H2, H3]), member(house(_, N, zebra), [H1, H2, H3]).
%% H1 = house(red, english, snail),
%% H2 = house(blue, japanese, zebra),
%% H3 = house(green, spanish, jaguar),
%% N = japanese ;
%% H1 = house(green, spanish, jaguar),
%% H2 = house(red, english, snail),
%% H3 = house(blue, japanese, zebra),
%% N = japanese ;
%% false.

