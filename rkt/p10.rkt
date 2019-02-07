#!/usr/bin/racket
#lang scheme/base
(require srfi/1)

(define (prime? x)
  (cond ((<= x 1) #f)
        ((<= x 3) #t)
        ((or (= (modulo x 2) 0) (= (modulo x 3) 0)) #f)
        (else
         (let loop ((i 5))
           (cond ((and (<= (expt i 2) x)
                       (or (= (modulo x i) 0) (= (modulo x (+ i 2)) 0)))
                  #f)
                 ((> (expt i 2) x) #t)
                 (else (loop (+ i 6))))))))

(define (p10)
  (writeln
   (let loop ((i 2))
     (if (= i 1999999)
         0
         (+ (if (prime? i) i 0) (loop (+ i (if (= i 2) 1 2))))))))

(p10)
