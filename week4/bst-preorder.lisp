(defun bst-preorder (bst)
    (if (nth 1 bst)
        (progn
            (format t "~a " (nth 0 bst))
            (bst-preorder (nth 1 bst))
            (bst-preorder (nth 2 bst)))
        (format t "~a " (nth 0 bst))))

(defparameter *tree* '(42 (33 (10) (36)) (99)))

(bst-preorder *tree*)
