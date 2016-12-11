(defparameter *socket* (socket-server 4428))

(format t "server started~%")
(loop
    (let ((s (socket-accept *socket*)) (buff nil))
        (progn
            (setf buff (read-line s nil))
            (unless buff (return))
            (cond
                ((string= buff "quit") (return))
                (t
                    (format t "Recieved: [~a]~%" buff)
                    (format s "~a~%" (reverse buff))))
            (close s))))

(format t "~&server exited~%")
