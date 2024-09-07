;;2023-11-23 유리민 작성
;;참고자료
;;https://forums.autodesk.com/t5/visual-lisp-autolisp-and-general/xclip-boundary-detection/td-p/1732753
;;https://www.cadtutor.net/forum/topic/48854-list-to-selection-set/

(defun c:xcb ( / input obj_num i ett_name output outss)
	(setq input (ssget)) ;;inputobj selection set

	(setq obj_num (sslength input)) ;;obj number

	(setq output (list))
	
	(princ "Selected obj_num :" )(princ obj_num)(princ ",") (princ)

 	(setq i (- obj_num 1))
    (while (> i -1)
		(setq ett_name (ssname input i)) ;; get entity name

		(if (= "INSERT" (cdr (assoc 0 (entget ett_name))))
			(progn
				(setq test (blk:IsClipped (vlax-ename->vla-object ett_name)))
				(if (= nil test)
					(princ)
					(progn
						(setq output (cons ett_name output))
					)
				)
			)
			(princ)
		)
      (setq i (- i 1))
   )

   (setq outss (ssadd))
   (foreach entityToAdd output (ssadd entityToAdd outss))

	(princ "XCLIP BLOCK/XREF Selected : ") (princ (sslength outss))(princ "")

	(command "select" outss "")
)


(defun c:xxcb ( / input obj_num i ett_name output outss)
	(setq input (ssget)) ;;inputobj selection set

	(setq obj_num (sslength input)) ;;obj number

	(setq output (list))
	
	(princ "Selected obj_num :" )(princ obj_num)(princ ",") (princ)

 	(setq i (- obj_num 1))
    (while (> i -1)
		(setq ett_name (ssname input i)) ;; get entity name

		(if (= "INSERT" (cdr (assoc 0 (entget ett_name))))
			(progn
				(setq test (blk:IsClipped (vlax-ename->vla-object ett_name)))
				(if (= nil test)
					(progn
						(setq output (cons ett_name output))
					)
					(princ)
				)
			)
			(princ)
		)
      (setq i (- i 1))
   )

   (setq outss (ssadd))
   (foreach entityToAdd output (ssadd entityToAdd outss))

	(princ "Non XCLIP BLOCK/XREF Selected : ") (princ (sslength outss))(princ "")

	(command "select" outss "")
)



(defun blk:IsClipped (b / r xd f s)
;|Description:
Return T if a block or Xref is XClipped.
Parameters:
b - Block Reference vla-object
Return Value:
t - Objects is XClipped
nil - Object is not XClipped
|;
(setq r
(vl-catch-all-apply
'(lambda ()
(cond ( ( and (= :vlax-true (vla-get-HasExtensionDictionary b))
(setq xd (vla-GetExtensionDictionary b))
(setq f (vla-GetObject xd "ACAD_FILTER"))
(setq s (vla-GetObject f "SPATIAL"))
)
)
)
)
)
)
(if (vl-catch-all-error-p r)
nil
r
)
)

