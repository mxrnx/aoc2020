(= traveled (table))
(= heading 'E)
(= directions '(N E S W))

(def go (d n) (= (traveled d) (+ (traveled d) n)))

(def N (n) (go 'N n))
(def E (n) (go 'E n))
(def S (n) (go 'S n))
(def W (n) (go 'W n))

(def F (n) (go heading n))
(def R (degrees) (withs (steps (/ degrees 90)
			       ind (pos heading directions))
		   (while (>= (+ ind steps) 4)
		     (= steps (- steps 4)))
		   (= heading (directions (+ ind steps)))))
(def L (degrees) (R (- 360 degrees)))


(def fix-data (seq)
  (map [list (sym (_ 0)) (int (cut _ 1))] seq))

(def run-puzzle (e)
  (each x (fix-data (puzzle-input 12 'strs e))
    (eval x))
  (+ (abs (- (traveled 'N) (traveled 'S))) (abs (- (traveled 'E) (traveled 'W)))))
