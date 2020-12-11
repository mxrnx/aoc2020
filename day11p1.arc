; returns a list of the eight squares surrounding the square at x, y
(def surround (data x y)
  (accum accfn
    (each i (range -1 1)
      (each j (range -1 1)
	(if 
	  (and (is i 0) (is j 0)) nil
	  (or (< (+ x i) 0) (< (+ y j) 0) (>= (+ x i) (len:car data)) (>= (+ y j) (len data))) (accfn #\.)
	  (accfn ((data (+ y j)) (+ x i))))))))

; simulates one tick in the world, returns it if output == input
(def sim (data)
  (let out (map copy data)
    (each x (range 0 (- (len:car data) 1))
      (each y (range 0 (- (len data) 1))
	(let neighbors (surround data x y)
	  (unless (is ((data y) x) #\.)
	    (if (is (pos #\# neighbors) nil) (= ((out y) x) #\#)
		(>= (count #\# neighbors) 4) (= ((out y) x) #\L))))))
    (if (iso data out) out
	(sim out))))

;pretty print the game world
(def prn-world (data)
  (each line data (prn line)) data)

(def run-puzzle (e)
  (apply + (map [count #\# _] (prn-world (sim (prn-world (puzzle-input 11 'strs e)))))))
