; verify a goal number using the numbers before it
(def verify (seq goal ep)
  (if (empty seq) (ep goal))
  (unless (find [is (+ _ (car seq)) goal] (cdr seq))
	 (verify (cdr seq) goal ep)))

; recurse over all the numbers in the XMAS-list
(def recurse (seq n ep)
  (verify (cut seq 0 n) (seq n) ep)
  (recurse (cdr seq) n ep))

; finds the encryption weakness by bruteforce. not very elegant
(def crack (seq target ep)
  (forlen n seq
    (= x 0)
    (loop (= i n) (< x target) (++ i) (= x (+ x (seq i))))
    (when (is x target)
      (let res (cut seq n i)
	(ep (+ (apply max res) (apply min res)))))))

(def run-puzzle (e)
  (ccc (fn (ep1)
	 (let data (map int (puzzle-input 9 'syms e))
	   (crack data (ccc (fn (ep0) (recurse data (if e 5 25) ep0))) ep1)))))
