(def inner (head tail data)
     (iflet x (find [is (+ _ head (car tail)) 2020] data)
       (list head (car tail) x)
       (if (empty (cdr tail))
	 nil
	 (inner head (cdr tail) data))))

(def outer (data)
     (iflet x (inner (car data) (cdr data) data)
	    (list (car x) '* (cadr x) '* (caddr x) '= (apply * x))
	    (empty (cdr data)) nil
	    (outer (cdr data))))

(def run-puzzle ()
     (outer (map [int _] (dump-puzzle-input 1 1))))

