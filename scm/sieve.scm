(use numbers
     extras)

(define (sieve n)
  (define (aux u v)
    (let ((p (car v)))
      ;; (print "P: " p)
      (if (> (* p p) n)
          (let rev-append ((u u) (v v))
            ;; (print "REV-APPEND")
            ;; (print u)
            ;; (print v "\n")
            (if (null? u)
                v
                (rev-append (cdr u) (cons (car u) v))))
          (aux (cons p u)
               (let wheel ((u '()) (v (cdr v)) (a (* p p)))
                 ;; (print "WHEEL")
                 ;; (print "U: " u)
                 ;; (print "V: " v)
                 ;; (print "A: " a "\n")
                 (cond ((null? v) (reverse u))
                       ((= (car v) a) (wheel u (cdr v) (+ a p)))
                       ((> (car v) a) (wheel u v (+ a p)))
                       (else (wheel (cons (car v) u) (cdr v) a))))))))
  (aux '(2)
       (let range ((v '()) (k (if (odd? n) n (- n 1))))
         (if (< k 3) v (range (cons k v) (- k 2))))))

(format #t "~a~%"
        (sieve (string->number (car (command-line-arguments)))))