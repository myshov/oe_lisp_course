(defun flatten (lst)
    (if (consp lst)
        (append
            (flatten (car lst))
            (if (not (null (cdr lst)))
                (flatten (cdr lst))
                '()))
        (if (not (null lst))
            (append (list lst) '())
            '())))
