#!/usr/bin/chicken-scheme
;; AUTOCOMPILE: -O3

(import (srfi 1)
        (srfi 14)
        (math number-theory))

(define primes (filter prime? (iota 9000 1000)))

(define (p49)
 (let loop ((ps primes))
  (if (null? ps)
      '()
      (let ((p (car ps)))
        (or (and-let* ((two (member (+ p 3330) primes))
                       (three (member (+ (car two) 3330) primes))
                       (nums (map number->string (list p (car two) (car three)))))
              (if (apply char-set= (map string->char-set nums))
                  (cons nums (loop (cdr ps)))
                  #f))
            (loop (cdr ps)))))))

(time (print (p49)))
