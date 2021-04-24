#!/usr/bin/sbcl --script

(defun pentagonal (n)
  (/ (* n (- (* 3 n) 1))
     2))

(defun pentagonalp (n)
  (zerop
   (mod (/ (+ (sqrt (- 1 (* 4 3 (* 2 (- n))))) 1) (* 2 3))
        1)))

(defparameter +pent+
  (loop :for n = 1 :then (1+ n)
        :until (= n 10000)
        :collect (pentagonal n)))


(defun p44 ()
  (loop :for i :in +pent+
        :minimize
        (loop :for j :in +pent+
              :until (>= j i)
              :as diff = (- i j)
              :if (and (pentagonalp (+ i j))
                       (pentagonalp diff))
                :return diff
              :finally
                 (return #.double-float-positive-infinity))))

(time (princ (p44)))
