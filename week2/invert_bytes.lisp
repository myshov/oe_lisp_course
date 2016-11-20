(defun change-byte (b)
  (dotimes (i 4 b)
    (when
        (not (eq
              (logbitp i b)
              (logbitp (- 7 i) b)))
        (setf b
              (logxor
                    (+ (ash 1 i) (ash 1 (- 7 i)))
                    b)))))


(defvar x 0)

(setf x (read))

(dotimes (i (ceiling (integer-length x) 8))
    (setf x
        (dpb 
            (change-byte (ldb (byte 8 (* i 8)) x))
            (byte 8 (* i 8)) x)))

(print x)


