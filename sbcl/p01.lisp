#!/usr/bin/sbcl --script

(defun p01 ()
  (labels ((arithmetic-sum (first last n)
                           (* n (/ (+ first last) 2))))
          (let ((max 999))
            (+ (arithmetic-sum 3 (* 3 (floor max 3)) (floor max 3))
               (arithmetic-sum 5 (* 5 (floor max 5)) (floor max 5))
               (- (arithmetic-sum 15 (* 15 (floor max 15)) (floor max 15)))))))

(time (prin1 (p01)))
