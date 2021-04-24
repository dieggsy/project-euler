#!/usr/bin/sbcl --script

(defun recursive ()
  (labels ((coin-combinations (amount coins)
             (let ((coin (car coins)))
               (cond ((not coin) 0)
                     ((= amount 0) 1)
                     ((> coin amount) (coin-combinations amount (cdr coins)))
                     (t
                      (+ (coin-combinations (- amount (car coins))
                                            coins)
                         (coin-combinations amount (cdr coins))))))))
    (let ((coins '(200 100 50 20 10 5 2 1)))
      (coin-combinations 200 coins))))

;; (defun iterative ()
;;   (labels ((coin-combinations (amount coins count)
;;              (let ((coin (car coins)))
;;                (cond ((not coin) 0)
;;                      ((= amount 0) 1)
;;                      ((> coin amount) (coin-combinations amount (cdr coins)))
;;                      (t
;;                       (+ (coin-combinations (- amount (car coins))
;;                                             coins)
;;                          (coin-combinations amount (cdr coins))))))))
;;     (let ((coins '(200 100 50 20 10 5 2 1)))
;;       (coin-combinations 200 coins))))

(format t "Recursive:")
(time (princ (recursive)))
