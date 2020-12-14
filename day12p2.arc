(= traveled (table))
(= wp-east 10)
(= wp-north 1)

(def go (d n) (= (traveled d) (+ (traveled d) n)))

(def N (n) (= wp-north (+ wp-north n)))
(def S (n) (N (- n)))
(def E (n) (= wp-east (+ wp-east n)))
(def W (n) (E (- n)))

(def F (n)
  (repeat n (go 'E wp-east))
  (repeat n (go 'N wp-north)))

(def R (degrees) (let steps (mod (/ degrees 90) 4)
		   (case steps
		     1 (do (swap wp-east wp-north) (= wp-north (- wp-north)))
		     2 (do (= wp-north (- wp-north)) (= wp-east (- wp-east)))
		     3 (do (swap wp-east wp-north) (= wp-east (- wp-east))))))

(def L (degrees) (R (- 360 degrees)))


(def fix-data (seq)
  (map [list (sym (_ 0)) (int (cut _ 1))] seq))

(def run-puzzle (e)
  (each x (fix-data (puzzle-input 12 'strs e))
    (eval x))
  (+ (abs (traveled 'E)) (abs (traveled 'N))))
