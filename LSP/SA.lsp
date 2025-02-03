;;PROGRAMED BY RIMIN YU
;;LAST UPDATED 01-23-2025

;;SA : 정확한 간격 맞춰서 조명 배치
;;SA1 : x에 맞춰서 조명 배치
;;SA2 : 300에 맞춰서 조명 배치


(defun c:SA () (symarrayplacement1))
(defun c:SA1 () (symarrayplacement2 nil))
(defun c:SA2 () (symarrayplacement2 300))
(defun c:SA3 () (symarrayplacement3))

;|
(progn
  (defun *error* (msg) 
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
  
  
  (setq OSN (getvar "OSMODE"))
  (setq CMDE (getvar "CMDECHO"))
  (command "UNDO" "BE")
  (setvar "OSMODE" 0)
  (setvar "CMDECHO" 0)
  
  
  (setvar "OSMODE" OSN)
  (setvar "CMDECHO" CMDE)
  (command "UNDO" "E")
  
  
  
  
  
  
  
  (defun *error* (msg) 
    (setvar "FILLETRAD" RADIUS)
    (setvar "OSMODE" OSN)
    (setvar "CMDECHO" CMDE)
    (command "UNDO" "E")
  )
  (setq OSN (getvar "OSMODE"))
  (setq CMDE (getvar "CMDECHO"))
  
  
  (setq OSN (getvar "OSMODE"))
  (setq CMDE (getvar "CMDECHO"))
  (command "UNDO" "BE")
  (setvar "OSMODE" 0)
  (setvar "CMDECHO" 0)
  
  
  (setvar "OSMODE" OSN)
  (setvar "CMDECHO" CMDE)
  (command "UNDO" "E")
  
  
  
  
  
  
  
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
    (if (= nil CLT)
      (progn)
      (setvar "CELTYPE" CLT)
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
  
  (setq CEC (getvar "CECOLOR"))
  (setq CLA (getvar "CLAYER"))
  (setq CST (getvar "TEXTSTYLE"))
  (setq CLT (getvar "CELTYPE"))
  (setq OSN (getvar "OSMODE"))
  (setq CMDE (getvar "CMDECHO"))
  (command "UNDO" "BE")
  (setvar "OSMODE" 0)
  (setvar "CMDECHO" 0)
  
  
  (setvar "CECOLOR" CEC)
  (setvar "CLAYER" CLA)
  (setvar "TEXTSTYLE" CST)
  (setvar "CELTYPE" CLT)
  (setvar "OSMODE" OSN)
  (setvar "CMDECHO" CMDE)
  (command "UNDO" "E")
  
  
)

|;

(defun symarrayplacement1 (/ OSN CMDE P1 P2 P3 P4 PR NX NY OBJ DX DY I1 I2 WHI) 

  (defun *error* (msg) 
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
  
  
  
  
  (setq OBJ (ssget ":E"))
  (setq PR (GETPOINT "INPUT Ref Point : "))
  (setq P1 (GETPOINT "INPUT POINT1 : "))
  (if (= (getvar "program") "ZWCAD")
    (setq P2 (GETPOINT P1 "INPUT POINT2 : "))
    (setq P2 (GETCORNER P1 "INPUT POINT2 : "))
  )
  
  (setq DX (abs (- (car P1) (car P2))))
  (setq DY (abs (- (cadr P1) (cadr P2))))


  (setq WHI 0)
  (WHILE (= WHI 0) 
    (setq WHI 1)

    (setq NX (GETINT (strcat "\nINPUT HOR COUNT (DX:" (rtos DX) ",DY:" (rtos DY) ") : ")))
    (setq NY (GETINT (strcat "\nINPUT VER COUNT (DX:" (rtos DX) ",DY:" (rtos DY) ") : ")))



    (IF (= nil NX) 
      (PROGN 
        (SETQ NX (fix (/ DX 4000)))
      )
    )
    (IF (= nil NY) 
      (PROGN 
        (SETQ NY (fix (/ DY 4000)))
      )
    )

    (IF (= 0 NX) 
      (PROGN 
        (SETQ NX 1)
      )
    )
    (IF (= 0 NY) 
      (PROGN 
        (SETQ NY 1)
      )
    )

    (IF (> (* NX NY) 400) 
      (PROGN 
        (princ "\n INPUT COUNT OVER 400! IT'S TOO MANY ")
        (setq WHI 0)
      )
    )
  )


  (setq DX (/ (abs (- (car P1) (car P2))) NX))
  (setq DY (/ (abs (- (cadr P1) (cadr P2))) NY))

  (setq P3 (list (PROGN (IF (< (CAR P1) (CAR P2)) (CAR P1) (CAR P2))) 
                 (PROGN (IF (< (CADR P1) (CADR P2)) (CADR P1) (CADR P2)))
           )
  )

  (setq P3 (LIST (+ (CAR P3) (/ DX 2)) (+ (CADR P3) (/ DY 2))))

  (setq I1 0)
  (setq I2 0)



  (setq OSN (getvar "OSMODE"))
  (setq CMDE (getvar "CMDECHO"))
  (command "UNDO" "BE")
  (setvar "OSMODE" 0)
  (setvar "CMDECHO" 0)
  
  
  (while (/= I1 NX) 
    (while (/= I2 NY) 
      (setq P4 (LIST (+ (CAR P3) (* DX I1)) (+ (CADR P3) (* DY I2))))
      (command "copy" OBJ "" PR P4)
      (setq I2 (+ I2 1))
    )
    (setq I2 0)
    (setq I1 (+ I1 1))
  )
  (princ (strcat "\n SYM ARRAY PLACEMENT (DX:" (rtos DX) ") (DY:" (rtos DY) ")" ))

  
  (setvar "OSMODE" OSN)
  (setvar "CMDECHO" CMDE)
  (command "UNDO" "E")
  
)

(defun symarrayplacement2 (DIS / OSN CMDE P1 P2 P3 P4 P5 PR NX NY OBJ DX DY I1 I2 WHI DIS) 

  (defun *error* (msg) 
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
  

  (setq OBJ (ssget ":E"))
  (setq PR (GETPOINT "INPUT Ref Point : "))
  (setq P1 (GETPOINT "INPUT POINT1 : "))
  (if (= (getvar "program") "ZWCAD")
    (setq P2 (GETPOINT P1 "INPUT POINT2 : "))
    (setq P2 (GETCORNER P1 "INPUT POINT2 : "))
  )
  (setq DX (abs (- (car P1) (car P2))))
  (setq DY (abs (- (cadr P1) (cadr P2))))
  (setq WHI 0)
  (WHILE (= WHI 0) 
    (setq WHI 1)


    (setq NX (GETINT (strcat "\nINPUT HOR COUNT (DX:" (rtos DX) ",DY:" (rtos DY) ") : ")))
    (setq NY (GETINT (strcat "\nINPUT VER COUNT (DX:" (rtos DX) ",DY:" (rtos DY) ") : ")))

    (IF (= nil NX) 
      (PROGN 
        (SETQ NX (fix (/ DX 4000)))
      )
    )
    (IF (= nil NY) 
      (PROGN 
        (SETQ NY (fix (/ DY 4000)))
      )
    )

    (IF (= 0 NX) 
      (PROGN 
        (SETQ NX 1)
      )
    )
    (IF (= 0 NY) 
      (PROGN 
        (SETQ NY 1)
      )
    )
    (IF (> (* NX NY) 400) 
      (PROGN 
        (princ "\n INPUT COUNT OVER 400! IT'S TOO MANY ")
        (setq WHI 0)
      )
    )
  )
  
  
  (if (= nil DIS)
    (progn
      (setq DIS (getint (strcat "\nINPUT UNIT LENGTH")))
      
      (if (= nil DIS)
        (setq DIS 100)
      )
    )
  )





  (setq DX (/ (abs (- (car P1) (car P2))) NX))
  (setq DY (/ (abs (- (cadr P1) (cadr P2))) NY))

  (if (< (rem DX 300) 200) 
    (progn (setq DX (- DX (rem DX 300))))
    (progn (setq DX (+ (- DX (rem DX 300)) 300)))
  )
  (if (< (rem DY 300) 200) 
    (progn (setq DY (- DY (rem DY 300))))
    (progn (setq DY (+ (- DY (rem DY 300)) 300)))
  )

  (setq P3 (list (PROGN (IF (< (CAR P1) (CAR P2)) (CAR P1) (CAR P2))) 
                 (PROGN (IF (< (CADR P1) (CADR P2)) (CADR P1) (CADR P2)))
           )
  ) ;;좌하단
  (setq P4 (list (PROGN (IF (< (CAR P1) (CAR P2)) (CAR P2) (CAR P1))) 
                 (PROGN (IF (< (CADR P1) (CADR P2)) (CADR P2) (CADR P1)))
           )
  ) ;;우상단



  (setq P5 (list (/ (+ (car P3) (car P4)) 2) (/ (+ (cadr P3) (cadr P4)) 2))) ;;중심

  (setq P3 (LIST (- (CAR P5) (/ (* DX (- NX 1)) 2)) 
                 (- (CADR P5) (/ (* DY (- NY 1)) 2))
           )
  )

  (setq I1 0)
  (setq I2 0)


  (setq OSN (getvar "OSMODE"))
  (setq CMDE (getvar "CMDECHO"))
  (command "UNDO" "BE")
  (setvar "OSMODE" 0)
  (setvar "CMDECHO" 0)
  
  
  (while (/= I1 NX) 
    (while (/= I2 NY) 
      (setq P4 (LIST (+ (CAR P3) (* DX I1)) (+ (CADR P3) (* DY I2))))
      (command "copy" OBJ "" PR P4)
      (setq I2 (+ I2 1))
    )
    (setq I2 0)
    (setq I1 (+ I1 1))
  )
  (princ (strcat "\n SYM ARRAY PLACEMENT (DX:" (rtos DX) ") (DY:" (rtos DY) ")" ))
  
  
  (setvar "OSMODE" OSN)
  (setvar "CMDECHO" CMDE)
  (command "UNDO" "E")
)

(defun symarrayplacement3 (/ OSN CMDE P1 P2 P3 P4 P5 PR NX NY DX2 DY2 OBJ DX DY I1 I2 WHI) 

  (defun *error* (msg) 
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
  

  (setq OBJ (ssget ":E"))
  (setq PR (GETPOINT "INPUT Ref Point : "))
  (setq P1 (GETPOINT "INPUT POINT1 : "))
  (if (= (getvar "program") "ZWCAD")
    (setq P2 (GETPOINT P1 "INPUT POINT2 : "))
    (setq P2 (GETCORNER P1 "INPUT POINT2 : "))
  )
  (setq DX (abs (- (car P1) (car P2))))
  (setq DY (abs (- (cadr P1) (cadr P2))))
  (setq WHI 0)
  (WHILE (= WHI 0) 
    (setq WHI 1)



    (setq DX2 (GETINT (strcat "\n INPUT HOR DISTANCE (DX:" (rtos DX) ",DY:" (rtos DY) ") : ")))
    (setq DY2 (GETINT (strcat "\n INPUT VER DISTANCE (DX:" (rtos DX) ",DY:" (rtos DY) ") : ")))

    (IF (= nil DX2) 
      (PROGN 
        (SETQ DX2 3000)
      )
    )
    (IF (= nil DY2) 
      (PROGN 
        (SETQ DY2 3000)
      )
    )



    (setq NX (+ (fix (/ DX DX2)) 1))
    (setq NY (+ (fix (/ DY DY2)) 1))


    (IF (= 0 NX) 
      (PROGN 
        (SETQ NX 1)
      )
    )
    (IF (= 0 NY) 
      (PROGN 
        (SETQ NY 1)
      )
    )
    (IF (> (* NX NY) 3000) 
      (PROGN 
        (princ "\n INPUT COUNT OVER 3000! IT'S TOO MANY ")
        (setq WHI 0)
      )
    )
  )



  (setq DX DX2)
  (setq DY DY2)


  (setq P3 (list (PROGN (IF (< (CAR P1) (CAR P2)) (CAR P1) (CAR P2))) 
                 (PROGN (IF (< (CADR P1) (CADR P2)) (CADR P1) (CADR P2)))
           )
  ) ;;좌하단
  (setq P4 (list (PROGN (IF (< (CAR P1) (CAR P2)) (CAR P2) (CAR P1))) 
                 (PROGN (IF (< (CADR P1) (CADR P2)) (CADR P2) (CADR P1)))
           )
  ) ;;우상단



  (setq P5 (list (/ (+ (car P3) (car P4)) 2) (/ (+ (cadr P3) (cadr P4)) 2))) ;;중심

  (setq P3 (LIST (- (CAR P5) (/ (* DX (- NX 1)) 2)) 
                 (- (CADR P5) (/ (* DY (- NY 1)) 2))
           )
  )

  (setq I1 0)
  (setq I2 0)


  (setq OSN (getvar "OSMODE"))
  (setq CMDE (getvar "CMDECHO"))
  (command "UNDO" "BE")
  (setvar "OSMODE" 0)
  (setvar "CMDECHO" 0)
  
  
  (while (/= I1 NX) 
    (while (/= I2 NY) 
      (setq P4 (LIST (+ (CAR P3) (* DX I1)) (+ (CADR P3) (* DY I2))))
      (command "copy" OBJ "" PR P4)
      (setq I2 (+ I2 1))
    )
    (setq I2 0)
    (setq I1 (+ I1 1))
  )
  (princ (strcat "\n SYM ARRAY PLACEMENT (NX:" (rtos NX) ") (NY:" (rtos NY) ")" ))
  
  
  (setvar "OSMODE" OSN)
  (setvar "CMDECHO" CMDE)
  (command "UNDO" "E")
)
