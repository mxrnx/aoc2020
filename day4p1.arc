(def rectify (data)
  (accum add
    (let curr ""
      (each x data
	(if (is x (last data))
	    (add (+ curr #\ x))
	    (if (headmatch "\n" x)
		(do (add curr)
		    (= curr (cut x 1)))
		(= curr (+ curr #\  x))))))))

(def list->alist (seq)
  (cons (map (fn (x) (map [coerce _ 'sym] (tokens x #\:))) (tokens (car seq) #\ )) 
	(if (cdr seq)
	    (list->alist (cdr seq))
	    nil)))

(def check-passport (pass)
  (pos nil (map [alref pass _] '(ecl pid eyr hcl byr iyr hgt))))

(def make-alists (data))

(def run-puzzle (e)
  (count nil (map check-passport (list->alist (rectify (dump-puzzle-input 4 e idfn))))))
  ;(rectify (dump-puzzle-input 4 e idfn)))
