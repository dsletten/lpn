#!/opt/local/bin/swipl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ch05.pl
%
%   Started:            Thu Aug 15 00:00:59 2019
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

mylength([], 0).
mylength([_|T], L) :-
    mylength(T, L1),
    L is L1 + 1.

lengthAcc(L, Length) :-
    lengthAcc(L, Length, 0).
lengthAcc([], Length, Length).
lengthAcc([_|T], Length, Acc) :-
    Acc1 is Acc + 1,
    lengthAcc(T, Length, Acc1).

%%%
%%%    Book's version
%%%    
maxList([H|T], Max) :-
    maxList(T, Max, H).
maxList([], Max, Max).
maxList([H|T], Max, M) :-
    H > M,
    maxList(T, Max, H).
maxList([H|T], Max, M) :-
    H =< M,
    maxList(T, Max, M).



% % maxList2([X, Y], X) :-
% %     X > Y.
% % maxList2([X, Y], Y) :-
% %     X =< Y.
% % maxList2([X,Y|T]).

% maxList3([H], M, M) :-
%     M >= H.
% maxList3([H], H, M) :-
%     H > M.
% maxList3([H|T], H
        
maxList1([H], H).
maxList1([H|T], M) :-
    maxList1(T, M),
    M >= H.
maxList1([H|T], H) :-
    maxList1(T, M),
    H > M.

maxList1a([H], H).
maxList1a([H|T], M) :-
    maxList1a(T, M1),
    M is max(H, M1).

%%%
%%%    Same as maxList/2 above.
%%%    Tail-recursive
%%%    
maxList2([H|T], M) :-
    maxList2(T, M, H).
maxList2([], M, M).
maxList2([H|T], M, Acc) :-
    Acc >= H,
    maxList2(T, M, Acc).
maxList2([H|T], M, Acc) :-
    H > Acc,
    maxList2(T, M, H).

%%%
%%%    Simplification of maxList relying on max/2
%%%    Tail-recursive
%%%    
maxList3([H|T], M) :-
    maxList3(T, M, H).
maxList3([], M, M).
maxList3([H|T], M, Acc) :-
    Acc1 is max(H, Acc),
    maxList3(T, M, Acc1).
