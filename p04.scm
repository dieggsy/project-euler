(use numbers
     srfi-13
     extras)

(define (main)
  (format
   #t
   "~a~%"
   (let loop ((num1 999)
              (num2 999)
              (biggest 0))
     (let ((prod (* num1 num2)))
       (cond
        ;; Done looking
        ((and (= num1 100) (= num2 100))
         biggest)
        ;; Found a bigger palindrome
        ((and (string=? (number->string prod)
                        (string-reverse (number->string prod)))
              (> prod biggest))
         (loop num1 (- num2 1) prod))
        ;; Num2 hasn't run out in this pass
        ((> num2 100)
         (loop num1 (- num2 1) biggest))
        ;; Start again, bump both down
        (else (loop (- num1 1) (- num1 1) biggest)))))))

(main)
