; inner function for surround. steps in the direction of xstep and ystep, either
; until it encounters an occupied/unoccupied seat, or until it passes the world border.
(def step (data x y xstep ystep accfn)
  (withs (i (+ x xstep) j (+ y ystep))
    (if (or (< i 0) (< j 0) (>= i (len:car data)) (>= j (len data))) (accfn #\.)
	(is #\# ((data j) i)) (accfn #\#)
	(is #\L ((data j) i)) (accfn #\L)
	(step data i j xstep ystep accfn))))

; returns the first visible seat in eight directions
(def surround (data x y)
  (accum accfn
    (each xstep (range -1 1)
      (each ystep (range -1 1)
	(unless (and (is xstep 0) (is ystep 0))
	  (step data x y xstep ystep accfn))))))

; simulates one tick in the world, returns it if output == input
(def sim (data)
  (let out (map copy data)
    (each x (range 0 (- (len:car data) 1))
      (each y (range 0 (- (len data) 1))
	(let neighbors (surround data x y)
	  (unless (is ((data y) x) #\.)
	    (if (is (pos #\# neighbors) nil) (= ((out y) x) #\#)
		(>= (count #\# neighbors) 5) (= ((out y) x) #\L))))))
    (prn-world out)
    (if (iso data out) out
	(sim out))))

;pretty print the game world
(def prn-world (data)
  (each line data (prn line)) (prn) data)

(def run-puzzle (e)
  (apply + (map [count #\# _] (sim (puzzle-input 11 'strs e)))))
