;;PROGRAMED BY RIMIN YU
;;LAST UPDATED 09-07-2024

;;JD : 정확한 간격 맞춰서 조명 배치
;;JD2 : 300에 맞춰서 조명 배치

(defun c:jd (/ P1 P2 P3 P4 PR NX NY OBJ DX DY I1 I2 OSN)
   (command "undo" "be")
   (setq OBJ (ssget ":E" ))
   (setq PR (GETPOINT "INPUT Ref Point : " ))
   (setq P1 (GETPOINT "INPUT POINT1 : " ))
   (setq P2 (GETCORNER P1 "INPUT POINT2 : " ))
   (setq DX (abs (- (car P1) (car P2))))
   (setq DY (abs (- (cadr P1) (cadr P2))))
   
  (setq NX (GETINT (strcat "\nINPUT HOR COUNT (DX:" (rtos DX) ") : ")))
  (setq NY (GETINT (strcat "\nINPUT VER COUNT (DY:" (rtos DY) ") : ")))

   (IF (= nil NX)
      (PROGN
        (SETQ NX (fix (/ (abs (- (car P1) (car P2))) 4000)))
      )
   )
   (IF (= nil NY)
      (PROGN
        (SETQ NY (fix (/ (abs (- (cadr P1) (cadr P2))) 4000)))
      )
   )

   (setq DX (/(abs (- (car P1) (car P2))) NX))
   (setq DY (/(abs (- (cadr P1) (cadr P2))) NY))

   (setq P3  (list (PROGN  (IF (< (CAR P1) (CAR P2)) (CAR P1) (CAR P2))  )     (PROGN  (IF (< (CADR P1) (CADR P2)) (CADR P1) (CADR P2)) )    ))

   (setq P3 (LIST (+ (CAR P3) (/ DX 2) ) (+ (CADR P3) (/ DY 2) )  ))

   (setq I1 0)
   (setq I2 0)

   (SETQ OSN (GETVAR "OSMODE"))
   (SETVAR "OSMODE" 0)
   (while (/= I1 NX)
      (while (/= I2 NY)
         (setq P4 (LIST (+ (CAR P3) (* DX I1)) (+ (CADR P3) (* DY I2))))
         (command "copy" OBJ "" PR P4)
         (setq I2 (+ I2 1))
      )
      (setq I2 0)
      (setq I1 (+ I1 1))
   )
   (SETVAR "OSMODE" OSN)
   (command "undo" "e")


)

(defun c:jd2 (/ P1 P2 P3 P4 P5 PR NX NY OBJ DX DY I1 I2 OSN)
   (command "undo" "be")
   (setq OBJ (ssget ":E" ))
   (setq PR (GETPOINT "INPUT Ref Point : " ))
   (setq P1 (GETPOINT "INPUT POINT1 : " ))
   (setq P2 (GETCORNER P1 "INPUT POINT2 : " ))
   (setq DX (abs (- (car P1) (car P2))))
   (setq DY (abs (- (cadr P1) (cadr P2))))
   (princ "\nINPUT HOR COUNT (DX:")(princ DX)(setq NX (GETINT ") : "))
   (princ "\nINPUT VER COUNT (DY:")(princ DY)(setq NY (GETINT ") : "))

   (IF (= nil NX)
      (PROGN
        (SETQ NX (fix (/ (abs (- (car P1) (car P2))) 4000)))
      )
   )
   (IF (= nil NY)
      (PROGN
        (SETQ NY (fix (/ (abs (- (cadr P1) (cadr P2))) 4000)))
      )
   )


   (setq DX (/(abs (- (car P1) (car P2))) NX))
   (setq DY (/(abs (- (cadr P1) (cadr P2))) NY))

   (if (< (rem DX 300) 200) (progn (setq DX (- DX (rem DX 300))))  (progn (setq DX (+ (- DX (rem DX 300)) 300))))
   (if (< (rem DY 300) 200) (progn (setq DY (- DY (rem DY 300))))  (progn (setq DY (+ (- DY (rem DY 300)) 300))))

   (princ "\n") (princ dx) (princ ",") (princ dy)



   (setq P3  (list (PROGN  (IF (< (CAR P1) (CAR P2)) (CAR P1) (CAR P2))  )     (PROGN  (IF (< (CADR P1) (CADR P2)) (CADR P1) (CADR P2)) )    )) ;;좌하단
   (setq P4  (list (PROGN  (IF (< (CAR P1) (CAR P2)) (CAR P2) (CAR P1))  )     (PROGN  (IF (< (CADR P1) (CADR P2)) (CADR P2) (CADR P1)) )    )) ;;우상단

   (princ "\n") (princ (car p3)) (princ ",") (princ (cadr p3))
   (princ "\n") (princ (car p4)) (princ ",") (princ (cadr p4))

   (setq P5 (list (/ (+ (car P3) (car P4)) 2) (/ (+ (cadr P3) (cadr P4)) 2)  )) ;;중심

   (setq P3 (LIST (- (CAR P5) (/ (* DX (- NX 1))  2) ) (- (CADR P5) (/ (* DY (- NY 1)) 2) )  ))

   (princ "\n start") (princ (car p3)) (princ ",") (princ (cadr p3))
   (princ "\n mid") (princ (car p5)) (princ ",") (princ (cadr p5))

   (setq I1 0)
   (setq I2 0)

   (SETQ OSN (GETVAR "OSMODE"))
   (SETVAR "OSMODE" 0)
   (while (/= I1 NX)
      (while (/= I2 NY)
         (setq P4 (LIST (+ (CAR P3) (* DX I1)) (+ (CADR P3) (* DY I2))))
         (command "copy" OBJ "" PR P4)
         (setq I2 (+ I2 1))
      )
      (setq I2 0)
      (setq I1 (+ I1 1))
   )
   (SETVAR "OSMODE" OSN)
   (command "undo" "e")


)
