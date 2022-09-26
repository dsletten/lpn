#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               crossword.pl
%
%   Started:            Tue May 27 20:01:55 2014
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

% (load "/Users/dsletten/lisp/packages/strings.lisp")
% (use-package :strings)
% (defun process (s) (format t "word(~A, ~A).~%" s (join (coerce s 'list) ",")))
% (dolist (s '("astante" "astoria" "baratto" "cobalto" "pistola" "statale")) (process s))

word(astante, a,s,t,a,n,t,e).
word(astoria, a,s,t,o,r,i,a).
word(baratto, b,a,r,a,t,t,o).
word(cobalto, c,o,b,a,l,t,o).
word(pistola, p,i,s,t,o,l,a).
word(statale, s,t,a,t,a,l,e).

crossword(V1, V2, V3, H1, H2, H3) :-
  word(H1, _, H11, _, H12, _, H13, _),
  word(H2, _, H21, _, H22, _, H23, _),
  word(H3, _, H31, _, H32, _, H33, _),
  word(V1, _, H11, _, H21, _, H31, _),
  word(V2, _, H12, _, H22, _, H32, _),
  word(V3, _, H13, _, H23, _, H33, _),
  V1 \= H1,
  V2 \= H2,
  V3 \= H3.

% This below may seem equivalent, but it's subtly different. Above, the arguments to crossword/6
% are atoms representing the words themselves. But below, the arguments are complex terms: word/8.
% When doing a query such as:
% ?- crossword(W1, W2, W3, W4, W5, W6).
% The Wi variables simply match the word terms without forcing any further instantiation. The result
% is just a whole bunch of variables:
% ?- crossword(W1, W2, W3, W4, W5, W6).
% W1 = word(_G1196, _G1197, _G1198, _G1199, _G1200, _G1201, _G1202, _G1203),
% W2 = word(_G1205, _G1206, _G1207, _G1208, _G1209, _G1210, _G1211, _G1212),
% W3 = word(_G1214, _G1215, _G1216, _G1217, _G1218, _G1219, _G1220, _G1221),
% W4 = word(_G1223, _G1224, _G1198, _G1226, _G1207, _G1228, _G1216, _G1230),
% W5 = word(_G1232, _G1233, _G1200, _G1235, _G1209, _G1237, _G1218, _G1239),
% W6 = word(_G1241, _G1242, _G1202, _G1244, _G1211, _G1246, _G1220, _G1248).

% Compare:
% % ?- f(X) = f(g(Y)).
% X = g(Y).
% (Such a query does not involve searching any KB. It is merely unification, so SWIPL doesn't
%  complain that f/1 and g/1 have not been defined.)

% crossword(word(V1, _, H11, _, H21, _, H31, _),
%           word(V2, _, H12, _, H22, _, H32, _),
%           word(V3, _, H13, _, H23, _, H33, _),
%           word(H1, _, H11, _, H12, _, H13, _),
%           word(H2, _, H21, _, H22, _, H23, _),
%           word(H3, _, H31, _, H32, _, H33, _)).

% Furthermore, this fails altogether since V1 and H1, for example, are not yet instantiated.
% crossword(word(V1, _, H11, _, H21, _, H31, _),
%           word(V2, _, H12, _, H22, _, H32, _),
%           word(V3, _, H13, _, H23, _, H33, _),
%           word(H1, _, H11, _, H12, _, H13, _),
%           word(H2, _, H21, _, H22, _, H23, _),
%           word(H3, _, H31, _, H32, _, H33, _)) :-
%   V1 \= H1,
%   V2 \= H2,
%   V3 \= H3.
