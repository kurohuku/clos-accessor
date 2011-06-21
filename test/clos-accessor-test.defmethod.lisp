(in-package :clos-accessor-test.defmethod)

(plan 1)


;; defmethod*
(diag "defmethod*")

(ok (equal
     (macroexpand-1
      '(defmethod* hello ((hoge <fuga>) a)
	"document"
	(declare (ignore a))
	(format t "hello ~A" hoge.name)))
     '(defmethod hello ((hoge <fuga>) a)
       "document"
       (declare (ignore a))
       (with-accessor-symbol
	   (format t "hello ~A" hoge.name)))))

