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

(def between (x low high)
  (and (>= x low) (<= x high)))

(def test-color-code (ep code)
  (if (empty code) (ep t)
      (if (or (between (car code) #\0 #\9)
	      (between (car code) #\a #\f))
	  (test-color-code ep (cdr code))
	  (do (prn (car code)) (ep nil)))))

(def sym->int (x) (int (string x)))
(def sym->charlist (x) (coerce (string x) 'cons))

(def check-passport (pass)
  (and
    (let byr (alref pass 'byr) (and (no:empty byr) (between (sym->int byr) 1920 2002)))
    (let iyr (alref pass 'iyr) (and (no:empty iyr) (between (sym->int iyr) 2010 2020)))
    (let eyr (alref pass 'eyr) (and (no:empty eyr) (between (sym->int eyr) 2020 2030)))
    (let hgt (coerce (alref pass 'hgt) 'string) (and (no:empty hgt)
						 (if (endmatch "cm" hgt) (between (int (cut hgt 0 -2)) 150 193)
						     (endmatch "in" hgt) (between (int (cut hgt 0 -2)) 59 76)
						     nil)))
    (let hcl (sym->charlist (alref pass 'hcl)) (and (no:empty hcl) (headmatch "#" hcl) (ccc (fn (ep) (test-color-code ep (cut hcl 1))))))
    (let ecl (alref pass 'ecl) (and (no:empty ecl) (isnt 0 (count ecl '(amb blu brn gry grn hzl oth)))))
    (let pid (alref pass 'pid) (and (no:empty pid) (is (len (sym->charlist pid)) 9)))))


(def make-alists (data))

(def run-puzzle (e)
  (count t (map check-passport (list->alist (rectify (dump-puzzle-input 4 e idfn))))))
