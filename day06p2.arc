(def split-data (data)
  (map [tokens _ #\newline] (tokens (subst #\! "\n\n" data) #\!)))

(def find-duplicates (seq)
  (if (no:cdr seq)
      (len (car seq))
      (find-duplicates (cons (keep [pos _ (car seq)] (cadr seq)) (cddr seq)))))

(def run-puzzle (e)
  (apply + (map find-duplicates (split-data (puzzle-input 6 'chrs e)))))
