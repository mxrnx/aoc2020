; https://github.com/knarka
; licensed under the MIT license - see LICENSE

(load "lib/strings.arc")

(def caddr (seq)
     (car (cdr (cdr seq))))

#|
Reads a data input line by line, stripping whitespace.
Ignores empty lines, but has trouble with multiple empty lines.
|#
(def read-data (inf)
     (if (peekc inf)
       (cons (trim (readline inf)) (read-data inf))
       nil))

#|
Dumps content of a file into a list with lines,
excluding empty lines.
|#
(def dump-file (x)
     (w/infile inf x
	       (read-data inf)))

#|
Dump (example) data file for a day and part
|#
(def dump-puzzle-input (day (o example))
     (dump-file (string "data/day" day (if example "e") ".data")))


#|
Runs the given day and part if a suitable file exists,
creates a template if it does not exist.
Assumes the day/part has a function called run-puzzle.
|#
(def run (day part (o e nil))
     (= filename (string "day" day "p" part ".arc"))
     (if (file-exists filename)
       (do
	 (load filename)
	 (run-puzzle e))
       (do
	 (w/outfile outf filename (disp (string "(def run-puzzle (e)\n (dump-puzzle-input " day "))") outf))
	 (prn "file " filename " created. good luck!"))))
