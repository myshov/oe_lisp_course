;(defparameter input-phones (read))

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



(defparameter input-phones '("1101;+79119989911;122"
                             " +47231114563;1102;347"
                             "+47023334521;1101;134"
                             "1102;+49023334521;811"
                             "1102;1101;42"
                             "ERR01:1234;;;0;0"
                             " +390145211212; 1102; 93"
                             "+47023414522;1102;753"
                             "1102;+79119989911;771"))


(defun remove-spaces (str)
    (remove #\  str :test 'char=))

(defun is-phone-correct (phone)
    (if (and (= (length phone) 4)
             (equal (elt phone 0) #\1)
             (every #'digit-char-p phone))
                T
                (is-international-phone-correct phone)))

(defun is-international-phone-correct (phone)
    (if (and (equal (elt phone 0) #\+)
        (> 17 (length phone))
        (every #'digit-char-p (subseq phone 1 (length phone))))
        T))

(defun split-cdr-record (rec &aux lst)
    (setf lst nil)
    (setf rec (remove-spaces rec))
    (loop
        (if (not (position #\; rec)) (return))
        (push (subseq rec 0 (position #\; rec)) lst)
        (setf rec (subseq rec (1+ (position #\; rec)) (length rec)))
    )
    (if (> (length rec) 0)
        (push rec lst))
    (nreverse lst))

(defun remove-wrong-cdr (&aux lst)
    (setf lst (mapcar #'split-cdr-record input-phones))
    (setf lst (remove-if (lambda (c) (not (= (length c) 3))) lst))
    lst)


(defun hash++ (h key &optional (n 1))
    (let ((val (gethash key h)))
        (cond
            ((or (null val) (not (numberp val)))
                (set% h key n))
            (t (set% h key (+ val n))))
        (gethash key h)))

(defun hash-table-key-value-pairs (h)
    (let (pairs)
        (maphash #'(lambda (k v)
            (push (list k v) pairs)) h)
        (nreverse pairs)))

(defun is-norway-caller (cdrec)
    (let ((phone (first cdrec)))
        (equal (subseq phone 0 3) "+47")))

(defun is-employee-call (employee)
    (lambda (cdrec)
        (if (equal (first cdrec) employee)
          (list (third cdrec))) ))


(defun find-employee ()
    (let ((cdrs (remove-wrong-cdr)))
        (first (first (sort
            (hash-table-key-value-pairs
                (reduce
                    #'(lambda (h e) (hash++ h e) h)
                    (mapcar
                        #'second
                        (remove-if-not #'is-norway-caller cdrs)
                    )
                    :initial-value (make-hash-table :test #'equal))
                )
            #'> :key #'second)))))


(defun find-time ()
    (let ((employee (find-employee))
          (cdrs (remove-wrong-cdr)))
            (reduce
                #'+
                (mapcar #'parse-integer
                      (mapcan (is-employee-call employee) cdrs)))))
