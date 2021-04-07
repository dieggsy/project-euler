(use extras
     numbers)

(define (collatz x)
  (cond ((= x 1)
         '(1))
        ((even? x)
         (cons x (collatz (fx/ x 2))))
        ((odd? x)
         (cons x (collatz (fx+ 1 (fx* 3 x)))))))

(define (main)
  (format
   #t
   "~a~%"
   (let loop ((i 999999)
              (len (length (collatz 999999)))
              (longest 999999))
     (if (fx= i 1)
         longest
         (let* ((i (fx- i 1))
                (collatz-len (length (collatz i)))
                (next-len (if (> collatz-len len) collatz-len len))
                (longest (if (> collatz-len len) i longest)))
           (loop i next-len longest))))))

(main)
