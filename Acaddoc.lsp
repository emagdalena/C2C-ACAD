;;;________________________MecaniCAD__________________________;;;
;;;____________________Rita Dacosta Rodal_____________________;;;
;;;_______________________ACADDOC.LSP_________________________;;;
;;;_______________________Versión 1.0_________________________;;;

(setvar "cmdecho" 0)
;; Desactiva el eco de mensajes.
(autoload "arand" '("arand"))
(autoload "oblongo" '("oblongo"))
(autoload "circperi" '("circperi"))
(autoload "circulom" '("circulom"))
(autoload "zigzag" '("zigzag"))
(autoload "lincorte" '("lincorte"))
(autoload "lineje" '("lineje"))
(autoload "mcopia" '("mcopia"))
(autoload "moffset" '("moffset"))
(autoload "textbox" '("textbox"))
(autoload "cotadiam" '("cotadiam"))
(autoload "dimarc" '("dimarc"))
(autoload "capinf" '("capinf"))
(autoload "delcap" '("delcap"))
(autoload "att2txt" '("att2txt"))
(autoload "giraatr" '("giraatr"))
(autoload "allblkdisc" '("allblkdisc"))
(autoload "redefinsblk" '("redefinsblk"))
(autoload "bloquept" '("bloquept"))
(autoload "buscablk" '("buscablk"))
(autoload "cblock" '("cblock"))
(autoload "insertbrk" '("insertbrk"))
(autoload "cojincil" '("cojincil"))
(autoload "cojinval" '("cojinval"))
(autoload "cojinesf" '("cojinesf"))
(autoload "cojinesfc" '("cojinesfc"))
(autoload "PerfilIPN" '("PerfilIPN"))
(autoload "PerfilIPE" '("PerfilIPE"))
(autoload "PerfilHEB" '("PerfilHEB"))
(autoload "PerfilUPN" '("PerfilUPN"))
(autoload "PerfilLPN" '("PerfilLPN"))
(autoload "PerfilLPD" '("PerfilLPD"))
(autoload "metridiam" '("metridiam"))
(autoload "inutcapa" '("inutcapa"))
(autoload "desactcapa" '("desactcapa"))
(autoload "blqcapa" '("blqcapa"))
(autoload "desblqcapa" '("desblqcapa"))
;; Carga automática de las rutinas utilizadas.
(setvar "cmdecho" 1)
;; Activa el eco de mensajes.
(prin1)
