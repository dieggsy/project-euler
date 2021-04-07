(use srfi-1
     extras)

(define (p29)
  (define (range start stop)
    (reverse
     (let loop ((i start)
                (lst '()))
       (if (> i stop)
           lst
           (loop (+ i 1) (cons i lst))))))
  (format #t
          "~a~%"
          (length
           (delete-duplicates
            (let loop ((a-range (range 2 100))
                       (b-range (range 2 100)))
              (cond ((null? b-range)
                     '())
                    ((null? a-range)
                     ;; (cons (expt (car a-range)
                     ;;             (car b-range)))
                     (loop (range 2 100) (cdr b-range)))

                    (else
                     (cons (expt (car a-range)
                                 (car b-range))
                           (loop (cdr a-range) b-range)))))))))

(p29)
