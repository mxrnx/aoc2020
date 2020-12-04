; split the data properly into strings of one passport each
(def rectify (data)
 (tokens (string (intersperse #\  data)) #\newline))

; convert rectify results to alist
(def data->alist (seq)
  (cons (map (fn (x) (map sym (tokens x #\:))) (tokens (car seq) #\ )) 
	(if (cdr seq)
	    (data->alist (cdr seq))
	    nil)))

; check passport correctness
(def check-passport (pass)
  (pos nil (map [alref pass _] '(ecl pid eyr hcl byr iyr hgt))))

(def run-puzzle (e)
  (count nil (map check-passport (data->alist (rectify (dump-puzzle-input 4 e idfn))))))
