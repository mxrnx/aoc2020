(def solve (h w sh sw add)
  (if (>= h fin)
      add
      (let nw (mod w wrp)
	(+ (solve (+ h sh) (+ nw sw) sh sw (if (is chart.h.nw #\#) 1 0)) add))))

(def run-puzzle (e)
  (= chart (dump-puzzle-input 3 e)
     fin (len chart)
     wrp (len (car chart)))
  (apply * (map (fn (sh sw) (solve 0 0 sh sw 0))
		'(1 1 1 1 2) ; height steps
		'(1 3 5 7 1)))) ; width steps
