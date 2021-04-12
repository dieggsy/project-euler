#!/usr/bin/chicken-scheme

(import (srfi 1)
        (srfi 14)
        (chicken sort))

;; TODO: This is dumb slow, might be faster to iterate starting at 406 and
;; geenerate permutations of the cube
(define (p62)
  (define cubes (map (cut expt <> 3) (iota 10000 1)))
  (define strings (map (o string->list number->string) cubes))
  (define equal-groups
    (map
     (lambda (s1)
       (filter
        (lambda (s2)
          (and (= (length s1) (length s2))
               (equal? (sort s1 char<?)
                       (sort s2 char<?))))
        strings))
     strings))
  (find (lambda (l) (= (length l) 5)) equal-groups)

  )

(time (print (p62)))
