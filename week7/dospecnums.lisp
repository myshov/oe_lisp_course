(defvar *lst*)

(defun split-on-digits (n)
    (if (>= n 1)
        (progn
            (push  (mod n 10) *lst*)
            (split-on-digits (floor n 10))))
    *lst*)

(defun specialp (n)
    (setf *lst* nil)
    (let ((lst (split-on-digits n)))
        (if (and (>= (length lst) 2) (every #'evenp lst))
            T
            NIL)))

(defmacro do-spec-nums ((var startv endv) &body body)
    ;; process spec nums
    `(loop for ,var from ,startv to ,endv do
           (if (specialp ,var) (progn ,@body))))
