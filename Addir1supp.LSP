;;;____________________Eduardo Magdalena______________________;;;
;;;____________________www.emagdalena.es______________________;;;
;;;______________________ADDIR1SUPP.LSP_______________________;;;
;;;_______________________Versi�n 1.0_________________________;;;

;;; A�ade un directorio a los directorios de soporte de AutoCAD.

(defun ADDIR1SUPP ( dir / dirsupp STR2LSTCHR )
  (vl-load-com)
  (setq lst nil dirsupp (strcase (getenv "ACAD")))
  (while (setq posicion (vl-string-position (ascii ";") dirsupp))
    (setq lst (cons (substr dirsupp 1 posicion) lst))
    (setq dirsupp (substr dirsupp (+ posicion 2)))
    )
  ;; Obtenemos una lista de los directorios de soporte.
  (if (not (member (strcase dir) lst))
    (setenv "ACAD" (strcat dir ";" (getenv "ACAD")))
    )
  ;; Si el directorio no es uno de los directorios de soporte, lo a�ade.
  )