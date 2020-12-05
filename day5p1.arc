(def bin->dec (b (o i 0))
  (if (is 0 b)
      0
      (+ (* (expt 2 i) (mod b 10)) (bin->dec (trunc (/ b 10)) (+ i 1)))))

(def run-puzzle (e)
  (apply max
	 (map
	   [+ (* 8 (bin->dec (int (multisubst '(("F" "0") ("B" "1")) (cut _ 0 7)))))
	      (bin->dec (int (multisubst '(("L" "0") ("R" "1")) (cut _ 7 10))))]
	   (dump-puzzle-input 5))))
