(defun hash-table-from-list (lst &rest keyword-pairs &key (start 0) end &allow-other-keys)
    (let ((h (apply
                    #'make-hash-table
                    :allow-other-keys t keyword-pairs))
          (ls (subseq lst start end)))

          (hash-table-add-list h ls)))

(defun hash-table-add-list (h lst &aux k v)
    (loop
        (if (null lst) (return))
        (setf k (pop lst))
        (if (null lst) (return))
        (setf v (pop lst))
        (setf (gethash k h) v))
    h)

(defun set% (h key val &rest other-pairs)
    (let ((pairs (append (list key val) other-pairs)) k v)
        (hash-table-add-list h pairs)))

(defun % (h key &rest other-keys)
    (let ((keys (append (list key) other-keys)))
        (if (> (length keys) 1)
            (mapcar #'(lambda (x)
                        (gethash x h)) keys)
            (gethash (car keys) h))))

