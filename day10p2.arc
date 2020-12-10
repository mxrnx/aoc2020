; it's just a fibonacci sequence, but using three instead of two terms
(def fibcount (seq)
  (let steps (table) ; keeps track of amount of steps to correct solution
    (= (steps 0) 1)
    (each i seq
      (= (steps i) (apply + (map [or (steps (- i _)) 0] (range 0 3)))))
    (apply max (vals steps))))

(def run-puzzle (e)
  (let data (dedup (sort < (cons 0 (map int (puzzle-input 10 'syms e)))))
    (fibcount data)))
