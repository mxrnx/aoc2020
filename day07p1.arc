(def get-bags (seq app)
  (if (in (caddr seq) 'bag 'bags 'bag. 'bags.)
      (app (sym:string (car seq) (cadr seq))))
  (and seq (get-bags (cdr seq) app)))

(def data->alist (seq)
  (let x (accum app (get-bags seq app))
    (list (car x) (cdr x))))

(def holds-shiny-gold (bag all-bags)
  (if (is bag 'noother) nil
      (is bag 'shinygold) t
      (find t (map [holds-shiny-gold _ all-bags] (cadr (assoc bag all-bags))))))

(def run-puzzle (e)
  (let all-bags (map [data->alist (readall (subst "" "," _))] (puzzle-input 7 'strs e))
    (- (count t (map [holds-shiny-gold (car _) all-bags] all-bags)) 1)))
