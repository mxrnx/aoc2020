; convert `val` from base `from` to base `to`
(def base (val from to (o i 0))
  (if (is 0 val)
      0
      (+ (* (expt from i) (mod val to)) (base (trunc (/ val to)) from to (+ i 1)))))

; given a binary mask `mask` and a binary value `val`, masks the value
; using the mask, with X->X, 1->1, and ignoring 0es in the mask
(def maskval (mask val)
  (withs (s-val (string val)
		s-mask (string mask))
    (= s-val (string (n-of (- (len s-mask) (len s-val)) #\0) s-val))
    (forlen i s-mask
      (unless (is (s-mask i) #\0)
	(= (s-val i) (s-mask i))))
    s-val))

; look up memory location
(def memloc (seq)
  (int (cut (cadr (tokens seq #\[)) 0 -1)))

; given a binary string with Xes, returns two strings with the X swapped for
; a 0 and a 1
(def find-addresses (seq)
  (let i (pos #\X seq)
    (if (empty i) seq
      (list (string (cut seq 0 i) 0 (cut seq (+ i 1)))
	    (string (cut seq 0 i) 1 (cut seq (+ i 1)))))))

; masks a memory location, exploding all Xes in it
(def mask-memloc (mask seq)
  (let addrs (list (string (maskval mask (base (memloc seq) 10 2))))
    (while (no:empty (pos #\X (car addrs)))
      (= addrs (rem nil (flat (map find-addresses addrs)))))
    addrs))

(def run-puzzle (e)
  (withs (data (map [tokens _ #\ ] (puzzle-input 14 'strs e))
	       mask nil
	       fmem (table))
    (each op data
      (if (is (car op) "mask") (= mask (caddr op))
	  (let val (int (caddr op))
	    (map [= (fmem _) val]
		 (mask-memloc mask (car op))))))
    (apply + (vals fmem))))
