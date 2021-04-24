#!/usr/bin/sbcl --script

(defun p05 ()
  (apply #'lcm (loop for x from 1 to 20 collect x)))

(time (princ (p05)))
