(defpackage :numbers
  (:use :cl)
  (:export factor miller-rabin primep))

(in-package :numbers)

(declaim (optimize (speed 3) (space 0) (debug 0)))

;; from rosetta code
(defun factor (n &optional (acc '()))
  (when (> n 1)
    (loop with max-d = (isqrt n)
          for d = 2 then (if (evenp d) (1+ d) (+ d 2)) do
            (cond ((> d max-d)
                   (return (cons (list n 1) acc)))
                  ((zerop (rem n d))
                   (return (factor (truncate n d)
                                   (if (eq d (caar acc))
                                       (cons
                                        (list (caar acc) (1+ (cadar acc)))
                                        (cdr acc))
                                       (cons (list d 1) acc)))))))))

;; Miller Rabin (rosetta code)
(defun factor-out (number divisor)
  "Return two values R and E such that NUMBER = DIVISOR^E * R,
  and R is not divisible by DIVISOR."
  (do ((e 0 (1+ e))
       (r number (/ r divisor)))
      ((/= (mod r divisor) 0) (values r e))))

(defun mult-mod (x y modulus) (mod (* x y) modulus))

(defun expt-mod (base exponent modulus)
  "Fast modular exponentiation by repeated squaring."
  (labels ((expt-mod-iter (b e p)
             (cond ((= e 0) p)
                   ((evenp e)
                    (expt-mod-iter (mult-mod b b modulus)
                                   (/ e 2)
                                   p))
                   (t
                    (expt-mod-iter b
                                   (1- e)
                                   (mult-mod b p modulus))))))
    (expt-mod-iter base exponent 1)))

(defun random-in-range (lower upper)
  "Return a random integer from the range [lower..upper]."
  (+ lower (random (+ (- upper lower) 1))))

(defun miller-rabin (n k)
  "Test N for primality by performing the Miller-Rabin test K times.
  Return NIL if N is composite, and T if N is probably prime."
  (cond ((zerop n) nil)
        ((= n 1)   nil)
        ((< n 4)     t)
        ((evenp n) nil)
        (t
         (multiple-value-bind (d s) (factor-out (- n 1) 2)
           (labels ((strong-liar? (a)
                      (let ((x (expt-mod a d n)))
                        (or (= x 1)
                            (loop repeat s
                                  for y = x then (mult-mod y y n)
                                  thereis (= y (- n 1)))))))
             (loop repeat k
                   always (strong-liar? (random-in-range 2 (- n 2)))))))))

(defun primep (n)
  (miller-rabin n 12))
