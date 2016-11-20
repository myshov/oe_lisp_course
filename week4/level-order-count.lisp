(defparameter input-lst (read))

(defvar sum)
(setf sum 0)

(defun left (tree) (second tree))
(defun right (tree) (third tree))

(defun bst-levelorder (tree)
    (labels ((do-bst-levelorder (nodes lvl &aux lst)
        (incf lvl)
        (dolist (node nodes) 
            (unless (null node)
                (if (and (oddp lvl) (= (mod (car node) 7) 0))
                    (setf sum (+ sum (car node))))
                (if (left node)
                    (setf lst
                        (append lst (list (left node)))))
                (if (right node)
                    (setf lst
                        (append lst (list (right node)))))))
        (if lst (do-bst-levelorder lst lvl))))

        (do-bst-levelorder (list tree) 0)))

(bst-levelorder input-lst)    

(print sum)
