(use numbers)
(use srfi-69)

(define (num-translate num index)
  (cond ((= index 1)
         (cond ((string= num "1")
                "one")
               ((string= num "2")
                "two")
               ((string= num "3")
                "three"))))
  (case ()))

