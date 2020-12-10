(def run-puzzle (e)
  (withs (ones 0
	       threes 1
	       data (cons 0 (sort < (map int (puzzle-input 10 'syms e)))))
    (reduce (fn (a b)
	      (if (is (- b a) 1)
		  (++ ones)
		  (++ threes)) b)
	    data)
    (* ones threes)))
