;;;________________________MecaniCAD__________________________;;;
;;;____________________Rita Dacosta Rodal_____________________;;;
;;;________________________BLQCAPA.LSP________________________;;;
;;;_______________________Versión 1.0_________________________;;;

;;; Comando para bloquear las capas de las entidades designadas.

(defun C:BLQCAPA (/ ent capa lstvar VARSAVE VARRESC DXFN)
  (CARGALISP T
	     (list
	       (list "Varsave.lsp" (list "VARSAVE"))
	       (list "Varresc.lsp" (list "VARRESC"))
	       (list "dxfn.lsp" (list "DXFN"))
	     )
  )
  ;; Carga las rutinas VARSAVE y VARRESC.
  (VARSAVE '("cmdecho" "clayer"))
  ;; Almacena los valores iniciales de las variables de sistemas a modificar.
  (setvar "cmdecho" 0)
  ;; Desactiva el eco de mensajes.
  (command "_.undo" "_begin")
  (while (setq ent (car (entsel)))
    (setq capa (DXFN 8 ent))
    (if	(= (logand (cdr (assoc 70 (tblsearch "LAYER" capa))) 4) 0)
      (progn
	(command "_-layer" "_lo" capa "")
	(princ (strcat "\nSe ha bloqueado la capa " capa))
      )
      (princ (strcat "\nLa capa " capa " ya está bloqueada"))
    )
  )
  (VARRESC)
  ;; Restablece los valores iniciales de las variables de sistema modificadas.
  (command "_.undo" "_end")
  (princ)
)

(prompt "\nNuevo comando BLQCAPA cargado")