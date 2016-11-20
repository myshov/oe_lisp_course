(defun change-tetradas (b)
    (+
        (ash (logand b 15) 4)
        (ash (logand b 240) -4)))


(defvar x 0)

(setf x (read))

(dotimes (i (ceiling (integer-length x) 8))
    (setf x
        (dpb 
            (change-tetradas (ldb (byte 8 (* i 8)) x))
            (byte 8 (* i 8)) x)))

(print x)


