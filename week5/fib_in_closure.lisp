(let ((current-item 0) (prev-item 0) (call-count 0))
    (defun fib-next (&aux sum)
        (if (< call-count 2)
            (progn
                (incf call-count)
                (setf prev-item 1)
                (setf current-item 1))
            (progn
                (incf call-count)
                (setf sum (+ prev-item current-item))
                (setf prev-item current-item)
                (setf current-item sum)))))
