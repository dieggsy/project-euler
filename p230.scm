(use utils srfi-13)

(define (p230)
  (define (D a b n)
    (let loop ((a a)
               (b b)
               (ncur n))
      (if (>= (string-length b) n)
          (string->number
           (->string
            (string-ref b (- n 1))))
          (loop b (string-append a b) (+ 1 ncur)))))

  (let loop ((n 0)
             (i "1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679")
             (j "8214808651328230664709384460955058223172535940812848111745028410270193852110555964462294895493038196"))
    (print n)
    (if (= n 18)
        0
        (+ (* (expt 10 n) (D i j (* (+ 127 (* 19 n)) (expt 7 n))))
           (loop (+ n 1) j (string-append i j))))))

(print (p230))
