(mac acc (n) `(1 ,n))
(mac nop (n) '(1 0))
(mac jmp (n) `(,n 0))

(def nop<->jmp (l i swp)
  (if (is i swp)
      (cons (case (car l) jmp 'nop nop 'jmp 'acc) (cdr l))
      l))

(def interp (code swp i acc vis return)
  (if (or (pos i vis) (empty code)) nil			; exit, not found
      (is i (len code)) (return acc)			; result found
      (let step/acc (macex (nop<->jmp (code i) swp i))	; else, continue search
	(interp code swp (+ i (car step/acc)) (+ acc (cadr step/acc)) (cons i vis) return))))

(def run-puzzle (e)
  (ccc (fn (return) 
	 (let code (puzzle-input 8 'syml e)
	   (forlen swp code
	     (unless (is (car (code swp)) 'acc)
	       (interp code swp 0 0 nil return)))))))
