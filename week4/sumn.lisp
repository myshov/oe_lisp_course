(defun sum-n (arr n)
    (let ((res 0))
        (dotimes (i n)
            (incf res (aref arr i)))
        res))
