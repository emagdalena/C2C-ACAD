;;;________________________MecaniCAD__________________________;;;
;;;____________________Rita Dacosta Rodal_____________________;;;
;;;________________________CBLOCK.LSP_________________________;;;
;;;_______________________Versión 1.0_________________________;;;

;;; Sustituye todas las inserciones de un bloque, o los bloques seleccionados, por otro bloque.

(defun C:CBLOCK	(/	 blk	 c	 ssblk	 i	 nent
		 ent	 blkn	 pto	 esc	 ang	 lstvar
		 VARSAVE VARRESC RAG	 HLFLECHA	 DXFN
		)
  (CARGALISP T
	     (list
	       (list "Varsave.lsp" (list "VARSAVE"))
	       (list "Varresc.lsp" (list "VARRESC"))
	       (list "rag.lsp" (list "RAG"))
	       (list "hlflecha.lsp" (list "HLFLECHA"))
	       (list "dxfn.lsp" (list "DXFN"))
	     )
  )
  ;; Carga las rutinas VARSAVE, VARRESC, RAG, HLFLECHA y DXFN.
  (VARSAVE '("cmdecho" "osmode"))
  ;; Almacena los valores iniciales de las variables de sistemas a modificar.
  (setvar "cmdecho" 0)
  ;; Desactiva el eco de mensajes.
  (command "_.undo" "_begin")
  (setq	blk
	 (getstring
	   "\nNombre del bloque [Todos / ENTER para designar un bloque]: "
	 )
  )
  (if (= blk "")
    (progn
      (setq c T)
      (while c
	(setq blk (car (entsel)))
	(if (= "INSERT" (DXFN 0 blk))
	  (setq	blk (DXFN 2 blk)
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
  ;; Crea un conjunto de designación con las inserciones del bloque a sustituir.
  (setq blkn (getstring "\nNuevo bloque [ENTER para designarlo]: "))
  (if (= blkn "")
    (progn
      (setq c T)
      (while c
	(setq blkn (car (entsel)))
	(if (= "INSERT" (DXFN 0 blkn))
	  (setq	blkn (DXFN 2 blkn)
		c    nil
	  )
	  (princ "No ha designado una inserción de un bloque")
	)
      )
    )
  )
  ;; Obtiene el nombre del bloque.
  (command "_regen")
  ;; Limpia las flechas virtuales de la pantalla.
  (setq	i    0
	nent (sslength ssblk)
  )
  (while (< i nent)
    (setq ent (ssname ssblk i))
    (setq pto (DXFN 10 ent))
    (setq esc (list (DXFN 41 ent) (DXFN 42 ent) (DXFN 43 ent)))
    (setq ang (DXFN 50 ent))
    (command "_erase" ent "")
    (if	(/= 1.0 (caddr esc))
      (command "_-insert"
	       blkn
	       pto
	       "_xyz"
	       (car esc)
	       (cadr esc)
	       (caddr esc)
	       (RAG ang)
      )
      (command "_-insert" blkn pto (car esc) (cadr esc) (RAG ang))
    )
    (setq i (1+ i))
  )
  (VARRESC)
  ;; Restablece los valores iniciales de las variables de sistema modificadas.
  (command "_.undo" "_end")
  (princ)
)

(prompt "\nNuevo comando CBLOCK cargado")