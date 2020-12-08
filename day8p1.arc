(mac acc (n) `(1 ,n))
(mac nop (n) '(1 0))
(mac jmp (n) `(,n 0))

(def interp (code i acc vis)
  (if (pos i vis) acc
      (let step/acc (macex (code i))
	(interp code (+ i (car step/acc)) (+ acc (cadr step/acc)) (cons i vis)))))

(def run-puzzle (e)
  (interp (puzzle-input 8 'syml e) 0 0 nil))
