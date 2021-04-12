#!/usr/bin/chicken-scheme
;; AUTOCOMPILE: -O3

(import (math number-theory)
        (chicken fixnum)
        (chicken flonum)
        (srfi 1))

(define (p69)
  (let ((vals (map (lambda (n)
                     (/ (exact->inexact n)
                        (totient n)))
                   (iota #e1e6 1))))
    (let loop ((vs vals)
               (m 0.0)
               (n 1)
               (i 1))
      (cond ((null? vs) n)
            ((fp> (car vs) m) (loop (cdr vs) (car vs) i (fx+ i 1)))
            (else (loop (cdr vs) m n (fx+ i 1)))))))

(time (print (p69)))
