(in-package :clos-accessor-test.accessor)

(plan 2)

(defparameter *obj* nil)
(defparameter *tmp* nil)

;; with-accessor-symbol
(diag "with-accessor-symbol")

(ok (equal
     (macroexpand-1 '(with-accessor-symbol
		      a.b$c))
     '(symbol-macrolet ((a.b$c
			 (get-dollar-value (get-dot-value a 'b) 'c)))
       a.b$c)))
			 

(ok (equal
     (macroexpand-1 '(with-accessor-symbol
		      (setf a.b 2)
		      (b.c 3)))
     '(symbol-macrolet ((a.b (get-dot-value a 'b))
			(b.c (get-dot-value b 'c)))
       (setf a.b 2)
       (b.c 3))))


		    