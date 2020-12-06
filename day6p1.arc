(def run-puzzle (e)
 (apply + (map [len (dedup _)] (tokens (string (puzzle-input 6 'strs e)) #\newline))))
