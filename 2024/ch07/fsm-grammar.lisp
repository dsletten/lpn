;;;;   Hey, Emacs, this is a -*- Mode: Lisp; Syntax: Common-Lisp -*- file!
;;;;
;;;;   Lisp is a programmable programming language.
;;;;   -- John Foderaro
;;;;
;;;;   Name:               fsm-grammar.lisp
;;;;
;;;;   Started:            Thu Aug  8 02:01:22 2024
;;;;   Modifications:
;;;;
;;;;   Purpose:
;;;;
;;;;
;;;;
;;;;   Calling Sequence:
;;;;
;;;;
;;;;   Inputs:
;;;;
;;;;   Outputs:
;;;;
;;;;   Example:
;;;;
;;;;   Notes:
;;;;
;;;;
(load "/home/slytobias/lisp/packages/core.lisp")
(load "/home/slytobias/lisp/packages/test.lisp")

(defpackage :fsm-grammar (:use :common-lisp :core :test))

(in-package :fsm-grammar)

(defun recognize (string)
  (labels ((s (input)
             (vp (np input)))
           (np (input)
             (n (det input)))
           (vp (input)
             (or (np (v input))
                 (v input)))
           (det (input)
             (case (first input)
               ((a the) (rest input))
               (otherwise nil)))
           (n (input)
             (case (first input)
               ((woman man) (rest input))
               (otherwise nil)))
           (v (input)
             (case (first input)
               (shoots (rest input))
               (otherwise nil))))
    (s string)))

;;;
;;;    Need terminal sentinel to distinguish between NIL as false vs.
;;;    simply end of list once all tokens have been matched.
;;;    (recognize '(the man shoots a woman x)) => T
;;;    This is essentially a "difference list" implementation!
;;;    
(defun recognize (string)
  (labels ((s (input)
             (let ((np (np input)))
               (if (null np)
                   nil
                   (equal '(x) (vp np)))) )
           (np (input)
             (let ((det (det input)))
               (if (null det)
                   nil
                   (n det))))
           (vp (input)
             (let ((v (v input)))
               (if (null v)
                   nil
                   (or (np v) v))))
           (det (input)
             (case (first input)
               ((a the) (rest input))
               (otherwise nil)))
           (n (input)
             (case (first input)
               ((woman man) (rest input))
               (otherwise nil)))
           (v (input)
             (case (first input)
               (shoots (rest input))
               (otherwise nil))))
    (s string)))

(defun recognize (string)
  (labels ((s (input)
             (let ((np (np input)))
               (cond ((eq np :fail) :fail)
                     (t (vp np)))) )
           (np (input)
             (let ((det (det input)))
               (cond ((eq det :fail) :fail)
                     (t (n det)))) )
           (vp (input)
             (let ((v (v input)))
               (cond ((eq v :fail) :fail)
                     ((null v) '())
                     (t (np v)))) )
           (det (input)
             (case (first input)
               ((a the) (rest input))
               (otherwise :fail)))
           (n (input)
             (case (first input)
               ((woman man dog car hat) (rest input))
               (otherwise :fail)))
           (v (input)
             (case (first input)
               ((shoots eats sees) (rest input))
               (otherwise :fail))))
    (null (s string))))

(defun recognize (string)
  (labels ((s (input)
             (multiple-value-bind (validp more) (multiple-value-call #'vp (multiple-value-call #'np (values t input)))
               (and validp
                    (null more))))
           (np (validp input)
             (if validp
                 (multiple-value-call #'n (multiple-value-call #'det (values validp input)))
                 (values nil input)))
           (vp (validp input)
             (if validp
                 (multiple-value-call #'vp2 (multiple-value-call #'vp1 (values validp input)) input)
                 (values nil input)))
           (vp1 (validp input)
             (if validp
                 (multiple-value-call #'np (multiple-value-call #'v (values validp input)))
                 (values nil input)))
           (vp2 (validp input1 input0)
             (if validp
                 (values validp input1)
                 (multiple-value-call #'v (values t input0))))
           (det (validp input)
             (if validp
                 (case (first input)
                   ((a the) (values t (rest input)))
                   (otherwise (values nil input)))
                 (values nil input)))
           (n (validp input)
             (if validp
                 (case (first input)
                   ((woman man) (values t (rest input)))
                   (otherwise (values nil input)))
                 (values nil input)))
           (v (validp input)
             (if validp
                 (case (first input)
                   (shoots (values t (rest input)))
                   (otherwise (values nil input)))
                 (values nil input))))
    (s string)))

