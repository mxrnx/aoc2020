(def get-bags (seq app)
  (when (>= (len seq) 4)
    (when (and (in (seq 3) 'bag 'bags 'bag. 'bags.) (isnt (cadr seq) 'no))
      (app (cons (sym:string (cadr seq) (caddr seq)) (int (car seq)))))
    (get-bags (cdr seq) app)))

(def data->alist (seq)
  (let x (accum app (get-bags seq app))
    (list (sym:string (car seq) (cadr seq)) x)))

(def number-of-children (bag all-bags)
  (let children (cadr (assoc bag all-bags))
    (apply + (flat:list (map cdr children) (map [* (number-of-children (car _) all-bags) (cdr _)] children)))))

(def run-puzzle (e)
  (number-of-children 'shinygold (map [data->alist (readall (subst "" "," _))] (puzzle-input 7 'strs e))))
