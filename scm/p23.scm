(use numbers
     srfi-1)

(define (range-to num)
  (let loop ((i num)
             (lst '()))
    (if (< i 1)
        lst
        (loop (- i 1) (cons i lst)))))

(define (p23)
  (define (proper-factors x)
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
      (append small-fac (map (lambda (y) (/ x y)) (cdr small-fac)))))

  (define (pdivisor-sum x)
    (let* ((root (sqrt x))
           (small-fac
            (let loop ((num 2))
              (cond ((> num root)
                     0)
                    ((not (integer? (/ x num)))
                     (loop (+ num 1)))
                    (else
                     ;; (print num " " (/ x num))
                     (+ num (+ (/ x num) (loop (+ num 1)))))))))
      (- (+ 1 small-fac) (if (integer? (sqrt x)) (sqrt x) 0))))

  (define (abundant? n)
    (> (pdivisor-sum n) n))

  (define (sum-of-abundant n lst)
    (let ((len (length lst)))
      (let loop ((ind 0))
        (cond ((or (= ind len)
                   (negative? (- n (list-ref lst ind)))
                   (> (list-ref lst ind) (/ n 2)))
               #f)
              ((member (- n (list-ref lst ind)) lst)
               #t)
              (else
               (loop (+ ind 1)))))))
  ;; way too slow
  ;; (let loop ((n 28123)
  ;;            (i 12))
  ;;   (print n)
  ;;   (cond ((= n 1)
  ;;          n)
  ;;         ((> i (/ n 2))
  ;;          (+ n (loop (- n 1) 12)))
  ;;         ((and (abundant? i)
  ;;               (abundant? (- n i)))
  ;;          (loop (- n 1) 12))
  ;;         (else (loop n (+ i 1)))))
  (let ((abundant-lst (filter abundant? (range-to 28123))))
    (let loop ((n 28123))
      (cond ((= n 1)
             n)
            ((not (sum-of-abundant n abundant-lst))
             (+ n (loop (- n 1))))
            (else (loop (- n 1)))))))

(print (p23))
