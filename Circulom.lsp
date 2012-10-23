;;;________________________MecaniCAD__________________________;;;
;;;____________________Rita Dacosta Rodal_____________________;;;
;;;_______________________CIRCULOM.LSP________________________;;;
;;;_______________________Versi�n 1.0_________________________;;;

;;; Comando para dibujar m�ltiples c�rculos conc�ntricos.

(defun C:CIRCULOM (/ pto rad lstvar VARSAVE VARRESC)
  (CARGALISP T
	     (list
	       (list "Varsave.lsp" (list "VARSAVE"))
	       (list "Varresc.lsp" (list "VARRESC"))
	     )
  )
  ;; Carga las rutinas VARSAVE y VARRESC.
  (VARSAVE '("cmdecho" "osmode"))
  ;; Almacena los valores iniciales de las variables de sistemas a modificar.
  (setvar "cmdecho" 0)
  ;; Desactiva el eco de mensajes.
  (command "_.undo" "_begin")
  (initget 1)
  (setq pto (getpoint "\nCentro: "))
  ;; Obtiene el centro de los c�rculos.
  (initget 6 "Diametro")
  (while (setq rad (getdist pto
			    "\nRadio o [ Di�metro / Intro para terminar]: "
		   )
	 )
    (setvar "osmode" 0)
    ;; Descativa los modos de referencia.
    (if	(= rad "Diametro")
      (progn
	(initget 7)
	(setq rad (/ (getdist pto "\nDi�metro: ") 2.0))
      )
    )
    ;; Si se ha seleccionado la opci�n di�metro pregunta por el di�metro.
    (command "_.circle" pto rad)
    ;; Dibuja un circulo.
    (setvar "osmode" (cdr (assoc "osmode" lstvar)))
    ;; Activa los modos de referencia.
    (initget 6 "Diametro")
  )
  ;; Mientras se indiquen los radios dibuja los c�rculos correspondientes.
  (VARRESC)
  ;; Restablece los valores iniciales de las variables de sistema modificadas.
  (command "_.undo" "_end")
  (princ)
)

(prompt "\nNuevo comando CIRCULOM cargado")