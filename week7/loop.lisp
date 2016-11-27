(print
    (loop repeat 10
        for x = 1 then y
        for y = 1 then (+ x y)
        collect x)
)

(print
    (loop repeat 10
        for x = 1 then y and
        for y = 1 then (+ x y)
        collect x)
)
