;;;________________________MecaniCAD__________________________;;;
;;;____________________Rita Dacosta Rodal_____________________;;;
;;;_________________________ARAND.LSP_________________________;;;
;;;_______________________Versión 1.0_________________________;;;

;;; Comando para dibujar arandelas.

(defun C:ARAND ( / pto radi rade lstvar VARSAVE VARRESC )
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
  (setq pto (getpoint "\nCentro de la arandela: "))
  ;; Obtiene el centro de la arandela.
  (initget 7 "Diametro")
  (setq radi (getdist pto "\nRadio interior o [Diámetro]: "))
  ;; Obtiene el radio interior.
  (if (= radi "Diametro")
    (progn
      (initget 7)
      (setq radi (/ (getdist pto "\nDiámetro interior: ") 2.0))
      )
    )
  ;; Si se ha seleccionado la opción "Diametro", pregunta por el diametro interior.
  (setvar "osmode" 0)
  ;; Desactiva los modos de referencia.
  (command "_.circle" pto radi)
  ;; Dibuja el círculo interior.
  (setvar "osmode" (cdr (assoc "osmode" lstvar)))
  ;; Recupera los modos de referencia.
  (while (or (not rade) (not (< radi rade)))
    (initget 7 "Diametro")
    (setq rade (getdist pto "\nRadio exterior o [Diámetro]: "))   
    (if (= rade "Diametro")
      (progn
	(initget 7)
	(setq rade (/ (getdist pto "\nDiámetro exterior: ") 2.0))
	)
      )
    ;; Si se ha seleccionado la opción "Diametro", pregunta por el diametro exterior.
    (if (not (< radi rade))
      (princ (strcat "\nEl radio exterior debe ser mayor de " (rtos radi)))
      )
    ;; Si el radio exterior no es mayor que el interior, lo indica.
    )
  ;; Mientras no se indique un radio exterior mayor que el interior continua pidiéndolo.
  (setvar "osmode" 0)
  ;; Desactiva los modos de referencia.
  (command "_.circle" pto rade)
  ;; Dibuja el círculo exterior.
  (command "_.undo" "_end")
  (VARRESC)
  ;; Restablece los valores iniciales de las variables de sistema modificadas.
  (prin1)
  )

(prompt "\nNuevo comando ARAND cargado")