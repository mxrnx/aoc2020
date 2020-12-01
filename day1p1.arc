(def inner (head tail)
     (if (is (+ head (car tail)) 2020)
       (list head (car tail))
       (and (cdr tail)
	    (inner head (cdr tail)))))

(def outer (data)
     (iflet x (inner (car data) (cdr data))
	    (list (car x) '* (cadr x) '= (apply * x))
	    (empty (cdr data)) nil
	    (outer (cdr data))))

(def run-puzzle (e)
     (outer (map [int _] (dump-puzzle-input 1 e))))
