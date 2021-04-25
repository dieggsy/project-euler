(in-package :common-lisp-user)

(defpackage :cards
  (:use :cl)
  (:export card
           card-value
           card-suit
           card<
           card>
           card=
           J Q K A
           C H D S))

(in-package :cards)

(defclass card ()
  ((value
    :initarg :value
    :reader %card-value)
   (suit
    :initarg :suit
    :reader card-suit)))

(defmethod card ((lst list))
  (destructuring-bind (value suit) lst
    (assert (or (and (integerp value)
                     (<= 2 value 10))
                (and (symbolp value)
                     (member value '(J Q K A))))
            (value)
            "value must be CARDS:J/Q/K/A")
    (assert (and (symbolp suit)
                 (member suit '(C H D S)))
            (suit)
            "suit must be CARDS:C/H/D/S")
    (make-instance 'card
                   :value (case value
                            ((:J) 11)
                            ((:Q) 12)
                            ((:K) 13)
                            ((:A) 14)
                            (t value))
                   :suit suit)))

(defmethod card-value ((c card))
  (let ((v (%card-value c)))
    (case v
      ((11) :J)
      ((12) :Q)
      ((13) :K)
      ((14) :A)
      (t v))))

(defmethod card< ((c1 card) (c2 card))
  (< (%card-value c1) (%card-value c2)))

(defmethod card> ((c1 card) (c2 card))
  (> (%card-value c1) (%card-value c2)))

(defmethod card= ((c1 card) (c2 card))
  (and (= (%card-value c1) (%card-value c2))
       (eq (card-suit c1) (card-suit c2))))

(defmethod print-object ((card card) stream)
  (print-unreadable-object (card stream :type t)
    (format stream "~a~a"
            (case (%card-value card)
              ((14) 'A)
              ((13) 'K)
              ((12) 'Q)
              ((11) 'J)
              (t (%card-value card)))
            (card-suit card))))

(defclass hand ()
  ((cards
    :initarg :value
    :reader cards)))

(defmethod make-hand ((lst list))
  (assert (and (= 5 (length lst))
               (every (lambda (x)
                        (typep x 'card))
                      lst))
          (lst)
          "make-hand takes a list of 5 cards")
  (let ((hand (make-instance 'hand)))
    (setf (slot-value hand 'cards) (sort lst #'card>))
    hand))

(defmethod hand-rank ((hand hand))
  (let* ((cards (hand-cards hand))
         (suits (mapcar #'card-suit cards))
         (values (mapcar #'%card-value cards)))
    (cond ((not (set-difference '(10 11 12 13 14)
                                cards))
           9)
          ((and (= 4 (- (car (last values))
                        (car values)))
                (every (lambda (x) (eq (car suits) x))
                       (cdr suits)))
           8))))

(defmethod print-object ((hand hand) stream)
  (print-unreadable-object (hand stream :type t)
    (format stream "~{~A~^ ~}" (cards hand) )))
