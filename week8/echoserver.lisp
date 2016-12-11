(defparameter *socket* (socket-server 4428))

(format t "server started~%")
(let ((s (socket-accept *socket*)) (buff nil))
    (unwind-protect
        (loop
            (setf buff (read-line s nil))
            (unless buff (return))
            (cond
                ((string= buff "quit") (return))
                (t
                    (format t "Recieved: [~a]~%" buff)
                    (format s "~a~%" (reverse buff)))))
        (progn
            (close s) (socket-server-close *socket*))))

(format t "~&server exited~%")
