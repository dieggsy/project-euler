#!/usr/bin/sbcl --script

(declaim (optimize (speed 3) (space 0) (debug 0)))

;; Let's emulate named loop
(defmacro nlet (name binds &rest body)
  `(labels ((,name ,(mapcar #'car binds) ,@body))
     (,name ,@(mapcar #'cadr binds))))

(defun palindromep (int)
  (let ((str (write-to-string int)))
    (string= str (reverse str))))


(defun scheme ()
  (nlet lp ((i 900)
            (res 0))
        (nlet loop1 ((j i)
                     (res res))
              (let ((prod (* i j)))
                (cond
                  ((> i 999)
                   res)
                  ((> j 999)
                   (lp (+ i 1) res))
                  ((and (palindromep prod)
                        (> prod res))
                   (loop1 (+ j 1) prod))
                  (t (loop1 (+ j 1) res)))))))

(defun cl ()
  (loop :for i :from 900 :to 999
        :maximize (loop :for j :from 900 :to 999
                        :and prod = (* i j)
                        :if (palindromep prod)
                          :return prod
                        :finally (return 0))))

(format t "Scheme translation:~%")
(time (prin1 (scheme)))

(format t "Idiomatic:~%")
(time (prin1 (cl)))
