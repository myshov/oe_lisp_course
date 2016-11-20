(defun substituteif (lst value-original value-substitute) 
    (mapcar #'(lambda (x) (if (eq x value-original) value-substitute x)) lst))
