#!/usr/bin/sbcl --script


;; Scheme translation
(defun scheme ()
  (labels ((lp (i j res)
             (if (>  j 4000000)
                 res
                 (lp j (+ i j) (if (evenp j) (+ res j) res)))))
    (lp 1 2 0)))

;; Using loop
(defun cl ()
  (loop :for i = 1 :then j
        :and j = 2 :then (+ i j)
        :until (>= j 4000000)
        :if (evenp j)
          :sum j))



(format t "Scheme translation:~%")
(time (princ (scheme)))

(format t "Idiomatic:~%")
(time (princ (cl)))

;; (loop for i = 1 then j #.(read) j = 2 then (+ i j) repeat 10 collect (list i j))
