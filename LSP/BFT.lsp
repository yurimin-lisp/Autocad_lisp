;;PROGRAMED BY RIMIN YU
;;LAST UPDATED 12-01-2023

;;BFT:텍스트를 박스에 맞춘다




(defun c:BFT(/ inputobj th sty lay col inputstr P1 P2 P3 dx l_point r_point OSN col_mem lay_mem)
   (setq inputobj (ssget "+.:E" '((0 . "text"))));;
   (setq th (cdr (assoc 40 (entget (ssname inputobj 0)))))
   (setq sty (cdr (assoc 7 (entget (ssname inputobj 0)))))
   (setq lay (cdr (assoc 8 (entget (ssname inputobj 0)))))
   (setq col (cdr (assoc 62 (entget (ssname inputobj 0)))))
   (setq inputstr (cdr (assoc 1 (entget (ssname inputobj 0)))))
   (if (= col nil)
      (setq col "bylayer")
   )


   (setq P1 (GETPOINT "INPUT POINT1 : " ))
   (setq P2 (GETCORNER P1 "INPUT POINT2 : " ))
   (setq P3 (list (/ (+ (car P1) (car P2)) 2) (/ (+ (cadr P1) (cadr P2)) 2)  )) ;;중심
   (setq dx (* (abs (- (car p1) (car p2))) 0.9) )


   (setq l_point (list (- (car P3) (/ dx 2)) (- (cadr P3) (* th 0.5))))
   (setq r_point (list (+ (car P3) (/ dx 2)) (- (cadr P3) (* th 0.5))))
   (SETQ OSN (GETVAR "OSMODE"))
   (SETQ col_mem (GETVAR "CECOLOR"))
   (SETQ lay_mem (GETVAR "CLAYER"))
   (SETVAR "OSMODE" 0)
   (command "cecolor" col)
   (command "clayer" lay)
   (command "_.text" "s" sty "j" "f" l_point r_point th inputstr)
   (command "erase" inputobj "")
   (command "cecolor" col_mem)
   (command "clayer" lay_mem)
   (SETVAR "OSMODE" OSN)
)
