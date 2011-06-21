;;;; -*- mode: lisp; syntax: common-lisp; coding:utf-8 -*-

(defpackage clos-accessor
  (:use cl)
  (:export get-dot-value
	   set-dot-value
	   get-dollar-value
	   set-dollar-value
	   with-accessor-symbol
	   defmethod*))


