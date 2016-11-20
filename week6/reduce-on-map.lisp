(defun reduce-on-map (fn lst)
    (let ((acc 0))
        (mapcar #'(lambda (x) (setf acc (funcall fn acc x))) lst)
        acc))
