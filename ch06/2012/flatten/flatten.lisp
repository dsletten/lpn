(load "/Users/dsletten/lisp/packages/lang.lisp")
(load "/Users/dsletten/lisp/packages/collections.lisp")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;    Canonical versions
;;;    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    FLATTEN below
;;    Recursive calls only involve lists. Atoms are handled directly.
;;    
(defun flatten-append (l)
  (cond ((endp l) '())
        ((listp (first l)) (append (flatten-append (first l)) (flatten-append (rest l))))
        (t (cons (first l) (flatten-append (rest l)))) ))

;;;
;;;    Prolog style
;;;    
(defun flatten-append (l)
  (cond ((endp l) '())
        ((null (first l)) (flatten-append (rest l)))
        ((consp (first l)) (append (flatten-append (first l)) (flatten-append (rest l))))
        (t (cons (first l) (flatten-append (rest l)))) ))

;;     *FLATTEN-2 below
;;     All elements handled recursively. Recursive call may pass in atom, which is then wrapped in temporary list.
;;     
(defun flatten-append-a (obj)
  (cond ((null obj) '())
        ((atom obj) (list obj))
        (t (append (flatten-append-a (car obj))
                   (flatten-append-a (cdr obj)))) ) )

;;    FLATTEN-Y below
(defun flatten-no-append (l)
  (labels ((flatten-aux (l result)
             (cond ((endp l) result)
                   ((listp (first l)) (flatten-aux (first l) (flatten-aux (rest l) result)))
                   (t (cons (first l) (flatten-aux (rest l) result)))) ))
    (flatten-aux l '())))

;;     FLATTEN-2012A below
(defun flatten-prolog (obj)
  (labels ((flatten-aux (obj result)
             (cond ((null obj) (nreverse result))
                   ((null (first obj)) (flatten-aux (rest obj) result))
                   ((atom (first obj)) (flatten-aux (rest obj) (cons (first obj) result)))
                   (t (destructuring-bind ((head . tail) . rest) obj
                        (flatten-aux (list* head tail rest) result)))) ))
    (flatten-aux obj '())))

;;;
;;;    Functions with names ending in * preserve embedded NIL...
;;;    (flatten-5* '(a () ((b) c))) => (A NIL B C)
;;;    

;;;
;;;    Functions with names starting in * create recursive calls on atomic top-level elements:
;;;    (*flatten-2 'a) => (A)
;;;    [The recursive call may be in a nested AUX function.]
;;;    [Those without the leading * may not accept atoms as args:
;;;    (flatten-5 'a) =>  TYPE-ERROR]
;;;    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;    Naive using APPEND
;;;    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun flatten (l)
  (cond ((endp l) '())
        ((listp (first l)) (append (flatten (first l)) (flatten (rest l))))
        (t (cons (first l) (flatten (rest l)))) ))

;;;
;;;    Even worse...APPEND plus transient lists of atoms.
;;;    
(defun *flatten-2 (obj)
  (cond ((null obj) '())
        ((atom obj) (list obj))
        (t (append (*flatten-2 (car obj))
                   (*flatten-2 (cdr obj)))) ) )
;;;
;;;    These are essentially identical to *FLATTEN-2
;;;    
;; (defun *flatten-7 (l)
;;   (cond ((null l) nil)
;;         ((consp l) (nconc (*flatten-7 (first l))
;;                           (*flatten-7 (rest l))))
;;         (t (list l))))

;; (defun *flatten-7a (obj)
;;   (cond ((null obj) '())
;;         ((atom obj) (list obj))
;;         (t (nconc (*flatten-7a (first obj))
;;                   (*flatten-7a (rest obj)))) ))

(defun flatten-3* (obj)
  (cond ((atom obj) obj)
        ((atom (car obj))
         (cons (car obj) (flatten-3* (cdr obj))))
        (t (append (flatten-3* (car obj))
                   (flatten-3* (cdr obj)))) ))

;;;
;;;    More complicated than *FLATTEN-2 and FLATTEN-3* in order to get rid of the *'s!
;;;    
(defun flatten-3 (obj)
  (cond ((atom obj) obj) ; Only possible on initial call.
        ((null (car obj)) (flatten-3 (cdr obj)))
        ((atom (car obj))
         (cons (car obj) (flatten-3 (cdr obj))))
        (t (append (flatten-3 (car obj))
                   (flatten-3 (cdr obj)))) ))

(defun *flatten-4* (obj)
  (labels ((flatten-aux (obj)
             (cond ((atom obj) (list obj))
                   ((null (cdr obj)) ;We are at the last element in list
                    (flatten-aux (car obj)))
                   (t (append (flatten-aux (car obj))
                              (flatten-aux (cdr obj)))) )))
    (if (atom obj)
        obj
        (flatten-aux obj))) )

(defun *flatten-4 (obj)
  (labels ((flatten-aux (obj)
             (cond ((null obj) obj)
                   ((atom obj) (list obj))
                   ((null (cdr obj)) ;We are at the last element in list
                    (flatten-aux (car obj)))
                   (t (append (flatten-aux (car obj))
                              (flatten-aux (cdr obj)))) )))
    (if (atom obj)
        obj
        (flatten-aux obj))) )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;    No APPEND - nested recursive call: (flatten ... (flatten ...))
;;;    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun flatten-x (l)
  (labels ((flatten-aux (l result)
             (cond ((endp l) result)
                   ((listp (first l)) (flatten-aux (rest l) (flatten-aux (first l) result)))
                   (t (flatten-aux (rest l) (cons (first l) result)))) ))
    (nreverse (flatten-aux l '()))) )

(defun flatten-y (l)
  (labels ((flatten-aux (l result)
             (cond ((endp l) result)
                   ((listp (first l)) (flatten-aux (first l) (flatten-aux (rest l) result)))
                   (t (cons (first l) (flatten-aux (rest l) result)))) ))
    (flatten-aux l '())))

(defun *flatten-1 (obj &optional results)
  (cond ((null obj) results)
        ((atom obj) (cons obj results))
        (t (*flatten-1 (car obj)
                       (*flatten-1 (cdr obj) results))) ) )

(defun smash (l)
  (cond ((null l) '())
        ((null (car l)) (smash (cdr l)))
        ((atom (car l)) (cons (car l) (smash (cdr l))))
        ((atom (caar l)) (cons (caar l) (smash (cons (cdar l) (cdr l)))) )
        (t (smash (cons (smash (car l)) (cdr l)))) ))

(defun *flatten-6 (obj)
  (labels ((flatten-aux (obj results)
             (cond ((null obj) results)
                   ((atom obj) (cons obj results))
                   (t (flatten-aux (car obj)
                                   (flatten-aux (cdr obj) results)))) ))
    (flatten-aux obj '()))) 
(defun *flatten-6 (obj)
  (flatten-aux obj '()))
(defun flatten-aux (obj results)
  (cond ((null obj) results)
        ((atom obj) (cons obj results))
        (t (flatten-aux (car obj)
                        (flatten-aux (cdr obj) results)))) )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;    Weird Prolog style
;;;
;;;    When these versions encounter a CAR which is itself a CONS, they "hoist" the CAR of this nested
;;;    CONS up as the new CAR of the tree. The CADR of the tree then points to the CDR of the nested CONS.
;;;    The hoisted objected may also be a CONS to an arbitrary level of nesting. In any case, it is
;;;    processed by a recursive call.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun flatten-8 (obj)
  (cond ((endp obj) '())                                   ; A
        ((listp (first obj))
         (cond ((endp (first obj)) (flatten-8 (rest obj))) ; B
               (t (flatten-8 (cons (first (first obj))     ; C
                                   (cons (rest (first obj)) (rest obj)))) )))
        (t (cons (first obj) (flatten-8 (rest obj)))) ))   ; D

(defun flatten-8a (obj)
  (labels ((flatten-aux (obj result)
             (cond ((endp obj) (nreverse result))
                   ((listp (first obj))
                    (cond ((endp (first obj)) (flatten-aux (rest obj) result))
                          (t (flatten-aux (cons (first (first obj))
                                                (cons (rest (first obj)) (rest obj)))
                                          result))))
                   (t (flatten-aux (rest obj) (cons (first obj) result)))) ))
    (flatten-aux obj '())))

(defun flatten-2011 (obj)
  (cond ((null obj) obj)                                                                ; A
        ((null (first obj)) (flatten-2011 (rest obj)))                                  ; B
        ((atom (first obj)) (cons (first obj) (flatten-2011 (rest obj))))               ; D
        (t (flatten-2011 (list* (first (first obj)) (rest (first obj)) (rest obj)))) )) ; C

(defun flatten-2011a (obj)
  (labels ((flatten-2011a-aux (obj result)
             (cond ((null obj) (nreverse result))
                   ((null (first obj)) (flatten-2011a-aux (rest obj) result))
                   ((atom (first obj)) (flatten-2011a-aux (rest obj) (cons (first obj) result)))
                   (t (flatten-2011a-aux (list* (first (first obj)) (rest (first obj)) (rest obj)) result)))) )
    (flatten-2011a-aux obj '())))

(defun flatten-2012 (obj)
  (cond ((null obj) obj)                                                                ; A
        ((null (first obj)) (flatten-2012 (rest obj)))                                  ; B
        ((atom (first obj)) (cons (first obj) (flatten-2012 (rest obj))))               ; D
        (t (destructuring-bind ((head . tail) . rest) obj
             (flatten-2012 (list* head tail rest)))) ))                                 ; C

(defun flatten-2012a (obj)
  (labels ((flatten-2012a-aux (obj result)
             (cond ((null obj) (nreverse result))
                   ((null (first obj)) (flatten-2012a-aux (rest obj) result))
                   ((atom (first obj)) (flatten-2012a-aux (rest obj) (cons (first obj) result)))
                   (t (destructuring-bind ((head . tail) . rest) obj
                        (flatten-2012a-aux (list* head tail rest) result)))) ))
    (flatten-2012a-aux obj '())))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;    Hybrid iterative/recursive
;;;    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun flatten-5 (obj)
  (let ((result '()))
    (dolist (elt obj (nreverse result))
      (if (atom elt)
          (when elt (push elt result))
          (dolist (elt1 (flatten-5 elt))
            (when elt1 (push elt1 result)))) )))

(defun flatten-5a (obj)
  (let ((q (collections:make-linked-queue)))
    (dolist (elt obj (collections:elements q))
      (if (atom elt)
          (when elt (collections:enqueue q elt))
          (dolist (nested-elt (flatten-5a elt))
            (when nested-elt (collections:enqueue q nested-elt)))) )))

(defun flatten-5* (obj)
  (let ((result '()))
    (dolist (elt obj (nreverse result))
      (if (atom elt)
          (push elt result)
          (dolist (elt1 (flatten-5* elt))
            (push elt1 result)))) ))

(defun flatten-5a* (obj)
  (let ((q (collections:make-linked-queue)))
    (dolist (elt obj (collections:elements q))
      (if (atom elt)
          (collections:enqueue q elt)
          (dolist (nested-elt (flatten-5a* elt))
            (collections:enqueue q nested-elt)))) ))

(defun flatten-map (x)
  (mapcan #'(lambda (x)
              (if (atom x)
                  (lang:mklist x)
                  (flatten-map x)))
	      x))



(defun make-random-tree (generator)
  (if (< (random 1d0) 0.5)
      (list (funcall generator))
      (cons (make-random-tree generator)
            (make-random-tree generator))))
;; (let ((i 0)) (make-random-tree #'(lambda () (prog1 i (incf i)))))
;; (let ((i 0)) (make-random-tree #'(lambda () (prog1 (code-char (+ i (char-code #\A))) (incf i)))))  

;; (((((((((((0) ((((1) 2) (3) 4) 5) 6) 7) 8) ((9) (10) 11) (12)
;;        (((13) (14) 15) 16) ((17) (18) (19) 20) 21)
;;       22)
;;      23)
;;     (24) ((25) 26) ((27) ((((28) 29) 30) 31) ((32) (33) 34) 35) ((36) 37)
;;     ((38) ((39) 40) (41) 42) ((43) 44)
;;     ((((45) (46)
;;        (((47) (48)
;;          (((((49) 50)
;;             (((51) 52) (53)
;;              ((54)
;;               ((((((55) (56) ((57) 58) 59)
;;                   ((((60) ((61) (62) 63) (64) 65) (66) 67) 68) (69)
;;                   (((70) 71) 72) 73)
;;                  74)
;;                 (75) ((((76) 77) 78) 79) (80) 81)
;;                82)
;;               (83) ((84) (85) (((86) 87) 88) 89)
;;               (((((90) 91) (((92) 93) 94) ((95) (96) 97) (98) 99) 100) (101)
;;                (102) 103)
;;               ((104) 105) 106)
;;              (107) 108)
;;             ((109) 110) (111) 112)
;;            (((113) (114) ((115) (116) (117) 118) 119)
;;             ((120) (((121) (122) 123) 124)
;;              ((((125) (126) (127)
;;                 ((((((128) 129)
;;                     ((130)
;;                      ((((((((131) ((132) 133) (134) 135) (136)
;;                            (((137) 138)
;;                             (((139)
;;                               ((140) ((141) 142) ((143) 144)
;;                                ((145) ((146) 147) (148) 149) 150)
;;                               (151) (152) 153)
;;                              154)
;;                             155)
;;                            156)
;;                           ((157) ((158) (159) 160) 161) (162) 163)
;;                          (((164) ((165) 166) 167) (168) (169) 170) (171) 172)
;;                         (173) 174)
;;                        ((((175) 176) 177) (((178) 179) 180) 181) (182) (183)
;;                        (((184)
;;                          ((185) (186)
;;                           (((187) ((188) ((189) (190) 191) 192) 193) (194)
;;                            (195) 196)
;;                           ((197) 198) 199)
;;                          200)
;;                         201)
;;                        202)
;;                       ((((203) 204) (205) ((206) 207) 208) (209) 210) (211)
;;                       (212) (213) ((214) (215) 216) (217) 218)
;;                      (219) 220)
;;                     ((221) 222) 223)
;;                    ((224) (225) ((226) 227)
;;                     ((228)
;;                      ((229) ((230) 231)
;;                       (((232) 233)
;;                        ((((((234) 235) (236) 237) 238)
;;                          ((239) (((240) 241) 242) 243) (244) (245)
;;                          (((246) (247) 248) 249) (250) 251)
;;                         252)
;;                        ((((253) 254) 255) 256) 257)
;;                       258)
;;                      259)
;;                     (260) (261) 262)
;;                    263)
;;                   (264) (((265) (266) 267) 268)
;;                   ((269)
;;                    ((270)
;;                     (((((271) 272) (273) 274)
;;                       (((((275) 276) 277) 278) ((279) (280) 281) 282)
;;                       ((283) 284) 285)
;;                      286)
;;                     287)
;;                    (288) 289)
;;                   (290) 291)
;;                  (292) ((293) ((294) ((295) 296) 297) (298) 299) (300) 301)
;;                 302)
;;                303)
;;               ((304) 305) ((306) 307) 308)
;;              (((309) (310) (311) (312) ((313) 314) (315)
;;                ((((316) 317) (318) 319) 320) (321) 322)
;;               323)
;;              (324)
;;              (((325)
;;                (((((((326) 327) (328) (329) 330) 331)
;;                   (((332) (333) ((334) 335) 336) 337) (338) (339)
;;                   ((((340) (341) 342) (343) 344) 345) 346)
;;                  (347) 348)
;;                 349)
;;                350)
;;               351)
;;              (352) 353)
;;             354)
;;            355)
;;           356)
;;          (357) 358)
;;         359)
;;        (360) 361)
;;       362)
;;      (363) ((((364) (365) (366) 367) 368) (369) 370) 371)
;;     372)
;;    373)
;;   374)
;;  375)
;; (flatten-2012a *)

;; (0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28
;;  29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54
;;  55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80
;;  81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104
;;  105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123
;;  124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142
;;  143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161
;;  162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180
;;  181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199
;;  200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218
;;  219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237
;;  238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256
;;  257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275
;;  276 277 278 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294
;;  295 296 297 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313
;;  314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332
;;  333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349 350 351
;;  352 353 354 355 356 357 358 359 360 361 362 363 364 365 366 367 368 369 370
;;  371 372 373 374 375)

;;;
;;;    Why does FLATTEN-5A perform so poorly?! (CLOS?)
;;;    
;; * (time (dotimes (i 10000) (flatten *monster-tree*)))

;; Evaluation took:
;;   1.180 seconds of real time
;;   0.788062 seconds of total run time (0.731033 user, 0.057029 system)
;;   [ Run times consist of 0.170 seconds GC time, and 0.619 seconds non-GC time. ]
;;   66.78% CPU
;;   3,598,560,392 processor cycles
;;   6 page faults
;;   575,521,168 bytes consed
  
;; NIL
;; * (time (dotimes (i 10000) (flatten-2012a *monster-tree*)))

;; Evaluation took:
;;   0.393 seconds of real time
;;   0.337005 seconds of total run time (0.326736 user, 0.010269 system)
;;   [ Run times consist of 0.043 seconds GC time, and 0.295 seconds non-GC time. ]
;;   85.75% CPU
;;   1,198,620,735 processor cycles
;;   149,918,360 bytes consed
  
;; NIL
;; * (time (dotimes (i 10000) (flatten-5 *monster-tree*)))

;; Evaluation took:
;;   1.661 seconds of real time
;;   0.993759 seconds of total run time (0.937375 user, 0.056384 system)
;;   [ Run times consist of 0.197 seconds GC time, and 0.797 seconds non-GC time. ]
;;   59.84% CPU
;;   5,067,682,414 processor cycles
;;   575,522,080 bytes consed
  
;; NIL
;; * (time (dotimes (i 10000) (flatten-5a *monster-tree*)))

;; Evaluation took:
;;   8.607 seconds of real time
;;   6.695185 seconds of total run time (6.586160 user, 0.109025 system)
;;   [ Run times consist of 0.172 seconds GC time, and 6.524 seconds non-GC time. ]
;;   77.79% CPU
;;   20 lambdas converted
;;   26,261,725,232 processor cycles
;;   726,230,440 bytes consed
  
;; NIL
;; * (time (dotimes (i 10000) (flatten-x *monster-tree*)))

;; Evaluation took:
;;   0.185 seconds of real time
;;   0.110263 seconds of total run time (0.108184 user, 0.002079 system)
;;   [ Run times consist of 0.006 seconds GC time, and 0.105 seconds non-GC time. ]
;;   59.46% CPU
;;   564,413,250 processor cycles
;;   30,081,560 bytes consed
  
;; NIL
;; * (time (dotimes (i 10000) (flatten-y *monster-tree*)))

;; Evaluation took:
;;   0.106 seconds of real time
;;   0.094123 seconds of total run time (0.092110 user, 0.002013 system)
;;   [ Run times consist of 0.008 seconds GC time, and 0.087 seconds non-GC time. ]
;;   88.68% CPU
;;   321,341,958 processor cycles
;;   30,080,800 bytes consed
  
;; NIL
;; * (time (dotimes (i 10000) (*flatten-6 *monster-tree*)))

;; Evaluation took:
;;   0.205 seconds of real time
;;   0.118224 seconds of total run time (0.115642 user, 0.002582 system)
;;   [ Run times consist of 0.007 seconds GC time, and 0.112 seconds non-GC time. ]
;;   57.56% CPU
;;   623,690,770 processor cycles
;;   30,080,576 bytes consed
  
;; NIL
;; * 