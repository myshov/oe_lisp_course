(defvar lst '(1 2 3 6))

(let ((sum 0))
    (dotimes (i (length lst))
        (setf sum
            (+ sum (nth i lst))))
    (print sum))
