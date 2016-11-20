(defun split-by (seq n)
    (if (< n (length seq))
        (list
            (subseq seq 0 n)
            (split-by (nthcdr n seq) n))
        (identity seq)))
