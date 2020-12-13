(def run-puzzle (e)
  (withs (buses (map [if (is _ "x") nil (int _)]
		     (tokens (cadr (puzzle-input 13 'strs e)) #\,))
		timestamp 1
		step 1)
   ; find subsolutions. all bus line values are primes, so we can step with their multiples
    (loop (= i 0) (< i (len buses)) (++ i)
      (let bus (buses i)
	(unless (empty bus) ; nil values are kept but ignored to keep indexing intact
	  (while (isnt (mod (+ timestamp i) bus) 0) ; iterate until subsolution is found
	    (= timestamp (+ timestamp step)))
	  (= step (* step bus)))))
    timestamp))
