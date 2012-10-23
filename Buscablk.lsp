;;;________________________MecaniCAD__________________________;;;
;;;____________________Rita Dacosta Rodal_____________________;;;
;;;_______________________BUSCABLK.LSP________________________;;;
;;;_______________________Versión 1.0_________________________;;;

;;; Resalta las inserciones de un bloque por medio de una flecha virtual
;;; apuntando al punto de insercion.

(defun C:BUSCABLK
       (/ blk ssblk i nent ent c lstvar VARSAVE VARRESC HLFLECHA)
  (CARGALISP T
	     (list
	       (list "Varsave.lsp" (list "VARSAVE"))
	       (list "Varresc.lsp" (list "VARRESC"))
	       (list "Hlflecha.lsp" (list "HLFLECHA"))
	     )
  )
  ;; Carga las rutinas VARSAVE y VARRESC.
  (VARSAVE '("cmdecho" "osmode"))
  ;; Almacena los valores iniciales de las variables de sistemas a modificar.
  (setvar "cmdecho" 0)
  ;; Desactiva el eco de mensajes.
  (command "_.undo" "_begin")
  (setq	blk
	 (getstring
	   "\nNombre del bloque a buscar [Todos / ENTER para designar un bloque]: "
	 )
  )
  (if (= blk "")
    (progn
      (setq c T)
      (while c
	(setq blk (car (entsel)))
	(if (= "INSERT" (cdr (assoc 0 (entget blk))))
	  (setq	blk (cdr (assoc 2 (entget blk)))
		c   nil
	  )
	  (princ "No ha designado una inserción de un bloque")
	)
      )
    )
    (if	(or (= blk "T") (= blk "t") (= blk "Todos"))
      (setq blk "$Todos$")
    )
  )
  ;; Obtiene el nombre del bloque.
  (cond
    ((= blk "$Todos$")
     (if (tblnext "BLOCK" T)
       (if (setq ssblk (ssget "X" (list (cons 0 "INSERT"))))
	 (progn
	   (setq i    0
		 nent (sslength ssblk)
	   )
	   (while (< i nent)
	     (setq ent (ssname ssblk i))
	     (HLFLECHA ent)
	     (setq i (1+ i))
	   )
	 )
	 (princ "\nNo se ha insertado ningún bloque en el dibujo")
       )
       (princ "\nNo hay bloques definidos en el dibujo")
     )
    )
    (T
     (if (tblsearch "BLOCK" blk)
       (if (setq ssblk (ssget "X" (list (cons 0 "INSERT") (cons 2 blk))))
	 (progn
	   (setq i    0
		 nent (sslength ssblk)
	   )
	   (while (< i nent)
	     (setq ent (ssname ssblk i))
	     (HLFLECHA ent)
	     (setq i (1+ i))
	   )
	 )
	 (princ	(strcat	"\nNo hay inserciones del bloque "
			blk
			" en el dibujo"
		)
	 )
       )
       (princ
	 (strcat "\nEl bloque " blk " no está definido en el dibujo")
       )
     )
    )
  )
  (VARRESC)
  ;; Restablece los valores iniciales de las variables de sistema modificadas.
  (command "_.undo" "_end")
  (princ)
)

(prompt "\nNuevo comando BUSCABLK cargado")