; converts binary number to decimal.  i should be 0 in external calls
(def bin->dec (b i)
  (if (is 0 b)
      0
      (+ (* (expt 2 i) (mod b 10)) (bin->dec (trunc (/ b 10)) (+ i 1)))))

; finds the missing id in a monotonously increasing seq. prev denotes lower bound
(def find-id (seq prev)
  (if (isnt (car seq) (+ prev 1))
      (+ prev 1)
      (find-id (cdr seq) (+ prev 1))))


(def run-puzzle (e)
  (find-id (sort <
	(map
	  [+ 
	    (* 8 (bin->dec (int (multisubst '(("F" "0") ("B" "1")) (cut _ 0 7))) 0))
	    (bin->dec (int (multisubst '(("L" "0") ("R" "1")) (cut _ 7 10))) 0)]
	  (dump-puzzle-input 5))) 6))
