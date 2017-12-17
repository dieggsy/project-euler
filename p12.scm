(use extras)

(: factors (fixnum -> (list-of fixnum)))
(define (factors x)
  (let* ((root (sqrt x))
         (small-fac
          (let loop ((num 1))
            (cond ((>= num root)
                   (if (integer? (/ x num))
                       (list num)
                       '()))
                  ((not (integer? (/ x num)))
                   (loop (+ num 1)))
                  (else
                   (cons num (loop (+ num 1))))))))
    (append small-fac (map (lambda (y) (/ x y)) small-fac))))

(define (main)
  (format
   #t
   "~a~%"
   (let loop ((num 1)
              (tri 1)
              (num-factors 1))
     (if (fx> num-factors 500)
         tri
         (let* ((next (+ num 1))
                (tri-next (+ tri next))
                (num-factors-next (length (factors tri-next))))
           (loop next tri-next (max num-factors num-factors-next)))))))

(main)
