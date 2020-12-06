(def inner (head tail data)
     (iflet x (find [is (+ _ head (car tail)) 2020] data)
	    (list head (car tail) x)
	    (and (cdr tail)
		 (inner head (cdr tail) data))))

(def outer (data)
     (iflet x (inner (car data) (cdr data) data)
	    (apply * x)
	    (empty (cdr data)) nil
	    (outer (cdr data))))

(def run-puzzle (e)
     (outer (map [int _] (puzzle-input 1 'strs e))))
