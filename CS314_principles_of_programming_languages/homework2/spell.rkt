#lang racket

; *********************************************
; *  314 Principles of Programming Languages  *
; *  Spring 2019                              *
; *  Student Version                          *
; *********************************************

;; contains "ctv", "A", and "reduce" definitions
(require "include.rkt")

;; contains simple dictionary definition
;(require "dictionary.rkt")

;; -----------------------------------------------------
;; HELPER FUNCTIONS

;; *** CODE FOR ANY HELPER FUNCTION GOES HERE ***

(define atom?
  (lambda (x)
    (not (pair? x))))

(define flatten
  (lambda (l)
    (cond ((null? l) '())
          ((atom? (car l)) (cons (car l) (flatten (cdr l))))
          (else (append (flatten (car l)) (flatten (cdr l)))))))

(define bvlist
  (lambda (list dict)
    (cond ((null? list) cons '())
            (else (flatten(cons (map (car list) dict) (bvlist (cdr list) dict)) ) ))))

(define find
  (lambda (hashfunctionlist word bv default)
    (cond ((null? hashfunctionlist) (or #f default))
          ( (member ((car hashfunctionlist) word) bv) (and #t (find (cdr hashfunctionlist) word bv #t)))
          (else (find '() word bv #f) ))))


(define whyDidYouMakeUsUseReduceThisIsFooFooLame
  (lambda (w x)
    (+ (ctv w) (* 29 x))))
   
  
;; -----------------------------------------------------
;; KEY FUNCTION

(define key
  (lambda (w)
    (reduce whyDidYouMakeUsUseReduceThisIsFooFooLame w 5413)))

;; -----------------------------------------------------
;; EXAMPLE KEY VALUES
;;   (key '(h e l l o))       = 111037761665
;;   (key '(m a y))           = 132038724
;;   (key '(t r e e f r o g)) = 2707963878412931

;; -----------------------------------------------------
;; HASH FUNCTION GENERATORS

(define gen-hash-division-method
   (lambda(size)
     (lambda (x)
       (modulo (key x) size))))
           

(define gen-hash-multiplication-method
  (lambda (size)
    (lambda (x)
      (floor ( * size (- (* (key x) A) (floor(* (key x) A))))))))


;; -----------------------------------------------------
;; EXAMPLE HASH FUNCTIONS AND HASH FUNCTION LISTS

;(define hash-1 (gen-hash-division-method 70111))
;(define hash-2 (gen-hash-division-method 89989))
;(define hash-3 (gen-hash-multiplication-method 700426))
;(define hash-4 (gen-hash-multiplication-method 952))

;(define hashfl-1 (list hash-1 hash-2 hash-3 hash-4))
;(define hashfl-2 (list hash-1 hash-3))
;(define hashfl-3 (list hash-2 hash-3))

;; -----------------------------------------------------
;; EXAMPLE HASH VALUES
;;   to test your hash function implementation
;;
;; ((gen-hash-division-method 70111) '(h e l l o))
;; (hash-1 '(h e l l o))        ==> 26303
;; (hash-1 '(m a y))            ==> 19711
;; (hash-1 '(t r e e f r o g))  ==> 3010
;;
;; (hash-2 '(h e l l o))        ==> 64598
;; (hash-2 '(m a y))            ==> 24861
;; (hash-2 '(t r e e f r o g))  ==> 23090
;;
;; (hash-3 '(h e l l o))        ==> 313800.0
;; (hash-3 '(m a y))            ==> 317136.0
;; (hash-3 '(t r e e f r o g))  ==> 525319.0
;;
;; (hash-4 '(h e l l o))        ==> 426.0
;; (hash-4 '(m a y))            ==> 431.0
;; (hash-4 '(t r e e f r o g))  ==> 714.0

;; -----------------------------------------------------
;; SPELL CHECKER GENERATOR
    
(define gen-checker
  (lambda (hashfunctionlist dict)
    (lambda (w)
      (find hashfunctionlist w (bvlist hashfunctionlist dict) #f))))

;; -----------------------------------------------------
;; EXAMPLE SPELL CHECKERS

;(define checker-1 (gen-checker hashfl-1 dictionary))
;(define checker-2 (gen-checker hashfl-2 dictionary))
;(define checker-3 (gen-checker hashfl-3 dictionary))

;; EXAMPLE APPLICATIONS OF A SPELL CHECKER
;;
;;  (checker-1 '(a r g g g g)) ==> #f
;;  (checker-2 '(h e l l o)) ==> #t
;;  (checker-2 '(a r g g g g)) ==> #f
