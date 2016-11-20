(defparameter arr (read))

(defvar dims (array-dimensions arr))
(defvar strings (make-array 20 :fill-pointer 0))
(defvar sum)
(setf sum 0)

(dotimes (i (nth 0 dims))
    (dotimes (j (nth 1 dims))
        (dotimes (k (nth 2 dims))
            (when (stringp (aref arr i j k))
                           (vector-push (aref arr i j k) strings)))))

(dotimes (i (length strings))
    (when (not
        (or (position #\a  (aref strings i))
            (position #\i (aref strings i))
            (position #\u (aref strings i))))
            (setf sum (+ sum (length (aref strings i))))))

(print sum)
