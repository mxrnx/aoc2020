(def solve (h w add)
  (if (is h fin)
      add
      (let nw (mod w wrp)
	(+ (solve (+ h 1) (+ nw 3) (if (is ((chart h) nw) #\#) 1 0)) add))))

(def run-puzzle (e)
  (= chart (dump-puzzle-input 3 e)
     fin (len chart)
     wrp (len (car chart)))
  (solve 0 0 0))
