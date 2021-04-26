#!/usr/bin/sbcl --script
(setf *print-circle* t)

(defun inf-frac (head repeat)
  (let ((lst (cons head repeat)))
    (setf (cdr (last (cdr lst)))
          (cdr lst))
    lst))
(defparameter sqrt2-conv
  (inf-frac 1 '(2)))

(defparameter e-conv
  (cons 2
        (loop :for i = 1 :then (+ 1 i)
              :until (> i 34)
              :append `(1 ,(* 2 i) 1))))

(defun get-value (n conv)
  (if (= n 0)
      (car conv)
      (labels ((helper (n lst)
                 (/ 1
                    (+ (car lst)
                       (if (= n 0)
                           0
                           (helper (1- n) (cdr lst)))))))
        (+ (car conv)
           (helper (1- n) (cdr conv))))))

(defun p65 ()
  (let ((num (numerator (get-value 99 e-conv))))
    (loop :for n = num :then x
          :as (x y) = (multiple-value-list (floor n 10))
          :until (= x 0)
          :sum y :into sum
          :finally (return (+ sum y)))))

(time (princ (p65)))
