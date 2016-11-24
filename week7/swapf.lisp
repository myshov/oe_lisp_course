(defmacro swapf (x y)
    `(let ((temp ,x))
        (setf ,x ,y) (setf ,y temp)))

(defparameter lst '(11 22 33))

(swapf (first lst) (third lst))

(print "swapf result")
(print lst)

(defmacro swapf-gensym (x y)
    (let ((temp (gensym)))
        `(let ((,temp ,x))
            (setf ,x ,y) (setf ,y ,temp))))

(defparameter temp '(11 22 33))

(swapf-gensym (first temp) (third temp))

(print "swapf-gensym result")
(print temp)
