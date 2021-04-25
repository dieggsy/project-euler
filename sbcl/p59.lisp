#!/usr/bin/sbcl --script

(require :uiop)

(defparameter +message+
  (with-open-file (in (uiop:parse-unix-namestring
                       "../data/p59-msg.txt"))
    (loop :for num = (read in nil)
          :while num
          :collect num))
  "Message as an integer list")

(defparameter +lower+
  (mapcar #'char-code (coerce "abcdefghijklmnopqrstuvwxyz" 'list))
  "ASCII codes for lowercase letters")

(defparameter +all-codes+
  (loop :for a :in +lower+
        :append
        (loop :for b :in +lower+
              :append
              (loop :for c :in +lower+
                    :collect (list a b c))))
  "Every possible three byte code, lol - we could do the bulk of the work in the
loop above if we wanted to save memory, probably.")

(defun decrypt (code message)
  "Decrypt an entire message using a three-byte CODE"
  (loop :for i :on message :by #'cdddr
        :append (mapcar #'logxor code
                        (subseq i 0 3))))

(defun simple-decrypt (code three)
  "Decrypt list of 3 bytes THREE using three-byte CODE"
  (coerce (mapcar #'code-char (mapcar #'logxor code three)) 'string))


(defun p59 ()
  "For every code, iterate over message by three bytes, decrypting them and pick
the first one that contains three common english words."
  (loop :named outer :for code :in +all-codes+
        :as wordcount =  (loop :for three :on +message+ :by #'cdddr
                               :if (member (simple-decrypt code (subseq three 0 3))
                                           '("and" "for" "the")
                                           :test #'string=)
                                 :sum 1)
        :if (> wordcount 3)
          :return (apply #'+ (decrypt code +message+))))

(time (princ (p59)))
