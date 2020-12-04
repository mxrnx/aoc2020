; join all the items in seq, seperated by sep.
(def string2 (seq sep)
  (if (empty (cdr seq)) (car seq)
      (string (car seq) sep (string2 (cdr seq) sep))))

; split the data properly into strings of one passport each
(def rectify (data)
 (tokens (string2 data #\ ) #\newline))

; convert rectify results to alist
(def data->alist (seq)
  (cons (map (fn (x) (map [coerce _ 'sym] (tokens x #\:))) (tokens (car seq) #\ )) 
	(if (cdr seq)
	    (data->alist (cdr seq))
	    nil)))

; check passport correctness
(def check-passport (pass)
  (pos nil (map [alref pass _] '(ecl pid eyr hcl byr iyr hgt))))

(def run-puzzle (e)
  (count nil (map check-passport (data->alist (rectify (dump-puzzle-input 4 e idfn))))))
