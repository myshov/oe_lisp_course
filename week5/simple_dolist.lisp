(defvar lst '(1 2 3 6))

(let ((sum 0))
    (dolist (i lst)
        (setf sum
            (+ i sum)))
    (print sum))
