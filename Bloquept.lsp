;;;________________________MecaniCAD__________________________;;;
;;;____________________Rita Dacosta Rodal_____________________;;;
;;;_______________________BLOQUEPT.LSP________________________;;;
;;;_______________________Versión 1.0_________________________;;;

;;; Función que permite copiar una inserción de un bloque en todas
;;; las entidades punto del dibujo.

(defun C:BLOQUEPT (/ sspt ent pt0 i pt1 lstvar VARSAVE VARRESC DXFN)
  (CARGALISP T
	     (list
	       (list "Varsave.lsp" (list "VARSAVE"))
	       (list "Varresc.lsp" (list "VARRESC"))
	       (list "Dxfn.lsp" (list "DXFN"))
	     )
  )
  ;; Carga las rutinas VARSAVE y VARRESC.
  (VARSAVE '("cmdecho" "osmode"))
  ;; Almacena los valores iniciales de las variables de sistemas a modificar.
  (setvar "cmdecho" 0)
  ;; Desactiva el eco de mensajes.
  (command "_.undo" "_begin")
  (princ "\nDesignar entidades punto")
  (setq sspt (ssget (list (cons 0 "POINT"))))
  ;; Designa un conjunto de entidades punto.
  (setvar "osmode" 64)
  ;; Activa el modo de referencia inserción.
  (while (not ent)
    (princ "\nSeleccione una inserción del bloque a copiar")
    (if	(setq ent (entsel))
      (if (/= (DXFN 0 (car ent)) "INSERT")
	(progn
	  (setq ent nil)
	  (princ "\nDebe designar un bloque")
	)
	(setq pt0 (cadr ent)
	      ent (car ent)
	)
      )
    )
  )
  ;; Designa el bloque a insertar.
  (setvar "osmode" 64)
  ;; Desactiva los modos de referencias.
  (setq i 0)
  (while (< i (sslength sspt))
    (setq pt1 (DXFN 10 (ssname sspt i)))

    (command "_copy" ent "" pt0 pt1)
    (setq i (1+ i))
  )
  ;; Copia la inserción del bloque designado.
  (command "_erase" sspt "")
  ;; Borra el conjunto de entidades punto.
  (command "_.undo" "_end")
  (VARRESC)
  ;; Restablece los valores iniciales de las variables de sistema modificadas.
  (princ)
)

(prompt "\nNuevo comando BLOQUEPT cargado")