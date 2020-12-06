(def solve (data)
  (iflet x (find [is (+ _ (car data)) 2020] (cdr data))
	 (* x (car data))
	 (solve (cdr data))))

(def run-puzzle (e)
  (solve (map [int _] (puzzle-input 1 'strs e))))
