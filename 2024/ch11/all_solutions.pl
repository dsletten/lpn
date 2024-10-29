#!/opt/local/bin/swipl -q -t main -f
%%  -*- Mode: Prolog -*-
%   Name:               all_solutions.pl
%
%   Started:            Thu Oct 17 13:20:09 2024
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

%:- module(all_solutions, []).

age(harry,13).
age(draco,14).
age(ron,13).
age(hermione,13).
age(dumbledore,60).
age(hagrid,30).

%%%
%%%    Simply display all names
%%%
?- age(N, _), write(N), nl, fail.
harry
draco
ron
hermione
dumbledore
hagrid
false.

%%%
%%%    Repackage age/2
%%%
?- findall(Name+Age, age(Name, Age), Peeps).
Peeps = [harry+13, draco+14, ron+13, hermione+13, dumbledore+60, hagrid+30].

%%%
%%%    Find all names in age/2 clauses
%%%    Age is existentially quantified (PPID 156 页)
%%%    findall/3 treats "free variables" as uninstantiated for each attempt
%%%    to satisfy Goal, i.e., age(Name, Age).
%%%    
?- findall(Name, age(Name, Age), L).
L = [harry, draco, ron, hermione, dumbledore, hagrid].

%%%
%%%    Same as above
%%%
?- bagof(Name, Age^age(Name, Age), L).
L = [harry, draco, ron, hermione, dumbledore, hagrid].

%%%
%%%    Find all names in age/2 clauses for a specific age
%%%    
?- findall(Name, age(Name, 13), L).
L = [harry, ron, hermione].

?- findall(Name, age(Name, 14), L).
L = [draco].

?- findall(Name, age(Name, 30), L).
L = [hagrid].

?- findall(Name, age(Name, 60), L).
L = [dumbledore].

%%%
%%%    Same as above with backtracking
%%%    For each Age, collect all Names that match age/2.
%%%    
?- bagof(Name, age(Name, Age), L).
Age = 13,
L = [harry, ron, hermione] ;
Age = 14,
L = [draco] ;
Age = 30,
L = [hagrid] ;
Age = 60,
L = [dumbledore].

%%%
%%%    Collect all results from above
%%%    
?- findall(L, bagof(Name, age(Name, Age), L), N).
N = [[harry, ron, hermione], [draco], [hagrid], [dumbledore]].


%%%
%%%    Find all ages in age/2 clauses
%%%    
?- findall(Age, age(Name, Age), L).
L = [13, 14, 13, 13, 60, 30].


?- bagof(Age, age(Name, Age), L).
Name = draco,
L = [14] ;
Name = dumbledore,
L = [60] ;
Name = hagrid,
L = [30] ;
Name = harry,
L = [13] ;
Name = hermione,
L = [13] ;
Name = ron,
L = [13].

?- findall(L, bagof(Age, age(Name, Age), L), A).
A = [[14], [60], [30], [13], [13], [13]].

?- bagof(Age, Name^age(Name, Age), L).
L = [13, 14, 13, 13, 60, 30].




foo(a, 1, bar).
foo(a, 2, baz).
foo(b, 1, bar).
foo(b, 3, pung).
foo(c, 2, bar).
foo(c, 9, pung).

?- bagof(A, foo(A, B, C), L).
B = 1,
C = bar,
L = [a, b] ;
B = 2,
C = bar,
L = [c] ;
B = 2,
C = baz,
L = [a] ;
B = 3,
C = pung,
L = [b] ;
B = 9,
C = pung,
L = [c].

?- bagof(A, B^foo(A, B, C), L).
C = bar,
L = [a, b, c] ;
C = baz,
L = [a] ;
C = pung,
L = [b, c].

?- bagof(A, C^foo(A, B, C), L).
B = 1,
L = [a, b] ;
B = 2,
L = [a, c] ;
B = 3,
L = [b] ;
B = 9,
L = [c].

?- bagof(A, B^C^foo(A, B, C), L).
L = [a, a, b, b, c, c].

?- findall(A, foo(A, B, C), L).
L = [a, a, b, b, c, c].

?- bagof([A, B], foo(A, B, C), L).
C = bar,
L = [[a, 1], [b, 1], [c, 2]] ;
C = baz,
L = [[a, 2]] ;
C = pung,
L = [[b, 3], [c, 9]].

?- bagof([A, B], C^foo(A, B, C), L).
L = [[a, 1], [a, 2], [b, 1], [b, 3], [c, 2], [c, 9]].
