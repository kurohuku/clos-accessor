;;;; -*- mode: lisp; syntax: common-lisp; coding:utf-8 -*-

(defpackage clos-accessor
  (:use cl)
  (:export get-dot-value
	   set-dot-value
	   get-dollar-value
	   set-dollar-value
	   with-accessor-symbol
	   defmethod*))

(defpackage clos-accessor-test.accessor
  (:use cl clos-accessor cl-test-more))


(defpackage clos-accessor-test.accessor-symbol
  (:use cl clos-accessor cl-test-more))

(defpackage clos-accessor-test.defmethod
  (:use cl clos-accessor cl-test-more))
  
