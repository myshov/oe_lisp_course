(defparameter *string* "~z ~% ~d float ~~ here ~1,0f and time again ~z here ~z")

(defun find-directives(str)
    (let ((output nil) (argnum 0))
        (loop
            for i from 0 below (length str)
            do
                (if (> (+ i 2) (length str))
                    (return)
                    (let ((part (subseq str i (+ i 2))))
                        (cond
                            ((string= part "~z")
                                (push (list argnum i) output)
                                (incf argnum))
                            ((or (string= part "~%") (string= part "~&"))
                                (continue))
                            ((or (string= part "~~"))
                                (incf i)
                                (continue))
                            ((equal (aref part 0) #\~)
                                (incf argnum))))))
        (reverse output)))

(defun replace-at-position (str new-str pos)
    (concatenate
        'string
        (subseq str 0 pos)
        new-str
        (subseq str (+ pos 2))))

(defun delete-nth (lst n)
  (nconc (subseq lst 0 n) (subseq lst (1+ n))))

(defun adapt-for-concate (arg)
    (if (stringp arg)
        arg
        (write-to-string arg)))


(defun phonep (phone)
    (let ((str "") (num-of-parts (length phone)))
        (dolist (part phone)
            (setf
                str
                (concatenate 'string str (adapt-for-concate part))))
        (if (and (<= (length str) 15) (every #'digit-char-p str) (= num-of-parts 3))
            T
            NIL)))
            
(defun split-on-groups(phone)
    (let ((phone-adapted (adapt-for-concate phone)))
        (if (not (= (length phone-adapted) 7))
            phone-adapted
            (progn
                (concatenate
                    'string
                    (subseq phone-adapted 0 3)
                    "-"
                    (subseq phone-adapted 3 5)
                    "-"
                    (subseq phone-adapted 5 7))))))

(defun format-phone (phone)
    (if (phonep phone)
        (concatenate
            'string
            "+"
            (adapt-for-concate (first phone))
            "("
            (adapt-for-concate (second phone))
            ")"
            (split-on-groups (third phone)))
        "[bad phone]"))

(defun format+ (stream-type format-string &rest params)
    (let ((args-num (length (find-directives format-string))))
        (dotimes (i args-num)
            (let* ((current-directive (first (find-directives format-string)))
                    (position-argument (first current-directive))
                    (position-directive (second current-directive))
                    (new-string (format-phone (nth position-argument params))))
                (setf
                    format-string
                    (replace-at-position format-string (adapt-for-concate new-string) position-directive))
                (setf
                    params
                    (delete-nth params position-argument)))))
    (apply #'format (nconc (list stream-type format-string) params)))
