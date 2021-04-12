#!/usr/bin/chicken-scheme
;; AUTOCOMPILE: -O3

(define (p63)
  (let loop ((a 1))
    (let loop1 ((b 1))
      (let* ((l (string-length (number->string (expt a b)))))
        (cond ((> a 9) 0)
              ((< l b) (loop (+ a 1)))
              ((= l b) (+ 1 (loop1 (+ b 1)))))))))

(time (print (p63)))
