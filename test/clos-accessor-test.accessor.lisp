(in-package :clos-accessor-test.accessor)

(plan 13)

(defparameter *obj* nil)
(defparameter *tmp* nil)

(defclass <hoge> ()
  ((a :initarg :a)
   (b :initarg :b)))

;; get-dot-value
(diag "get-dot-value")
(setf *obj* (make-instance '<hoge> :a 10 :b "test"))

(is (get-dot-value *obj* 'a) 10)
(is (get-dot-value *obj* 'b) "test")

;; set-dot-value
(diag "set-dot-value")
(setf *obj* (make-instance '<hoge> :a 10 :b "test"))

(set-dot-value *obj* 'a 2)
(is (slot-value *obj* 'a) 2)
(is (slot-value *obj* 'b) "test")

(set-dot-value *obj* 'b 3)
(is (slot-value *obj* 'a) 2)
(is (slot-value *obj* 'b) 3)

;; (setf get-dot-value)
(diag "(setf get-dot-value)")
(setf *obj* (make-instance '<hoge> :a 10 :b "test"))

(setf (get-dot-value *obj* 'a) 2)
(is (slot-value *obj* 'a) 2)
(is (slot-value *obj* 'b) "test")

(setf (get-dot-value *obj* 'b) 3)
(is (slot-value *obj* 'a) 2)
(is (slot-value *obj* 'b) 3)

;; get-dollar-value
(diag "get-dollar-value")
(setf *obj* (make-instance '<hoge> :a 10 :b "test"))

(handler-case (progn
		(get-dollar-value *obj* 'a)
		(fail "no error"))
  (error (e) (declare (ignore e)) nil))
(setf *obj* (make-hash-table))

(setf (gethash 'a *obj*) "test")
(is (get-dollar-value *obj* 'a) "test")

;; set-dollar-value
(diag "set-dollar-value")

(setf *obj* (make-instance '<hoge> :a 10 :b "test"))

(handler-case (progn
		(set-dollar-value *obj* 'a 2)
		(fail "no error"))
  (error (e) (declare (ignore e)) nil))
(setf *obj* (make-hash-table))

(setf (gethash 'a *obj*) "test")
(set-dollar-value *obj* 'a 3)
(is (get-dollar-value *obj* 'a) 3)

;; (setf get-dollar-value)
(diag "(setf get-dollar-value)")
(setf *obj* (make-instance '<hoge> :a 10 :b "test"))

(handler-case (progn
		(set-dollar-value *obj* 'a 2)
		(fail "no error"))
  (error (e) (declare (ignore e)) nil))
(setf *obj* (make-hash-table))

(setf (gethash 'a *obj*) "test")
(setf (get-dollar-value *obj* 'a) 3)
(is (get-dollar-value *obj* 'a) 3)


