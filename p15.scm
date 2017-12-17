(use numbers
     srfi-1
     ;; srfi-13
     utils
     ;; (prefix linear-algebra linalg-)
     srfi-113
     srfi-128)

(define (p15)
  (define node-comparator
    (make-comparator list?
                     (lambda (a b)
                       (equal? (car a) (car b)))
                     #f
                     (lambda (x)
                       (string-hash (->string (car x))))))

  (define (is-goal node)
    (equal? (car node) '(5 . 5)))

  (define (expand-node node visited)
    (let ((x (caar node))
          (y (cdar node)))
      (filter (lambda (node)
                (and
                 (let ((x (caar node))
                       (y (cdar node)))
                   (and (>= x 0)
                        (>= y 0)
                        (>= 5 x)
                        (>= 5 y)))
                 (not (set-member visited node #f))))
              (list (cons (cons (+ 1 x) y) node)
                    (cons (cons x (+ 1 y)) node)
                    ;; (cons (cons (- x 1) y) node)
                    ;; (cons (cons x (- y 1)) node)
                    ))))

  (define (recurse q visited)
    (if (null? q)
        '()
        (let ((node (car q)))
          ;; (print "NODE HEAD: " (car node))
          ;; (print "Q: " q)
          ;; (print "VISITED: " (set-size visited) ":" visited "\n")
          (if (is-goal node)
              (cons node (recurse (append (cdr q) (expand-node node visited))
                                  (set-adjoin visited node)))
              ;; (print "NODE HEAD: " (car node))
              ;; (print "Q: " q)
              ;; (print "VISITED: " (set-size visited))
              ;; (print "EXPANDED: " (expand-node node visited) "\n")
              ;; (sleep 1)
              (recurse (append (cdr q) (expand-node node visited))
                       (set-adjoin visited node))))))

  (let ((q '(((0 . 0))))
        (visited (set node-comparator)))
    (recurse q visited)
    ))

(print (length (p15)))
