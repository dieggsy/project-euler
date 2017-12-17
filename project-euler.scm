(use numbers
     srfi-1
     srfi-13
     utils
     (prefix linear-algebra linalg-)
     srfi-113
     srfi-128
     srfi-19
     combinatorics)

;;* utils
;;** range
(define (range-to num)
  (let loop ((i num)
             (lst '()))
    (if (< i 1)
        lst
        (loop (- i 1) (cons i lst)))))

(define (range start stop)
  (let loop ((i stop)
             (lst '()))
    (if (< i start)
        lst
        (loop (- i 1) (cons i lst)))))
;;** triangle
(define (nth-triangle-brute n)
  (if (= n 1)
      n
      (+ n (triangle (- n 1)))))

(define (nth-triangle n)
  (/ (* n (+ n 1)) 2))

(define (triangle? n)
  (integer?
   (/ (- (sqrt (- 1 (* 4 (* 2 (- n))))) 1) 2)))

;;** pentagonal
(define (pentagonal? n)
  (integer?
   (/ (+ (sqrt (- 1 (* 4 3 (* 2 (- n))))) 1) (* 2 3))))

;;** hexagonal
(define (hexagonal? n)
  (integer?
   (/ (+ (sqrt (- 1 (* 4 2 (- n)))) 1) (* 2 2))))

;;** quadratic
(define (quadratic a b c)
  (list (/ (+ (- b) (sqrt (- (expt b 2) (* 4 a c)))) (* 2 a))
        (/ (- (- b) (sqrt (- (expt b 2) (* 4 a c)))) (* 2 a))))

;;** factors
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
    (delete-duplicates (append small-fac (map (lambda (y) (/ x y)) small-fac)))))

;;** proper
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

;;** collatz
(define (collatz x)
  (cond ((= x 1)
         '(1))
        ((even? x)
         (cons x (collatz (/ x 2))))
        ((odd? x)
         (cons x (collatz (+ 1 (* 3 x)))))))
;;** !
(define (! x)
  (if (= x 1)
      1
      (* x (! (- x 1)))))

;;** prime?
(define (prime? x)
  (cond ((<= x 1) #f)
        ((<= x 3) #t)
        ((or (= (modulo x 2) 0) (= (modulo x 3) 0)) #f)
        (else
         (let loop ((i 5))
           (cond ((and (<= (expt i 2) x)
                       (or (= (modulo x i) 0) (= (modulo x (+ i 2)) 0)))
                  #f)
                 ((> (expt i 2) x) #t)
                 (else (loop (+ i 6))))))))

;;** sieve
(define (sieve n)
  (define (aux u v)
    (let ((p (car v)))
      (if (> (* p p) n)
          (let rev-append ((u u) (v v))
            (print "REV-APPEND")
            (print u)
            (print v "\n")
            (if (null? u)
                v
                (rev-append (cdr u) (cons (car u) v))))
          (aux (cons p u)
               (let wheel ((u '()) (v (cdr v)) (a (* p p)))
                 (cond ((null? v) (reverse u))
                       ((= (car v) a) (wheel u (cdr v) (+ a p)))
                       ((> (car v) a) (wheel u v (+ a p)))
                       (else (wheel (cons (car v) u) (cdr v) a))))))))
  (aux '(2)
       (let range ((v '()) (k (if (odd? n) n (- n 1))))
         (if (< k 3) v (range (cons k v) (- k 2))))))
;;** pandigital?
(define (pandigital? n)
  (let loop ((num (map (lambda (c) (string->number (string c)))
                       (string->list (number->string n))))
             (n (string-length (number->string n))))
    (cond ((and (= n 0) (null? num))
           #t)
          ((not (member n num))
           #f)
          (else (loop (remove (lambda (x) (= x n))
                              num)
                      (- n 1))))))

;;** choose
(define (choose n k)
  (/ (! n) (* (! k) (! (- n k)))))
;;** swap
(define (swap lst ind ind2)
  (let ((max (max ind ind2))
        (min (min ind ind2)))
    (append
     (take lst min)
     (cons
      (list-ref lst max)
      (drop
       (take lst max)
       (+ 1 min)))
     (cons (list-ref lst min) (drop lst (+ 1 max))))))
;;** heap
(define (perm s)
  (cond ((null? s) '())
        ((null? (cdr s)) (list s))
        (else ;; extract each item in list in turn and perm the rest
         (let splice ((l '()) (m (car s)) (r (cdr s)))
           (append
            (map (lambda (x) (cons m x)) (perm (append l r)))
            (if (null? r)
                '()
                (splice (cons m l) (car r) (cdr r))))))))
;;* Problems
;;** p01
(define (p01)
  (let loop ((i 3))
    (if (= i 1000)
        0
        (+ (if (or (= (modulo i 3) 0) (= (modulo i 5) 0))
               i
               0)
           (loop (+ i 1))))))

;;** p02
(define (p02)
  (let loop ((num1 1)
             (num2 2))
    (let ((addnum (if (and (even? num2)
                           (not (> num2 4000000)))
                      num2
                      0)))
      (if (>= num2 4000000)
          addnum
          (+ addnum (loop num2
                          (+ num1 num2)))))))
;;** p03
(define (p03)
  (apply max (filter prime? (factors 600851475143))))

;;** p04
;; file
(use numbers
     srfi-13
     extras)

(define (p04)
  (format
   #t
   "~a~%"
   (let loop ((num1 999)
              (num2 999)
              (biggest 0))
     (let ((prod (* num1 num2)))
       (cond
        ;; Done looking
        ((and (= num1 100) (= num2 100))
         biggest)
        ;; Found a bigger palindrome
        ((and (string=? (number->string prod)
                        (string-reverse (number->string prod)))
              (> prod biggest))
         (loop num1 (- num2 1) prod))
        ;; Num2 hasn't run out in this pass
        ((> num2 100)
         (loop num1 (- num2 1) biggest))
        ;; Start again, bump both down
        (else (loop (- num1 1) (- num1 1) biggest)))))))

(p04)
;;** p05
(define (p05)
  (define (my-gcd num1 num2)
    (let* ((big (max num1 num2))
           (smol (min num1 num2))
           (mod (modulo big smol)))
      (if (= mod 0)
          smol
          (my-gcd smol mod))))

  (let loop ((lst (range-to 20)))
    (if (= (length lst) 2)
        (let ((one (car lst))
              (two (cadr lst)))
          (/ (* one two)
             (my-gcd one two)))
        (let ((one (car lst))
              (two (loop (cdr lst))))
          (/ (* one two)
             (my-gcd one two))))))
;;** p06
(define (p06)
  (let ((sum-of-squares (apply + (map (lambda (x) (expt x 2)) (range-to 100))))
        (square-of-sum (expt (apply + (range-to 100)) 2)))
    (- square-of-sum sum-of-squares)))

;;** p07
(define (p07)
  (let loop ((n 1)
             (x 2))
    (if (= n 10001)
        x
        (loop (if (prime? (+ x 1)) (+ n 1) n) (+ x 1)))))
;;** p08
(define (p08)
  (let ((long-string (read-all "p08-string.txt")))
    (let loop ((start 0)
               (end 13)
               (big 0))
      (if (= end (string-length long-string))
          big
          (let ((short-string (substring long-string start end)))
            (loop (+ start 1)
                  (if (< (+ end 1) (string-length long-string))
                      (+ end 1)
                      (string-length long-string))
                  (max big
                       (apply *
                              (map string->number
                                   (map string
                                        (string->list short-string)))))))))))

;;** p09
;; brute force
(define (p09)
  (let loop ((a 1)
             (b 1))
    (if (= 1000 (+ a b (sqrt (+ (expt a 2) (expt b 2)))))
        (format #t "~a~%" (list a b (sqrt (+ (expt a 2) (expt b 2)))))
        (cond ((= b 1000) (loop (+ a 1) 0))
              (#t (loop a (+ b 1)))))))

;; the rose way: solve for c, b in terms of a, iterate over a
(define (p09)
  (define (c a)
    (- (/ 500000 (- 1000 a)) a))
  (define (b a)
    (- 1000 (/ 500000 (- 1000 a))))
  (let loop ((a 1))
    (if (and (= 1000 (+ a (b a) (c a)))
             (integer? (b a))
             (integer? (c a)))
        (format #t "~a~%" (list a (b a) (c a)))
        (loop (+ a 1)))))

;;** p10
;; file
(use numbers
     extras
     srfi-1)

(define (prime? x)
  (cond ((<= x 1) #f)
        ((<= x 3) #t)
        ((or (= (modulo x 2) 0) (= (modulo x 3) 0)) #f)
        (else
         (let loop ((i 5))
           (cond ((and (<= (expt i 2) x)
                       (or (= (modulo x i) 0) (= (modulo x (+ i 2)) 0)))
                  #f)
                 ((> (expt i 2) x) #t)
                 (else (loop (+ i 6))))))))

(define (p10)
  (format
   #t
   "~a~%"
   (let loop ((i 2))
     (if (= i 1999999)
         0
         (+ (if (prime? i) i 0) (loop (+ i (if (= i 2) 1 2))))))))

(p10)
;;** p11
;; (define (my-matrix-ref m n)
;;   (let ((j (modulo n (linalg-matrix-columns m)))
;;         (i (fx/ n (linalg-matrix-columns m))))
;;     (format #t "~a ~a~%" i j)
;;     (linalg-matrix-ref m i j)))

(define (p11)
  (define mref linalg-matrix-ref)

  (define (local-max m i j)
    (if (and (< (+ j 3) (linalg-matrix-columns m))
             (< (+ i 3) (linalg-matrix-rows m)))
        (let ((down (* (mref m i j) (mref m (+ i 1) j) (mref m (+ i 2) j) (mref m (+ i 3) j)))
              (diag (* (mref m i j) (mref m (+ i 1) (+ j 1)) (mref m (+ i 2) (+ j 2)) (mref m (+ i 3) (+ j 3))))
              (diag2 (* (mref m (+ i 3) j) (mref m (+ i 2) (+ j 1)) (mref m (+ i 1) (+ j 2)) (mref m i (+ j 3))))
              (right (* (mref m i j) (mref m i (+ j 1)) (mref m i (+ j 2)) (mref m i (+ j 3)))))
          (max right diag down diag2))
        0))
  (let* ((matrix-list (map (lambda (line)
                             (map string->number line))
                           (map string-split
                                (string-split
                                 (read-all "p11-matrix.txt")
                                 "\n"))))
         (matrix (linalg-list->matrix matrix-list)))
    (let loop ((a 0)
               (mx 0))
      (if (= a (* (linalg-matrix-rows matrix) (linalg-matrix-columns matrix)))
          mx
          (let ((j (modulo a (linalg-matrix-columns matrix)))
                (i (fx/ a (linalg-matrix-columns matrix))))
            (loop (+ 1 a) (max mx (local-max matrix i j))))))))
;;** p12
;; file
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


;;** p13
(define (p13)
  (let* ((p13-string (read-all "p13-string.txt"))
         (nums (map string->number (string-split p13-string "\n")))
         (sumstr (number->string (apply + nums))))
    (substring sumstr 0 10)))

;;** p14
;; file
(use extras
     numbers)

(define (collatz x)
  (cond ((= x 1)
         '(1))
        ((even? x)
         (cons x (collatz (fx/ x 2))))
        ((odd? x)
         (cons x (collatz (fx+ 1 (fx* 3 x)))))))

(define (p14)
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

(p14)
;;** p15
(define (p15)
  (choose 40 20))

;;** p16
(define (p16)
  (let* ((numstr (number->string (expt 2 1000)))
         (strlst (string->list numstr))
         (numlst (map (lambda (x) (string->number (string x)))
                      strlst)))
    (apply + numlst)))

;;** p17
(define (wordify-number num)
  (let ((numstr (number->string num)))
    (let loop ((numstr (string-reverse numstr))
               (place 1))
      (if (string-null? numstr)
          ""
          (let ((char (string-ref numstr 0))
                ;; (char-2 (string-ref numstr 1))
                )
            (string-append
             (loop (substring numstr 1) (* 10 place))
             (cond ((and (= place 1)
                         (> (string-length numstr) 1)
                         (char=? (string-ref numstr 1) #\1))
                    (cond ((char=? char #\0) "ten")
                          ((char=? char #\1) "eleven")
                          ((char=? char #\2) "twelve")
                          ((char=? char #\3) "thirteen")
                          ((char=? char #\4) "fourteen")
                          ((char=? char #\5) "fifteen")
                          ((char=? char #\6) "sixteen")
                          ((char=? char #\7) "seventeen")
                          ((char=? char #\8) "eighteen")
                          ((char=? char #\9) "nineteen")))
                   ((not (= place 10))
                    (string-append
                     (if (and (= place 1)
                              (not (char=? char #\0))
                              (> (string-length numstr) 2)
                              (char=? (string-ref numstr 1) #\0))
                         "and"
                         "")
                     (cond ((char=? char #\0) "")
                           ((char=? char #\1) "one")
                           ((char=? char #\2) "two")
                           ((char=? char #\3) "three")
                           ((char=? char #\4) "four")
                           ((char=? char #\5) "five")
                           ((char=? char #\6) "six")
                           ((char=? char #\7) "seven")
                           ((char=? char #\8) "eight")
                           ((char=? char #\9) "nine"))))
                   (else
                    (string-append
                     (if (and (> (string-length numstr) 1)
                              (not (char=? char #\0)))
                         "and"
                         "")
                     (cond ((char=? char #\0) "")
                           ((char=? char #\1) "")
                           ((char=? char #\2) "twenty")
                           ((char=? char #\3) "thirty")
                           ((char=? char #\4) "forty")
                           ((char=? char #\5) "fifty")
                           ((char=? char #\6) "sixty")
                           ((char=? char #\7) "seventy")
                           ((char=? char #\8) "eighty")
                           ((char=? char #\9) "ninety")))))
             (if (and (= place 100)
                      (not (char=? char #\0)))
                 "hundred"
                 "")

             (if (and (= place 1000)
                      (not (char=? char #\0)))
                 "thousand"
                 "")))))))

(define (p17)
  (string-length (string-join (map wordify-number (range-to 1000)) "")))

;;** TODO p18
;;** p19
(define (add-day date)
  (time->date
   (add-duration
    (date->time date)
    (make-time time-duration
               0
               86400))))

(define (p16)
  (let loop ((date (string->date "1901-01-01" "~Y-~m-~d"))
             (day 2)
             (times 0))
    (if (= 0 (date-compare
              date
              (string->date "2000-12-31" "~Y-~m-~d")))
        times
        (loop (add-day date)
              (modulo (+ 1 day) 7)
              (if (and (= (date-day date) 1)
                       (= day 0))
                  (+ 1 times)
                  times)))))

;;** p20
(define (p20)
  (apply +
         (map string->number
              (map string
                   (string->list
                    (number->string (! 100)))))))
;;** p21
(define (p20)
  (define (d n)
    (apply + (filter (lambda (x) (not (= x n))) (factors n))))
  (define (amicable? a)
    (let ((b (d a)))
      (if (= b a)
          #f
          (let ((other (d b)))
            (if (= a other)
                (list a b)
                #f)))))
  (let loop ((num 2)
             (seen (set (make-default-comparator))))
    (if (= num 10000)
        0
        (let ((is-amicable (and (not (set-member seen num #f))
                                (amicable? num))))
          (+ (if is-amicable
                 (apply + is-amicable)
                 0)
             (loop (+ num 1) (if is-amicable
                                 (set-adjoin (set-adjoin seen (cadr is-amicable))
                                             (car is-amicable))
                                 seen)))))))

;;** p22
(define (p22)
  (define (name-score name)
    (apply + (map (lambda (x) (- x 64))
                  (map char->integer (string->list name)))))
  (let ((sorted-names
         (sort
          (string-split (read-all "names.txt") "\",")
          string<)))
    (let loop ((names sorted-names)
               (place 1))
      (if (= (length names) 1)
          (* (name-score (car names)) place)
          (+ (* (name-score (car names)) place) (loop (cdr names) (+ place 1)))))))

;;** OVERTIME p23
;; file
;; 220 seconds
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
;;** p24
(define (p24)

  ;; (define (generate n A)
  ;;   (if (= n 1)
  ;;       A
  ;;       (begin
  ;;         (let loop ((i 0)
  ;;                    (lst '()))
  ;;           (cond ((= i (- n 1))
  ;;                  (cons (generate (- n 1) A) lst))
  ;;                 ((even? n)
  ;;                  (loop (+ i 1)
  ;;                        (cons (generate (- n 1) (swap A i (- n 1)))
  ;;                              lst)))
  ;;                 (else
  ;;                  (loop (+ i 1)
  ;;                        (cons (generate (- n 1) (swap A 0 (- n 1)))
  ;;                              lst)))))))))
  (define (generate! n A)
    (if (= n 1)
        (print A)
        (begin
          (do ((i 0 (+ i 1)))
              ((= i (- n 1)) #f)
            (generate! (- n 1) A)
            (if (even? n)
                (set! A (swap A i (- n 1)))
                (set! A (swap A 0 (- n 1)))))
          (generate! (- n 1) A))))

  (define (generate n A)
    (if (= n 1)
        A
        (let loop ((i 0)
                   (lst '())
                   (A A))
          (cond ((= i (- n 1))
                 (cons (generate (- n 1) A) lst))
                ((even? n)
                 (loop (+ i 1)
                       (cons (generate (- n 1) A)
                             lst)
                       (swap A i (- n 1))))
                (else
                 (loop (+ i 1)
                       (cons (generate (- n 1) A)
                             lst)
                       (swap A 0 (- n 1)))))))))
;;** p25
(define (p25)
  (let loop ((n 3)
             (i 1)
             (j 1))
    (let ((fib (+ i j)))
      (if (= (string-length
              (number->string fib))
             1000)
          n
          (loop (+ n 1) j fib)))))

;;** p28
(define (p28)
  (define (spiral n)
    (+ 1
       (let loop ((add 2)
                  (state 1))
         (print state)
         (if (= state (* n n))
             0
             (let ((final-state (+ state (* 4 add))))
               (+ (apply + (list (+ state add)
                                 (+ state (* 2 add))
                                 (+ state (* 3 add))
                                 final-state))
                  (loop (+ add 2) final-state)))))))
  (spiral 1001))

;;** p29
;; file
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

;;** TODO p32
(define (p32)
  (define combinations (ordered-subset-fold cons '() '("1" "2" "3" "4" "5" "6" "7" "8" "9")))
  (define get-all-eq lst
    (let loop (())
      (if ))))

;;** p35
;; file
(use extras
     srfi-1
     numbers)

(define (range num)
  (reverse
   (let loop ((i 1)
              (lst '()))
     (if (> i num)
         lst
         (loop (+ i 1) (cons i lst))))))

(define (prime? x)
  (cond ((<= x 1) #f)
        ((<= x 3) #t)
        ((or (= (modulo x 2) 0) (= (modulo x 3) 0)) #f)
        (else
         (let loop ((i 5))
           (cond ((and (<= (expt i 2) x)
                       (or (= (modulo x i) 0) (= (modulo x (+ i 2)) 0)))
                  #f)
                 ((> (expt i 2) x) #t)
                 (else (loop (+ i 6))))))))

(define (rotations string)
  (define (rotate-one str)
    (string-append
     (substring str 1 (string-length str))
     (substring str 0 1)))
  (cons
   string
   (let loop ((str (rotate-one string)))
     (if (string=? str string)
         '()
         (cons str (loop (rotate-one str)))))))

(define (circular-prime? n)
  (and (prime? n)
       (eqv? '() (filter (lambda (n) (not (prime? n)))
                         (map string->number (rotations (number->string n)))))))
;; (format #t "~a~%"
;;         (rotations "hello"))
(format #t "~a~%"
        (length (filter circular-prime? (range-to 1000000))))

;;** p36
(define (p36)
  (let loop ((n 0))
    (if (> n 1000000)
        0
        (+
         (let ((numstr (number->string n))
               (binstr (format "~B" n)))
           (if (and (string=? numstr (string-reverse numstr))
                    (string=? binstr (string-reverse binstr)))
               n
               0))
         (loop (+ n 1))))))

;;** p37
;; file
(define (p37)
  (define (truncatable-prime? n)
    (if (prime? n)
        (and
         (let loop ((n (substring (number->string n) 1)))
           (cond ((string-null? n)
                  #t)
                 ((not (prime? (string->number n)))
                  #f)
                 (else
                  (loop (substring n 1)))))
         (let loop ((n (substring (string-reverse (number->string n)) 1)))
           (cond ((string-null? n)
                  #t)
                 ((not (prime? (string->number (string-reverse n))))
                  #f)
                 (else
                  (loop (substring n 1))))))
        #f))
  (let loop ((n 11)
             (count 0))
    (cond ((> count 10)
           0)
          ((truncatable-prime? n)
           (+ n (loop (+ 1 n) (+ 1 count))))
          (else (loop (+ 1 n) count)))))

;;** p40
(define (p40)
  (let ((big-string (string-join (map number->string (range-to 1000000)) "")))
    (* (string->number (substring big-string 0 1))
       (string->number (substring big-string 9 10))
       (string->number (substring big-string 99 100))
       (string->number (substring big-string 999 1000))
       (string->number (substring big-string 9999 10000))
       (string->number (substring big-string 99999 100000))
       (string->number (substring big-string 999999 1000000)))))

;;** TODO p41
(define (p41)
  (let loop ((n 999999999))
    (if (and (prime? n)
             (pandigital? n))
        n
        (loop (- n 2)))))

;;** p42
(define (p42)
  (define (word-score word)
    (apply +
           (map (lambda (n) (- n 64))
                (map char->integer (string->list word)))))

  (let ((words (read-file "p042_words.txt")))
    (let loop ((words words)
               (count 0))
      (cond ((null? words)
             count)
            ((triangle? (word-score (car words)))
             (loop (cdr words) (+ count 1)))
            (else (loop (cdr words) count))))))

;;** TODO p43


(define (heap l)
  (define (swap lst i j)
    (append
     (cons (car (drop lst (- i 1))))))

  (let loop ((n (length l))
             (lst l))
    (if (= n 1)
        (print lst)
        (begin
          (let for ((i 0)
                    (lst lst))
            (cond ((= i (- n 1))
                   nil)
                  ((even? n)
                   (loop (- n 1) lst)
                   (for (+ i 1) (swap lst i (- n 1))))
                  (else
                   (loop (- n 1) lst)
                   (for (+ i 1) (swap lst 0 (- n 1))))))
          (loop (- n 1) lst)))))

;;** p45
(define (p45)
  (let loop ((n 286))
    (let ((tri (nth-triangle n)))
      ;; (print tri)
      (if (and (pentagonal? tri)
               (hexagonal? tri))
          tri
          (loop (+ n 1))))))

;;** p47
;; file
(define (p47)
  (let loop ((n 647)
             (lst '()))
    (when (> (length lst) 1)
      (print lst))
    (let ((fs (filter prime? (factors n))))
      (cond ((= (length lst) 4)
             (print "SOLN: " lst)
             lst)
            ((not (= (length fs) 4))
             (loop (+ n 1) '()))
            ((= (length fs) 4)
             (loop (+ n 1) (cons n lst)))))))

;;** p48
(define (p48)
  (string-reverse
   (substring
    (string-reverse
     (number->string
      (let loop ((n 1))
        (if (= n 1000)
            (expt n n)
            (+ (expt n n) (loop (+ n 1)))))))
    0
    10)))

;;** p56
(define (p56)
  (let loop ((a 99)
             (b 99))
    (cond ((= a 0)
           0)
          ((= b 0)
           (loop (- a 1) 100))
          (else
           (max (apply
                 +
                 (map string->number
                      (map ->string
                           (string->list
                            (number->string (expt a b))))))
                (loop a (- b 1)))))))

;;** p57
(define (p57)
  (define (nth-expansion n)
    (+ 1
       (/ 1
          (let loop ((n n))
            (if (= n 0)
                2
                (+ 2 (/ 1 (loop (- n 1)))))))))
  (let loop ((n 1000)
             (counter 0))
    (let* ((exp (nth-expansion n))
           (num-bigger? (> (string-length (number->string (numerator exp)))
                           (string-length (number->string (denominator exp))))))
      (cond ((= n 0)
             counter)
            ((not num-bigger?)
             (loop (- n 1) counter))
            (else (loop (- n 1) (+ counter 1)))))))

;;** p58
;; file
(define (p58)
  ;; (define (spiral n)
  ;;   (if (odd? n)
  ;;       (cons 1
  ;;             (let loop ((add 2)
  ;;                        (mad 1)
  ;;                        (state 1))
  ;;               (cond ((= (- add 1) n)
  ;;                      '())
  ;;                     ((= mad 4)
  ;;                      (let ((new-state (+ state (* mad add))))
  ;;                        (cons new-state
  ;;                              (loop (+ add 2)
  ;;                                    1
  ;;                                    new-state ))))
  ;;                     (else
  ;;                      (cons (+ state (* mad add))
  ;;                            (loop add
  ;;                                  (+ mad 1)
  ;;                                  state))))))
  ;;       (error "Spiral is only defined for odd numbers")))
  (define (spiral goal-r)
    (let loop ((add 2)
               (mad 1)
               (state 1)
               (prime-count 0)
               (num-count 1)
               (lst '(1)))
      (let* ((new-state (+ state (* mad add)))
             (prime-count (if (prime? new-state)
                              (+ prime-count 1)
                              prime-count))
             (num-count (+ num-count 1))
             (prime-ratio (/ prime-count num-count)))
        (if (= mad 4)
            (if (and (> prime-ratio 0)
                     (< prime-ratio goal-r))
                (begin
                  (print (sqrt new-state))
                  (sqrt new-state))
                (loop (+ add 2)
                      1
                      new-state
                      prime-count
                      num-count
                      (cons new-state lst)))
            (loop add
                  (+ mad 1)
                  state
                  prime-count
                  num-count
                  (cons new-state lst))))))

  (spiral .1))

;;** p
