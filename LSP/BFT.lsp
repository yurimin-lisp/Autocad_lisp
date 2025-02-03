;;PROGRAMED BY RIMIN YU
;;LAST UPDATED 01-23-2025

;;BFT:텍스트를 박스에 맞춘다


(defun C:BFT () (BoxFitText))

(defun BoxFitText (/ CEC CLA CST OSN CMDE inputobj th tw sty lay col inputstr ro P1 P2 P3 dx tdx l_point 
                   r_point
                  ) 

  (defun *error* (msg) 
    (if (= nil CEC)
      (progn)
      (setvar "CECOLOR" CEC)
    )
    (if (= nil CLA)
      (progn)
      (setvar "CLAYER" CLA)
    )
    (if (= nil CST)
      (progn)
      (setvar "TEXTSTYLE" CST)
    )
    (if (= nil OSN)
      (progn)
      (setvar "OSMODE" OSN)
    )
    (if (= nil CMDE)
      (progn)
      (setvar "CMDECHO" CMDE)
    )
    (command "UNDO" "E")
  )


  (setq inputobj (ssget "+.:E" '((0 . "text")))) ;;
  (setq th (cdr (assoc 40 (entget (ssname inputobj 0)))))
  (setq tw (cdr (assoc 41 (entget (ssname inputobj 0)))))
  (setq sty (cdr (assoc 7 (entget (ssname inputobj 0)))))
  (setq lay (cdr (assoc 8 (entget (ssname inputobj 0)))))
  (setq col (cdr (assoc 62 (entget (ssname inputobj 0)))))
  (setq inputstr (cdr (assoc 1 (entget (ssname inputobj 0)))))
  ;;(setq ro (cdr (assoc 50 (entget (ssname inputobj 0)))))
  (if (= col nil) 
    (setq col "bylayer")
  )


  (setq P1 (GETPOINT "INPUT POINT1 : "))
  (setq P2 (GETCORNER P1 "INPUT POINT2 : "))
  (setq P3 (list (/ (+ (car P1) (car P2)) 2) (/ (+ (cadr P1) (cadr P2)) 2))) ;;중심

  (setq dx (abs (- (car p1) (car p2))))
  ;;(setq boxro (angle P1 P2))

  ;;(setq dx (/ dx (cos (- dx boxro))) )

  (setq dx (* dx 0.9))

  ;;(setq tdx (textbox '((1 . inputstr))))
  ;;(setq tdx (textbox (list 1 inputstr)))

  ;;(princ tdx)

  ;;(setq tdx (abs (- (car (car tdx)) (car (cadr tdx)))))

  ;;(princ tdx)


  (setq l_point (list (- (car P3) (/ dx 2)) (- (cadr P3) (* th 0.5))))
  (setq r_point (list (+ (car P3) (/ dx 2)) (- (cadr P3) (* th 0.5))))
  
  
  (setq CEC (getvar "CECOLOR"))
  (setq CLA (getvar "CLAYER"))
  (setq CST (getvar "TEXTSTYLE"))
  (setq OSN (getvar "OSMODE"))
  (setq CMDE (getvar "CMDECHO"))
  (command "UNDO" "BE")
  (setvar "OSMODE" 0)
  (setvar "CMDECHO" 0)
  
  
  (setvar "cecolor" col)
  (setvar "clayer" lay)
  (command "_.text" "s" sty "j" "f" l_point r_point th inputstr)
  (command "erase" inputobj "")

  
  (setvar "CECOLOR" CEC)
  (setvar "CLAYER" CLA)
  (setvar "TEXTSTYLE" CST)
  (setvar "OSMODE" OSN)
  (setvar "CMDECHO" CMDE)
  (command "UNDO" "E")
  
)
