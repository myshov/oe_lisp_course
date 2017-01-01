(set-macro-character #\} (get-macro-character #\)))

(defun split-on-digits (n &optional lst)
    (when (>= n 1)
        (push (mod n 10) lst)
        (setf lst (split-on-digits (floor n 10) lst)))
    lst)

(defun symp (num)
    (let ((digits (split-on-digits num)) (result nil))
        (dotimes (i (truncate (/ (length digits) 2)))
            (if (eq (nth i digits) (nth (- (length digits) i 1) digits))
                (push T result)
                (push nil result)))
        (not (every #'null result))))

(set-dispatch-macro-character #\# #\{
    #'(lambda (stream c1 c2)
        (declare (ignore c1 c2))
        (let ((lst (read-delimited-list #\} stream t )))
            `(quote
                ,(if (or (< (first lst) 0) (< (second lst) 0) (> (first lst) (second lst)))
                    NIL
                    (loop for x from (first lst) to (second lst) when (symp x) collect x))))))
