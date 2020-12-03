(def solve (h w sh sw)
  (if (>= h fin)
      0
      (let nw (if (>= w wrp)
		  (- w wrp)
		  w)
	(if (is ((chart h) nw) #\#)
	    (+ (solve (+ h sh) (+ nw sw) sh sw) 1)
	    (solve (+ h sh) (+ nw sw) sh sw)))))

(def run-puzzle (e)
  (= chart (dump-puzzle-input 3 e)
     fin (len chart)
     wrp (len (car chart)))
  (apply * (map (fn (sh sw) (solve 0 0 sh sw))
		'(1 1 1 1 2) ; height
		'(1 3 5 7 1) ; width
		)))
