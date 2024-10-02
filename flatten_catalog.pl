#!/opt/local/bin/swipl -q -t main -f
%%  -*- Mode: Prolog -*-
%   Name:               flatten_catalog.pl
%
%   Started:            Sun Jul  7 17:54:00 2024
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

%:- module(flatten_catalog, []).

%% (flatten-2 '()) => NIL
%% (flatten-2 'a) => (A)

%% (defun flatten-2 (obj)
%%   (cond ((null obj) '()) ; NIL not wrapped in another list. Squashed later by APPEND
%%         ((atom obj) (list obj))
%%         (t (append (flatten-2 (car obj))
%%                    (flatten-2 (cdr obj)))) ) )

flatten_1([], []).
flatten_1(X, [X]) :-
    X \= [],
    X \= [_|_].
flatten_1([H|T], L) :-
    flatten_1(H, H1),
    flatten_1(T, T1),
    append(H1, T1, L).
    

%% (defun flatten-7a (obj)
%%   (cond ((null obj) '())
%%         ((atom obj) (list obj))
%%         (t (nconc (flatten-7a (first obj))
%%                   (flatten-7a (rest obj)))) ))

%% (defun flatten-7 (l)
%%   "returns all non-conses in tree L in a single fresh list"
%% ;;;
%% ;;;    Kills embedded NIL's (which are "non-conses"!)
%% ;;;    
%%   (cond ((null l) nil)
%%         ((consp l) (nconc (flatten-7 (first l))
%%                           (flatten-7 (rest l))))
%%         (t (list l))))
%% ------------------------------------------------------------


%% These 2 are effectively the same. They skip a lot of CONSing for shallowly-nested lists (especially unnested lists!)
%% (defun flatten (l)
%%   (cond ((endp l) '())
%%         ((listp (first l)) (append (flatten (first l)) (flatten (rest l))))
%%         (t (cons (first l) (flatten (rest l)))) ))

%% (defun flatten-3 (obj)
%%   (cond ((atom obj) obj)
%%         ((atom (car obj))
%%          (cons (car obj) (flatten-3 (cdr obj))))
%%         (t (append (flatten-3 (car obj))
%%                    (flatten-3 (cdr obj)))) ))

%% Prolog inspired variants:
%% (defun flatten-append (l)
%%   (cond ((endp l) '())
%%         ((null (first l)) (flatten-append (rest l)))
%%         ((consp (first l)) (append (flatten-append (first l)) (flatten-append (rest l))))
%%         (t (cons (first l) (flatten-append (rest l)))) ))

flatten_2([], []).
flatten_2([[]|T], L) :-
    flatten_2(T, L).
flatten_2([H|T], L) :-
    H = [_|_],
    flatten_2(H, H1),
    flatten_2(T, T1),
    append(H1, T1, L).
flatten_2([H|T], [H|L]) :-
    H \= [],
    H \= [_|_],
    flatten_2(T, L).

%% (defun flatten-3 (obj)
%%   (cond ((atom obj) obj) ; Only possible on initial call.
%%         ((null (car obj)) (flatten-3 (cdr obj)))
%%         ((atom (car obj))
%%          (cons (car obj) (flatten-3 (cdr obj))))
%%         (t (append (flatten-3 (car obj))
%%                    (flatten-3 (cdr obj)))) ))

flatten_3(X, X) :-
%    X \= [],
    X \= [_|_].
flatten_3([[]|T], L) :-
    flatten_3(T, L).
flatten_3([H|T], [H|L]) :-
    H \= [],
    H \= [_|_],
    flatten_3(T, L).
flatten_3([H|T], L) :-
    H = [_|_],
    flatten_3(H, H1),
    flatten_3(T, T1),
    append(H1, T1, L).
    
%% ------------------------------------------------------------
%% This one is a little weird:
%% - Start by handling initial atomic arg
%% - Atoms (including NIL) are wrapped as singleton lists
%% - We look for the end of the current list and skip flattening the CDR
%% - Otherwise APPEND
%% (defun flatten-4 (obj)
%%   (labels ((flatten-aux (obj)
%%              (cond ((atom obj) (list obj))
%%                    ((null (cdr obj)) ;We are at the last element in list
%%                     (flatten-aux (car obj)))
%%                    (t (append (flatten-aux (car obj))
%%                               (flatten-aux (cdr obj)))) )))
%%     (if (atom obj)
%%         obj
%%         (flatten-aux obj))) )

%% (flatten-4 '()) => NIL
%% (flatten-4 'a) => A
%% (flatten-4 '(a b () c d () e)) => (A B NIL C D NIL E)

%% Removes NILs
%% (defun *flatten-4 (obj)
%%   (labels ((flatten-aux (obj)
%%              (cond ((null obj) obj)
%%                    ((atom obj) (list obj))
%%                    ((null (cdr obj)) ;We are at the last element in list
%%                     (flatten-aux (car obj)))
%%                    (t (append (flatten-aux (car obj))
%%                               (flatten-aux (cdr obj)))) )))
%%     (if (atom obj)
%%         obj
%%         (flatten-aux obj))) )
%% ------------------------------------------------------------
%% ;;;
%% ;;;    Recursive (non-APPEND)
%% ;;;    
%% ------------------------------------------------------------
%% Weird hoist. All clauses are necessary.
%% (defun smash (l)
%%   (cond ((null l) '())
%%         ((null (car l)) (smash (cdr l)))
%%         ((atom (car l)) (cons (car l) (smash (cdr l))))
%%         ((atom (caar l)) (cons (caar l) (smash (cons (cdar l) (cdr l)))) )
%%         (t (smash (cons (smash (car l)) (cdr l)))) ))

smash([], []).
smash([[]|T], L) :-
    smash(T, L).
smash([H|T], [H|L]) :-
    H \= [],
    H \= [_|_],
    smash(T, L).
smash([[H|T]|T1], [H|L]) :-
    H \= [_|_],
    smash([T|T1], L).
smash([[[H|T]|T1]|T2], L) :-
    smash([[H|T]|T1], L1),
    smash([L1|T2], L).
%% ------------------------------------------------------------
%% Hoist
%% These 3 are the same except for the corner case below.
%% (defun flatten-2020 (tree)
%%   (cond ((atom tree) tree) ; Return initial atom as is. This also supports dotted lists.
%%         ((null (car tree)) (flatten-2020 (cdr tree)))
%%         ((atom (car tree)) (cons (car tree) (flatten-2020 (cdr tree))))
%%         (t (flatten-2020 (cons (car (car tree)) (cons (cdr (car tree)) (cdr tree)))) )))

%% (defun flatten-8 (obj)
%%   (cond ((endp obj) '())
%%         ((listp (first obj))
%%          (cond ((endp (first obj)) (flatten-8 (rest obj)))
%%                (t (flatten-8 (cons (first (first obj))
%%                                    (cons (rest (first obj)) (rest obj)))) )))
%%         (t (cons (first obj) (flatten-8 (rest obj)))) ))

%% (defun flatten-2011 (obj)
%%   (cond ((null obj) obj)
%%         ((null (first obj)) (flatten-2011 (rest obj)))
%%         ((atom (first obj)) (cons (first obj) (flatten-2011 (rest obj))))
%%         (t (flatten-2011 (list* (first (first obj)) (rest (first obj)) (rest obj)))) ))

flatten_4(X, X) :-
    X \= [_|_].
flatten_4([[]|T], L) :-
    flatten_4(T, L).
flatten_4([H|T], [H|L]) :-
    H \= [],
    H \= [_|_],
    flatten_4(T, L).
flatten_4([[H|T]|T1], L) :-
    flatten_4([H|[T|T1]], L).

%% Variant
%% (defun flatten-2012 (obj)
%%   (cond ((null obj) obj)                                                                ; A
%%         ((null (first obj)) (flatten-2012 (rest obj)))                                  ; B
%%         ((atom (first obj)) (cons (first obj) (flatten-2012 (rest obj))))               ; D
%%         (t (destructuring-bind ((head . tail) . rest) obj
%%              (flatten-2012 (list* head tail rest)))) ))                                 ; C

%% (flatten-2020 'a) => A
%% (flatten-8 'a) => Error: The value A is not of the expected type LIST.
%% (flatten-2011 'a) => Error: The value A is not of the expected type LIST.

%% (flatten-2020 '()) => NIL
%% (flatten-8 '()) => NIL
%% (flatten-2011 '()) => NIL

%% (flatten-2020 '(a b () c d)) => (A B C D)
%% (flatten-8 '(a b () c d)) => (A B C D)
%% (flatten-2011 '(a b () c d)) => (A B C D)

%% (flatten-2020 '((a . b) (c . d))) => (A B C D)
%% (flatten-8 '((a . b) (c . d))) => (A B C D)
%% (flatten-2011 '((a . b) (c . d))) => (A B C D)
%% ------------------------------------------------------------
%% ;;;
%% ;;;    Recursive w/ accumulator
%% ;;;    
%% Nested calls to FLATTEN. Stack only grows to depth of nesting.
%% The first 2 fail for dotted lists:
%% (flatten '((a . b) (c . d))) => Error: The value B is not of the expected type LIST.
%% The 3rd one (On Lisp) works:
%% (flatten '((a . b) (c . d))) => (A B C D)
%% ------------------------------------------------------------
%% Depth first traversal
%% (defun flatten (l)
%%   (labels ((flatten-aux (l result)
%%              (cond ((endp l) result)
%%                    ((listp (first l)) (flatten-aux (rest l) (flatten-aux (first l) result)))
%%                    (t (flatten-aux (rest l) (cons (first l) result)))) ))
%%     (nreverse (flatten-aux l '()))))

%% Equivalent (见 FLATTEN-DFS-Q)
%% (defun flatten (l)
%%   (labels ((flatten-aux (l result)
%%              (cond ((null l) result)
%%                    ((atom l) (cons l result))
%%                    (t (flatten-aux (rest l) (flatten-aux (first l) result)))) ))
%%     (nreverse (flatten-aux l '()))))
%% ------------------------------------------------------------
%% (defun flatten-1 (obj &optional results)
%%   (cond ((null obj) results)
%%         ((atom obj) (cons obj results))
%%         (t (flatten-1 (car obj)
%%                       (flatten-1 (cdr obj) results))) ) )

%% On Lisp
%% (defun flatten-6 (x)
%%   (labels ((rec (x acc)
%%              (cond ((null x) acc)
%%                    ((atom x) (cons x acc))
%%                    (t (rec (car x) (rec (cdr x) acc))))))
%%     (rec x nil))) 
%% ;;
%% ;; My translation:
%% ;;
%% (defun flatten (obj)
%%   (labels ((flatten-aux (obj results)
%%              (cond ((null obj) results)
%%                    ((atom obj) (cons obj results))
%%                    (t (flatten-aux (car obj)
%%                                    (flatten-aux (cdr obj) results)))) ))
%%     (flatten-aux obj '())))

%% This is essentially the same (compare the DFS above):
%% (defun flatten (l)
%%   (labels ((flatten-aux (l result)
%%              (cond ((endp l) result)
%%                    ((listp (first l)) (flatten-aux (first l) (flatten-aux (rest l) result)))
%%                    (t (cons (first l) (flatten-aux (rest l) result)))) ))
%%     (flatten-aux l '())))
%% ------------------------------------------------------------
%% ;;;
%% ;;;    Tail-recursive w/ accumulator
%% ;;;    
%% Hoist. Accumulate result in reverse head-to-tail.
%% These are essentially identical. Only differ for the one edge case.
%% (defun flatten-8a (obj)
%%   (labels ((flatten-aux (obj result)
%%              (cond ((endp obj) (nreverse result))
%%                    ((listp (first obj))
%%                     (cond ((endp (first obj)) (flatten-aux (rest obj) result))
%%                           (t (flatten-aux (cons (first (first obj))
%%                                                 (cons (rest (first obj)) (rest obj)))
%%                                           result))))
%%                    (t (flatten-aux (rest obj) (cons (first obj) result)))) ))
%%     (flatten-aux obj '())))

%% (defun flatten-2011a (obj)
%%   (labels ((flatten-2011a-aux (obj result)
%%              (cond ((null obj) (nreverse result))
%%                    ((null (first obj)) (flatten-2011a-aux (rest obj) result))
%%                    ((atom (first obj)) (flatten-2011a-aux (rest obj) (cons (first obj) result)))
%%                    (t (flatten-2011a-aux (list* (first (first obj)) (rest (first obj)) (rest obj)) result)))) )
%%     (flatten-2011a-aux obj '())))

%% Minor variations:
%% (defun flatten (tree)
%%   (labels ((flatten-aux (tree result)
%%              (cond ((null tree) (nreverse result))
%%                    ((null (car tree)) (flatten-aux (cdr tree) result))
%%                    ((atom (car tree)) (flatten-aux (cdr tree) (cons (car tree) result)))
%%                    (t (flatten-aux (list* (caar tree) (cdar tree) (cdr tree)) result)))) )
%%     (if (atom tree)
%%         tree
%%         (flatten-aux tree '()))) )

%% (defun flatten (tree)
%%   (labels ((flatten-aux (tree result)
%%              (cond ((null tree) (nreverse result))
%%                    ((null (car tree)) (flatten-aux (cdr tree) result))
%%                    ((atom (car tree)) (flatten-aux (cdr tree) (cons (car tree) result)))
%%                    (t (destructuring-bind ((head . tail1) . tail2) tree
%%                         (flatten-aux (list* head tail1 tail2) result)))) ))
%%     (if (atom tree)
%%         tree
%%         (flatten-aux tree '()))) )

flatten_5(X, X) :-
    X \= [_|_].
flatten_5(L, F) :-
    L = [_|_],
    flatten_5(L, F, []).
flatten_5([], F, R) :-
    reverse(R, F).
flatten_5([[]|T], F, R) :-
    flatten_5(T, F, R).
flatten_5([H|T], F, R) :-
    H \= [],
    H \= [_|_],
    flatten_5(T, F, [H|R]).
flatten_5([[H|T]|T1], F, R) :-
    flatten_5([H,T|T1], F, R).

flatten2([], []).
flatten2([[]|T], L) :-
    flatten2(T, L).
flatten2([H|T], [H|L]) :-
    H \= [],
    H \= [_|_],
    flatten2(T, L).
flatten2([[H|T1]|T2], L) :-
    flatten2([H,T1|T2], L).

build_list(0, []).
build_list(N, [N|T]) :-
    N > 0,
    N1 is N - 1,
    build_list(N1, T).


%% (flatten-8a 'a) => Error: The value A is not of the expected type LIST.
%% (flatten-2011a 'a) => Error: The value A is not of the expected type LIST.
%% (flatten 'a) => A

%% (flatten-8a '()) => NIL
%% (flatten-2011a '()) => NIL
%% (flatten '()) => NIL

%% (flatten-8a '(a b () c d () e)) => (A B C D E)
%% (flatten-2011a '(a b () c d () e)) => (A B C D E)
%% (flatten '(a b () c d () e)) => (A B C D E)
%% ------------------------------------------------------------
%% ;;;
%% ;;;    Queue
%% ;;;    
%% ------------------------------------------------------------
%% Hoist. Tail-recursive accumulator. RESULT is queue, no need to reverse.
%% (defun flatten-q (tree)
%%   (labels ((flatten-aux (tree result)
%%              (cond ((null tree) (elements result))
%%                    ((null (car tree)) (flatten-aux (cdr tree) result))
%%                    ((atom (car tree)) (flatten-aux (cdr tree) (enqueue result (car tree))))
%%                    (t (destructuring-bind ((head . tail1) . tail2) tree
%%                         (flatten-aux (list* head tail1 tail2) result)))) ))
%%     (if (atom tree)
%%         tree
%%         (flatten-aux tree (make-linked-queue)))) )

%% (defun flatten-q (tree)
%%   (labels ((flatten-aux (tree result)
%%              (if (null tree)
%%                  (elements result)
%%                  (destructuring-bind (car . cdr) tree
%%                    (cond ((null car) (flatten-aux cdr result))
%%                          ((atom car) (flatten-aux cdr (enqueue result car)))
%%                          (t (destructuring-bind (car1 . cdr1) car
%%                               (flatten-aux (list* car1 cdr1 cdr) result)))) ))))
%%     (if (atom tree)
%%         tree
%%         (flatten-aux tree (make-linked-queue)))) )
%% ------------------------------------------------------------
%% Depth first traversal with queue accumulator.
%% (defun flatten-dfs-q (tree)
%%   (labels ((flatten-aux (tree result)
%%              (cond ((null tree) result)
%%                    ((atom tree) (enqueue result tree))
%%                    (t (flatten-aux (cdr tree) (flatten-aux (car tree) result)))) ))
%%     (if (atom tree)
%%         tree
%%         (elements (flatten-aux tree (make-linked-queue)))) ))
%% ------------------------------------------------------------
%% ;;;
%% ;;;    Hybrid
%% ;;;
%% ------------------------------------------------------------
%% (defun flatten-5 (obj)
%%   (let ((result '()))
%%     (dolist (elt obj)
%%       (if (atom elt)
%%           (push elt result)
%%           (dolist (elt1 (flatten-5 elt))
%%             (push elt1 result))))
%%     (nreverse result)) )

%% (defun flatten-6 (obj)
%%   (let ((result '()))
%%     (dolist (elt obj (nreverse result))
%%       (if (atom elt)
%%           (when elt (push elt result))
%%           (dolist (elt1 (flatten-6 elt))
%%             (when elt1 (push elt1 result)))) )))

%% Minor variation:
%% (flatten-5 '(a (b () (c (d ()))))) => (A B NIL C D NIL)
%% (flatten-6 '(a (b () (c (d ()))))) => (A B C D)

%% Similar w/ queue:
%% (defun flatten-5a* (obj)
%%   (let ((q (make-linked-queue)))
%%     (dolist (elt obj (elements q))
%%       (if (atom elt)
%%           (enqueue q elt)
%%           (dolist (nested-elt (flatten-5a* elt))
%%             (enqueue q nested-elt)))) ))

%% (defun flatten-5a (obj)
%%   (let ((q (make-linked-queue)))
%%     (dolist (elt obj (elements q))
%%       (if (atom elt)
%%           (when elt (enqueue q elt))
%%           (dolist (nested-elt (flatten-5a elt))
%%             (when nested-elt (enqueue q nested-elt)))) )))
%% ------------------------------------------------------------
%% (defun flatten-map (x)
%%   (mapcan #'(lambda (x)
%%               (if (atom x)
%%                   (mklist x)
%%                   (flatten-map x)))
%% 	      x))
%% ------------------------------------------------------------
%% (defun dotted-pair-p (putative-pair)
%%   (and (consp putative-pair)
%%        (cdr putative-pair)
%%        (not (consp (cdr putative-pair)))))

%% (defun flatten (list)
%%   "Flattens LIST. Does not handle circular lists but does handle dotted lists."
%%   (labels ((rec (list)
%%              (cond ((atom list)
%%                     (list list))
%%                    ((dotted-pair-p list)
%%                     (nconc (rec (car list)) (rec (cdr list))))
%%                    (t               
%%                     (mapcan1 #'rec list)))))
%%     (declare (dynamic-extent rec))
%%     (if (atom list)
%%       list
%%       (rec list))))
%% ------------------------------------------------------------
%% Weird ABCL implementation!
%% (defun flatten (list)
%%   (labels ((rflatten (list accumluator)
%% 	   (dolist (element list)
%% 	     (if (listp element)
%% 		 (setf accumluator (rflatten element accumluator)) ; ?!??!
%% 		 (push element accumluator)))
%% 	   accumluator))
%%     (let (result)
%%       (reverse (rflatten list result)))))
%% ------------------------------------------------------------
%% ;;;
%% ;;;    Esoteric
%% ;;;
%% ------------------------------------------------------------
%% (defun mklist (obj)
%%   "Make a list out of the object if it isn't already."  ; LMH
%%   (if (listp obj) obj (list obj)))

%% (defun trec (rec &optional (base #'identity))
%%   (labels 
%%     ((self (tree)
%%        (if (atom tree)
%%            (if (functionp base)
%%                (funcall base tree)
%%                base)
%%            (funcall rec tree 
%%                         #'(lambda () 
%%                             (self (car tree)))
%%                         #'(lambda () 
%%                             (if (cdr tree)
%%                                 (self (cdr tree))))))))
%%     #'self))

%% (defmacro atrec (rec &optional (base 'it))
%%   "cltl2 version"
%%   (let ((lfn (gensym)) (rfn (gensym)))
%%     `(trec #'(lambda (it ,lfn ,rfn)
%%                (symbol-macrolet ((left (funcall ,lfn))
%%                                  (right (funcall ,rfn)))
%%                  ,rec))
%%            #'(lambda (it) ,base))))

%% (defmacro on-trees (rec base &rest trees)
%%   "Anaphoric tree recursion, for defining named functions"   ; LMH
%%   `(funcall (atrec ,rec ,base) ,@trees))

%% (defun flatten (tree)
%%   (on-trees (nconc left right) (mklist it) tree))
%% ------------------------------------------------------------
