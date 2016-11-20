(defun my-complement (fn)
    (lambda (x) (not (funcall fn x))))
