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

%%%
%%%    乙 notes pg. ۶۰
%%%
%%%    This version is horribly inefficient in the worst-case scenario, namely,
%%%    when the list is already in descending order. In each case, H is the
%%%    max of the tail. So the first recursive clause always fails after having
%%%    worked through the rest of the list. Then the 2nd recursive clause has
%%%    to repeat all of the work!
%%%    
maxList1([H], H).
maxList1([H|T], M) :-
    maxList1(T, M),
    M >= H.
maxList1([H|T], H) :-
    maxList1(T, M),
    H > M.


%%%
%%%    甲 notes pg. ۶۰
%%%    
maxList1a([H], H).
maxList1a([H|T], M) :-
    maxList1a(T, M1),
    M is max(H, M1).

%%%
%%%    丁
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
%%%    丙
%%%    Simplification of maxList relying on max/2
%%%    Tail-recursive
%%%    
maxList3([H|T], M) :-
    maxList3(T, M, H).
maxList3([], M, M).
maxList3([H|T], M, Acc) :-
    Acc1 is max(H, Acc),
    maxList3(T, M, Acc1).

%% [trace] 144 ?- maxList1([4, 3, 2, 1], X).
%%    Call: (8) maxList1([4, 3, 2, 1], _20383902) ? 
%%    Call: (9) maxList1([3, 2, 1], _20383902) ? 
%%    Call: (10) maxList1([2, 1], _20383902) ? 
%%    Call: (11) maxList1([1], _20383902) ? 
%%    Exit: (11) maxList1([1], 1) ? 
%%    Call: (11) 1>=2 ? 
%%    Fail: (11) 1>=2 ? 
%%    Redo: (11) maxList1([1], _20383902) ? 
%%    Call: (12) maxList1([], _20383902) ? 
%%    Fail: (12) maxList1([], _20383902) ? 
%%    Redo: (11) maxList1([1], _20383902) ? 
%%    Call: (12) maxList1([], _20384148) ? 
%%    Fail: (12) maxList1([], _20384148) ? 
%%    Fail: (11) maxList1([1], _20383902) ? 
%%    Redo: (10) maxList1([2, 1], _20383902) ? 
%%    Call: (11) maxList1([1], _20384148) ? 
%%    Exit: (11) maxList1([1], 1) ? 
%%    Call: (11) 2>1 ? 
%%    Exit: (11) 2>1 ? 
%%    Exit: (10) maxList1([2, 1], 2) ? 
%%    Call: (10) 2>=3 ? 
%%    Fail: (10) 2>=3 ? 
%%    Redo: (11) maxList1([1], _20384148) ? 
%%    Call: (12) maxList1([], _20384148) ? 
%%    Fail: (12) maxList1([], _20384148) ? 
%%    Redo: (11) maxList1([1], _20384148) ? 
%%    Call: (12) maxList1([], _20384148) ? 
%%    Fail: (12) maxList1([], _20384148) ? 
%%    Fail: (11) maxList1([1], _20384148) ? 
%%    Fail: (10) maxList1([2, 1], _20383902) ? 
%%    Redo: (9) maxList1([3, 2, 1], _20383902) ? 
%%    Call: (10) maxList1([2, 1], _20384148) ? 
%%    Call: (11) maxList1([1], _20384148) ? 
%%    Exit: (11) maxList1([1], 1) ? 
%%    Call: (11) 1>=2 ? 
%%    Fail: (11) 1>=2 ? 
%%    Redo: (11) maxList1([1], _20384148) ? 
%%    Call: (12) maxList1([], _20384148) ? 
%%    Fail: (12) maxList1([], _20384148) ? 
%%    Redo: (11) maxList1([1], _20384148) ? 
%%    Call: (12) maxList1([], _20384148) ? 
%%    Fail: (12) maxList1([], _20384148) ? 
%%    Fail: (11) maxList1([1], _20384148) ? 
%%    Redo: (10) maxList1([2, 1], _20384148) ? 
%%    Call: (11) maxList1([1], _20384148) ? 
%%    Exit: (11) maxList1([1], 1) ? 
%%    Call: (11) 2>1 ? 
%%    Exit: (11) 2>1 ? 
%%    Exit: (10) maxList1([2, 1], 2) ? 
%%    Call: (10) 3>2 ? 
%%    Exit: (10) 3>2 ? 
%%    Exit: (9) maxList1([3, 2, 1], 3) ? 
%%    Call: (9) 3>=4 ? 
%%    Fail: (9) 3>=4 ? 
%%    Redo: (11) maxList1([1], _20384148) ? 
%%    Call: (12) maxList1([], _20384148) ? 
%%    Fail: (12) maxList1([], _20384148) ? 
%%    Redo: (11) maxList1([1], _20384148) ? 
%%    Call: (12) maxList1([], _20384148) ? 
%%    Fail: (12) maxList1([], _20384148) ? 
%%    Fail: (11) maxList1([1], _20384148) ? 
%%    Fail: (10) maxList1([2, 1], _20384148) ? 
%%    Fail: (9) maxList1([3, 2, 1], _20383902) ? 
%%    Redo: (8) maxList1([4, 3, 2, 1], _20383902) ? 
%%    Call: (9) maxList1([3, 2, 1], _20384148) ? 
%%    Call: (10) maxList1([2, 1], _20384148) ? 
%%    Call: (11) maxList1([1], _20384148) ? 
%%    Exit: (11) maxList1([1], 1) ? 
%%    Call: (11) 1>=2 ? 
%%    Fail: (11) 1>=2 ? 
%%    Redo: (11) maxList1([1], _20384148) ? 
%%    Call: (12) maxList1([], _20384148) ? 
%%    Fail: (12) maxList1([], _20384148) ? 
%%    Redo: (11) maxList1([1], _20384148) ? 
%%    Call: (12) maxList1([], _20384148) ? 
%%    Fail: (12) maxList1([], _20384148) ? 
%%    Fail: (11) maxList1([1], _20384148) ? 
%%    Redo: (10) maxList1([2, 1], _20384148) ? 
%%    Call: (11) maxList1([1], _20384148) ? 
%%    Exit: (11) maxList1([1], 1) ? 
%%    Call: (11) 2>1 ? 
%%    Exit: (11) 2>1 ? 
%%    Exit: (10) maxList1([2, 1], 2) ? 
%%    Call: (10) 2>=3 ? 
%%    Fail: (10) 2>=3 ? 
%%    Redo: (11) maxList1([1], _20384148) ? 
%%    Call: (12) maxList1([], _20384148) ? 
%%    Fail: (12) maxList1([], _20384148) ? 
%%    Redo: (11) maxList1([1], _20384148) ? 
%%    Call: (12) maxList1([], _20384148) ? 
%%    Fail: (12) maxList1([], _20384148) ? 
%%    Fail: (11) maxList1([1], _20384148) ? 
%%    Fail: (10) maxList1([2, 1], _20384148) ? 
%%    Redo: (9) maxList1([3, 2, 1], _20384148) ? 
%%    Call: (10) maxList1([2, 1], _20384148) ? 
%%    Call: (11) maxList1([1], _20384148) ? 
%%    Exit: (11) maxList1([1], 1) ? 
%%    Call: (11) 1>=2 ? 
%%    Fail: (11) 1>=2 ? 
%%    Redo: (11) maxList1([1], _20384148) ? 
%%    Call: (12) maxList1([], _20384148) ? 
%%    Fail: (12) maxList1([], _20384148) ? 
%%    Redo: (11) maxList1([1], _20384148) ? 
%%    Call: (12) maxList1([], _20384148) ? 
%%    Fail: (12) maxList1([], _20384148) ? 
%%    Fail: (11) maxList1([1], _20384148) ? 
%%    Redo: (10) maxList1([2, 1], _20384148) ? 
%%    Call: (11) maxList1([1], _20384148) ? 
%%    Exit: (11) maxList1([1], 1) ? 
%%    Call: (11) 2>1 ? 
%%    Exit: (11) 2>1 ? 
%%    Exit: (10) maxList1([2, 1], 2) ? 
%%    Call: (10) 3>2 ? 
%%    Exit: (10) 3>2 ? 
%%    Exit: (9) maxList1([3, 2, 1], 3) ? 
%%    Call: (9) 4>3 ? 
%%    Exit: (9) 4>3 ? 
%%    Exit: (8) maxList1([4, 3, 2, 1], 4) ? 
%% X = 4 ;
%%    Redo: (11) maxList1([1], _20384148) ? 
%%    Call: (12) maxList1([], _20384148) ? 
%%    Fail: (12) maxList1([], _20384148) ? 
%%    Redo: (11) maxList1([1], _20384148) ? 
%%    Call: (12) maxList1([], _20384148) ? 
%%    Fail: (12) maxList1([], _20384148) ? 
%%    Fail: (11) maxList1([1], _20384148) ? 
%%    Fail: (10) maxList1([2, 1], _20384148) ? 
%%    Fail: (9) maxList1([3, 2, 1], _20384148) ? 
%%    Fail: (8) maxList1([4, 3, 2, 1], _20383902) ? 
%% false.


%% [trace] 145 ?- maxList1a([4, 3, 2, 1], X).
%%    Call: (8) maxList1a([4, 3, 2, 1], _20386242) ? 
%%    Call: (9) maxList1a([3, 2, 1], _20386488) ? 
%%    Call: (10) maxList1a([2, 1], _20386488) ? 
%%    Call: (11) maxList1a([1], _20386488) ? 
%%    Exit: (11) maxList1a([1], 1) ? 
%%    Call: (11) _20386492 is max(2, 1) ? 
%%    Exit: (11) 2 is max(2, 1) ? 
%%    Exit: (10) maxList1a([2, 1], 2) ? 
%%    Call: (10) _20386498 is max(3, 2) ? 
%%    Exit: (10) 3 is max(3, 2) ? 
%%    Exit: (9) maxList1a([3, 2, 1], 3) ? 
%%    Call: (9) _20386242 is max(4, 3) ? 
%%    Exit: (9) 4 is max(4, 3) ? 
%%    Exit: (8) maxList1a([4, 3, 2, 1], 4) ? 
%% X = 4 ;
%%    Redo: (11) maxList1a([1], _20386488) ? 
%%    Call: (12) maxList1a([], _20386488) ? 
%%    Fail: (12) maxList1a([], _20386488) ? 
%%    Fail: (11) maxList1a([1], _20386488) ? 
%%    Fail: (10) maxList1a([2, 1], _20386488) ? 
%%    Fail: (9) maxList1a([3, 2, 1], _20386488) ? 
%%    Fail: (8) maxList1a([4, 3, 2, 1], _20386242) ? 
%% false.

%% [trace] 145 ?- maxList2([4, 3, 2, 1], X).
%%    Call: (8) maxList2([4, 3, 2, 1], _20387400) ? 
%%    Call: (9) maxList2([3, 2, 1], _20387400, 4) ? 
%%    Call: (10) 4>=3 ? 
%%    Exit: (10) 4>=3 ? 
%%    Call: (10) maxList2([2, 1], _20387400, 4) ? 
%%    Call: (11) 4>=2 ? 
%%    Exit: (11) 4>=2 ? 
%%    Call: (11) maxList2([1], _20387400, 4) ? 
%%    Call: (12) 4>=1 ? 
%%    Exit: (12) 4>=1 ? 
%%    Call: (12) maxList2([], _20387400, 4) ? 
%%    Exit: (12) maxList2([], 4, 4) ? 
%%    Exit: (11) maxList2([1], 4, 4) ? 
%%    Exit: (10) maxList2([2, 1], 4, 4) ? 
%%    Exit: (9) maxList2([3, 2, 1], 4, 4) ? 
%%    Exit: (8) maxList2([4, 3, 2, 1], 4) ? 
%% X = 4 ;
%%    Redo: (11) maxList2([1], _20387400, 4) ? 
%%    Call: (12) 1>4 ? 
%%    Fail: (12) 1>4 ? 
%%    Fail: (11) maxList2([1], _20387400, 4) ? 
%%    Redo: (10) maxList2([2, 1], _20387400, 4) ? 
%%    Call: (11) 2>4 ? 
%%    Fail: (11) 2>4 ? 
%%    Fail: (10) maxList2([2, 1], _20387400, 4) ? 
%%    Redo: (9) maxList2([3, 2, 1], _20387400, 4) ? 
%%    Call: (10) 3>4 ? 
%%    Fail: (10) 3>4 ? 
%%    Fail: (9) maxList2([3, 2, 1], _20387400, 4) ? 
%%    Fail: (8) maxList2([4, 3, 2, 1], _20387400) ? 
%% false.



%% [trace] 146 ?- maxList3([4, 3, 2, 1], X).
%%    Call: (8) maxList3([4, 3, 2, 1], _20388558) ? 
%%    Call: (9) maxList3([3, 2, 1], _20388558, 4) ? 
%%    Call: (10) _20388834 is max(3, 4) ? 
%%    Exit: (10) 4 is max(3, 4) ? 
%%    Call: (10) maxList3([2, 1], _20388558, 4) ? 
%%    Call: (11) _20388840 is max(2, 4) ? 
%%    Exit: (11) 4 is max(2, 4) ? 
%%    Call: (11) maxList3([1], _20388558, 4) ? 
%%    Call: (12) _20388846 is max(1, 4) ? 
%%    Exit: (12) 4 is max(1, 4) ? 
%%    Call: (12) maxList3([], _20388558, 4) ? 
%%    Exit: (12) maxList3([], 4, 4) ? 
%%    Exit: (11) maxList3([1], 4, 4) ? 
%%    Exit: (10) maxList3([2, 1], 4, 4) ? 
%%    Exit: (9) maxList3([3, 2, 1], 4, 4) ? 
%%    Exit: (8) maxList3([4, 3, 2, 1], 4) ? 
%% X = 4.
