(defvar lst '(1 2 3 6))

(let ((sum 0))
    (do ((i 0 (+ i 1)))
        ((> i (- (length lst) 1)))
        (setf sum
            (+ (nth i lst) sum)))
    (print sum))
