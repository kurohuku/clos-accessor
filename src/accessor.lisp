(in-package :clos-accessor)

;;; generic function
(defgeneric get-dot-value (obj arg))
(defgeneric set-dot-value (obj arg new))
(defmethod (setf get-dot-value) (new obj arg)
  (set-dot-value obj arg new))

(defgeneric get-dollar-value (obj arg))
(defgeneric set-dollar-value (obj arg new))
(defmethod (setf get-dollar-value) (new obj arg)
  (set-dollar-value obj arg new))


;;; method
(defmethod get-dot-value (obj slot)
  (slot-value obj slot))
(defmethod set-dot-value (obj slot new)
  (setf (slot-value obj slot) new))

(defmethod get-dollar-value ((obj hash-table) arg)
  (gethash arg obj))
(defmethod set-dollar-value ((obj hash-table) arg new)
  (setf (gethash arg obj) new))

