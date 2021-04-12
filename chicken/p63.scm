#!/usr/bin/chicken-scheme

(define (p63)
  (let loop ((a 1))
    (let loop1 ((b 1))
      (let* ((n (expt a b))
             (l (string-length (number->string n))))
        (print a "^" b "=" n)
        (cond ((> a 9) 0)
              ((< l b) (loop (+ a 1)))
              ((= l b) (+ 1 (loop1 (+ b 1)))))))))
