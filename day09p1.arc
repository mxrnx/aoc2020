; verify a goal number using the numbers before it
(def verify (seq goal ep)
  (if (empty seq) (ep goal))
  (unless (find [is (+ _ (car seq)) goal] (cdr seq))
	 (verify (cdr seq) goal ep)))

; recurse over all the numbers in the XMAS-list
(def recurse (seq n ep)
  (verify (cut seq 0 n) (seq n) ep)
  (recurse (cdr seq) n ep))

(def run-puzzle (e)
  (ccc (fn (ep) (recurse (map int (puzzle-input 9 'syms e)) (if e 5 25) ep))))
