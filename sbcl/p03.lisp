#!/usr/bin/sbcl --script
(load "numbers")

(use-package :numbers)

(defun p03 ()
  (apply #'max (mapcar #'car (factor 600851475143))))

(time (princ (p03)))
