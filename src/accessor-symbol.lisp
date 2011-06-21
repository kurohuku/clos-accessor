(in-package :clos-accessor)

(defmacro with-accessor-symbol (&body body)
  (let ((accessor-symbols
	 (remove-duplicates
	  (remove-if-not
	   #'accessor-symbol?
	   (alexandria:flatten body)))))
    `(symbol-macrolet
	 ,(mapcar #'accessor-symbol->symbol-macrolet-form
		  accessor-symbols)
       ,@body)))

(defun accessor-symbol? (sym)
  (when (symbolp sym)
    (let* ((name (symbol-name sym))
	   (len (length name)))
      (when (> len 2)
	(let ((subname (subseq name 1 (1- len))))
	  (or (find #\. subname)
	      (find #\$ subname)))))))

(defun accessor-symbol->symbol-macrolet-form (sym)
  `(,sym ,(separate-symbol sym)))

(defun separate-symbol (sym)
  (let ((name (symbol-name sym))
	(result nil)
	(pos 0))
    (loop
       :with len = (length name)
       :for dot-pos = (position #\. name :start pos)
       :for dollar-pos =(position #\$ name :start pos)
       :while (< pos len)
       :do
       (cond
	 ((and (null dot-pos) (null dollar-pos))
	  (push (subseq name pos) result)
	  (setf pos len))
	 ((or (null dollar-pos)
	      (and dot-pos (< dot-pos dollar-pos)))
	  (push (subseq name pos dot-pos) result)
	  (push :dot result)
	  (setf pos (1+ dot-pos)))
	 (t ; (or (null dot-pos) (< dollar-pos dot-pos))
	  (push (subseq name pos dollar-pos) result)
	  (push :dollar result)	  
	  (setf pos (1+ dollar-pos)))))
    (labels ((recur (rest acc)
	       (if rest
		   (destructuring-bind (key sel &rest r) rest
		     (case key
		       ((:dot) (recur r `(get-dot-value ,acc ',(intern sel))))
		       ((:dollar) (recur r `(get-dollar-value ,acc ',(intern sel))))
		       (t (error "invalid keyword"))))
		   acc)))
      (let ((lst (nreverse result)))
	(recur (cdr lst) (intern (car lst)))))))