(in-package :clos-accessor)

(defmacro defmethod* (name (&rest args) &body body)
  (multiple-value-bind
	(forms declarations doc)
      (alexandria:parse-body body :documentation t)
    `(defmethod ,name (,args)
       ,doc
       ,declarations
       (with-accessor-symbol
	 ,@forms))))
