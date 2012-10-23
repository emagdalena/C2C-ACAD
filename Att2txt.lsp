;;;________________________MecaniCAD__________________________;;;
;;;____________________Rita Dacosta Rodal_____________________;;;
;;;________________________ATT2TXT.LSP________________________;;;
;;;_______________________Versión 1.0_________________________;;;

;;; Descompone bloques, convirtiendo sus atributos en textos.

(defun C:ATT2TXT ( / ss i entl lstent lstvar VARSAVE VARRESC DXFN )
  (CARGALISP T
    (list
      (list "Varsave.lsp" (list "VARSAVE"))
      (list "Varresc.lsp" (list "VARRESC"))
      (list "dxfn.lsp" (list "DXFN"))      
      )
    )
  ;; Carga las rutinas VARSAVE, VARRESC y DXFN.
  (VARSAVE '("cmdecho"))
  ;; Almacena los valores iniciales de las variables de sistemas a modificar.
  (setvar "cmdecho" 0)
  ;; Desactiva el eco de mensajes.
  (command "_.undo" "_begin")
  (princ "\nDesigne las inserciones de bloque a descomponer...")
  (while (not (setq ss (ssget (list (cons 0 "INSERT"))))))
  ;; Creamos un conjunto de designación con las inserciones de bloques indicadas
  (princ (strcat "\nSe han designado " (itoa (sslength ss)) " inserciones de bloques"))
  (setq i 0)
  (repeat (sslength ss)
    (setq entl (ssname ss i) lstent nil)
    (while (/= "SEQEND" (DXFN 0 (setq entl (entnext entl))))
      (setq lstent
	     (cons
	       (cons
		 (cons 0 "TEXT")
		 (reverse
		   (cdr
		     (member '(100 . "AcDbAttribute")
			     (reverse
			       (member '(100 . "AcDbEntity") (entget entl))
			       )
			     )
		     )
		   )
		 )
	       lstent
	       )
	    )
      )
    (setq entl (entlast))
    (command "_explode" (ssname ss i))
    (while (setq entl (entnext entl))
      (if (= "ATTDEF" (DXFN 0 entl))
	(command "_erase" entl "")
	)
      )
    (mapcar 'entmake lstent)
    (setq i (1+ i))
    )
  (VARRESC)
  ;; Restablece los valores iniciales de las variables de sistema modificadas.
  (command "_.undo" "_end")
  (princ)
  )

(prompt "\nNuevo comando ATT2TXT cargado")