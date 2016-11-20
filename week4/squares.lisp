(defun square-eqn-roots (a b c)
    "Function returns roots of quadratric equation"
    (if (= a 0)
        (error "It's not a quadratic equation"))
    (let* ((D  (- (* b b) (* 4 a c))) 
        (x1 (/ (- (- b) (sqrt D)) (* 2 a)))
        (x2 (/ (+ (- b) (sqrt D)) (* 2 a))))
        (list x1 x2)))
