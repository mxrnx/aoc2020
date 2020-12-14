; convert `val` from base `from` to base `to`
(def base (val from to (o i 0))
  (if (is 0 val)
      0
      (+ (* (expt from i) (mod val to)) (base (trunc (/ val to)) from to (+ i 1)))))

; given a binary mask `mask` and a binary value `val`, masks the value
; using the mask, with 0->0, 1->1, and ignoring Xes in the mask
(def maskval (mask val)
  (withs (s-val (string val)
		s-mask (string mask))
    (= s-val (string (n-of (- (len s-mask) (len s-val)) #\0) s-val))
    (forlen i s-mask
      (unless (is (s-mask i) #\X)
	(= (s-val i) (s-mask i))))
    (base (int s-val) 2 10)))

; look up memory location
(def memloc (seq)
  (int (cut (cadr (tokens seq #\[)) 0 -1)))

(def run-puzzle (e)
  (withs (data (map [tokens _ #\ ] (puzzle-input 14 'strs e))
	       mask nil
	       fmem (table))
    (each op data
      (if (is (car op) "mask") (= mask (caddr op))
	  (= (fmem (memloc (car op))) (maskval mask (base (int (caddr op)) 10 2)))))
    (apply + (vals fmem))))
