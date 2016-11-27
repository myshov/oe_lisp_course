(defun split-on-digits (n &optional lst)
    (when (>= n 1)
        (push (mod n 10) lst)
        (setf lst (new-split-on-digits (floor n 10) lst)))
    lst)

(defun specialp (n)
    (let ((lst (split-on-digits n)))
        (if (and (>= (length lst) 2) (every #'evenp lst))
            T
            NIL)))

(defmacro do-spec-nums ((var startv endv) &body body)
    ;; process spec nums
    `(loop for ,var from ,startv to ,endv do
           (if (specialp ,var) (progn ,@body))))
