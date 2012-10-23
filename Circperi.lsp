;;;_____________________Eduardo Magdalena_____________________;;;
;;;_______________________CIRCPERI.LSP _______________________;;;
;;;________________________Versión 1.1________________________;;;
;;;________________________06/10/2012_________________________;;;

;;;________________________Versión 1.1________________________;;;
;;;________________________06/10/2012_________________________;;;

;;; Se añaden comentarios y se optimiza el funcionamiento de la rutina

;;; Comando para dibujar una circunferencia indicando su centro y la longitud de su perímetro.

(defun C:CIRCPERI ( / pto rad peri mens lstvar error0 VARSAVE VARRESC)
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
  (setq error0 *error* *error* errores)
  ;; Activa nuestra propia función de errores
  (command "_.undo" "_begin")
  ;; Principio para el comando desHacer
  (initget 1)
  (setq pto (getpoint "\nCentro de la circunferencia: "))
  ;; Obtiene el centro de la circunferencia.
  (command "_.point" pto)
  ;; Dibuja un punto en el centro.
  (while (not rad)
    (if	(= (getvar "circlerad") 0.0)
      (progn
	(setq mens "\nPerímetro: ")
	(initget 7)
      )
      (progn
	(setq mens (strcat "\nPerímetro <"
			   (rtos (* (getvar "circlerad") 2 pi) 2 2)
			   ">: "
		   )
	)
	(initget 6)
      )
    )
    (if	(not (setq peri (getdist mens)))
      (setq rad (getvar "circlerad"))
      (setq rad (/ peri (* 2 pi)))
    )
    ;; Si se indica una distancia como perímetro, obtiene el radio correspondiente
    ;; Si se muestra un perímetro por defecto y se pulsa Intro como respuesta
    ;; obtiene el radio del ultimo círculo dibujado.
  )
  (setvar "osmode" 0)
  ;; Desactiva los modos de referencia de AutoCAD.
  (command "_.erase" (entlast) "")
  ;; Borra el punto anterior.
  (command "_.circle" pto rad)
  ;; Dibuja el círculo.
  (command "_.undo" "_end")
  ;; Final para el comando desHacer
  (setq *error* error0)
  ;; Activa la función de errores por defecto de AutoCAD
  (VARRESC)
  ;; Restablece los valores iniciales de las variables de sistema modificadas.
  (princ)
)

(prompt "\nNuevo comando CIRCPERI cargado")

;; Modificar la función de tratamiento de errores para que borre las entidades
;; creadas en caso de que existan.