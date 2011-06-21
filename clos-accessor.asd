;;;; -*- mode: lisp; syntax: common-lisp; coding:utf-8 -*-

(require 'asdf)

(asdf:defsystem clos-accessor
  :description "CLOS accessor methods"
  :author "kurohuku"
  :version "0.1"
  :depends-on (:alexandria)
  :components
  ((:file "package")
   (:module "src"
	    :depends-on ("package")
	    :components
	    ((:file "accessor")
	     (:file "accessor-symbol" :depends-on ("accessor"))))))


(asdf:defsystem clos-accessor-test
    :depends-on (:clos-accesor :cl-test-more)
    :components
    ((:module "test"
	      :components
	      ((:file "test-accessor")
	       (:file "test-accessor-symbol")))))

