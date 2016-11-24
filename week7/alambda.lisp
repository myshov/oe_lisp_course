(defmacro alambda (params &body body)
    `(labels ((self ,params ,@body))
        #'self))

(format t "~a! = ~a~%"
    5
    (funcall (alambda (n)
                      (if (> n 1)
                            (* n (self (- n 1)))
                            1))
             5))
