;;;________________________MecaniCAD__________________________;;;
;;;____________________Rita Dacosta Rodal_____________________;;;
;;;_______________________CARGALISP.LSP_______________________;;;
;;;_______________________Versión 1.0_________________________;;;

;;; Recibe una lista en la que cada elemento está formado por un nombre de archivo
;;; y una lista de funciones y variables globales definidas en dicho archivo.
;;; En caso de que alguna de las funciones (o variables globales) indicadas no esté
;;; definida carga el archivo en el que se encuentran.

(defun CARGALISP (flag lst /)
  (while lst
    (if	(not (apply 'and (atoms-family 1 (cadar lst))))
      ;; Comprueba si las funciones ya están cargadas.
      (if (not (findfile (caar lst)))
	(alert (strcat "No se ha encontrado el archivo " (caar lst))
	)
	;; No se encuentra el archivo.
	(progn
	  (load (caar lst))
	  ;; Carga el archivo.
	  (if (not flag)
	    (prompt (strcat "\nCargando archivo " (caar lst) "..."))
	  )
	  ;; Si la banderilla no es T indica que se ha cargado el archivo.
	)
	;; Se encuentra el archivo.
      )
    )
    (setq lst (cdr lst))
    ;; Pasa al siguiente elemento de la lista.
  )
  (princ)
)