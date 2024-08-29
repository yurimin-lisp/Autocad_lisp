;;PROGRAMED BY RIMIN YU (CODENAME U)
;;LAST UPDATED 24-04-2024

;|
전역변수
SYMSC

WIRECOUNT_Z
WIRECOUNT_MZ : 수동축적

SE1 : 접지선 그릴지 여부
SE2 : 변경된 방식으로 그릴지 여부

Dx : 대각선의 가로변위
DY : 대각선의 세로변위
DS : 대각선간의 거리


|;

(DEFUN C:WC (/ MODE X BOOL OSN I CI PO C1 P0 P1 P2 RP1 RP2 RP3 RP4)

  (IF (NULL WIRECOUNT_Z)
    (PROGN
      (IF (NULL SYMSC)
        (PROGN
           (SETQ WIRECOUNT_Z 150)
           (SETQ WIRECOUNT_MZ 0)
        )
        (PROGN
          (SETQ WIRECOUNT_Z SYMSC)
          (SETQ WIRECOUNT_MZ 0)
        )
      )
    )

    (PROGN
      (IF (AND (/= WIRECOUNT_Z SYNSC) (= WIRECOUNT_MZ 0))
        (PROGN
           (SETQ WIRECOUNT_Z SYMSC)
        )
      )
    )

  )
  ;;최초 명령 실행시 기본값 지정

  (IF (NULL SE1)
    (PROGN
      (SETQ SE1 "Y")
    )
  )

  (IF (NULL SE2)
    (PROGN
      (SETQ SE2 "N")
    )
  )

  (IF (NULL WIRECOUNT_DX)
    (PROGN
      (SETQ WIRECOUNT_DX 150)
    )
  )

  (IF (NULL WIRECOUNT_DY)
    (PROGN
      (SETQ WIRECOUNT_DY 150)
    )
  )

  (IF (NULL WIRECOUNT_DS)
    (PROGN
      (SETQ WIRECOUNT_DS 100)
    )
  )

  (SETQ BOOL 0)

  (WHILE (= BOOL 0)
    (INITGET 1 "V H G Z R S")
    (SETQ MODE (GETKWORD (STRCAT "\nWIRE COUNTER(SCALE:" (itoa (fiX WIRECOUNT_Z)) ",LH STYLE:" SE2 ",GND:" SE1 ") [VER(V)/HOR(H)/GND SET(G)/LH KEC SET(S)/SCALE (Z)/REF(R)] ")))


    (COND
      ((= MODE "G")
        (PROGN
          (INITGET 1 "Y N")
          (SETQ SE1 (GETKWORD (STRCAT "\nDRAW GND?(" SE1 ") : [YES(Y)/NO(N)]")))
        )
      )

      ((= MODE "Z")
        (PROGN
          (SETQ WIRECOUNT_Z (GETINT (STRCAT "\nINPUT SYM SCALE (" (ITOA (fiX WIRECOUNT_Z)) ") : ")))

          (IF (NULL WIRECOUNT_Z)
            (PROGN
              (SETQ WIRECOUNT_Z SYMSC)
              (SETQ WIRECOUNT_MZ 0)
            )
            (SETQ WIRECOUNT_MZ 1)
          )
        )
      )

      ((= MODE "S")
        (PROGN
          (INITGET 1 "Y N")
          (SETQ SE2 (GETKWORD (STRCAT "\nLH KEC LINE STYLE?(" SE2 ") : [YES(Y)/NO(N)]")))
        )
      )

      ((= MODE "R")
        (PROGN
          (SETQ RP1(getpoint "\n Enter Line distan : "))
          (SETQ RP2(getpoint RP1 ""))
          (SETQ RP3(getpoint "\n Enter SPACE distan : "))
          (SETQ RP4(getpoint RP3 ""))
          (setq WIRECOUNT_DX (abs (- (car RP1) (car RP2))))
          (SETQ WIRECOUNT_DX (/ WIRECOUNT_DX 2))
          (setq WIRECOUNT_DY (abs (- (cadr RP1) (cadr RP2))))
          (SETQ WIRECOUNT_DY (/ WIRECOUNT_DY 2))
          (setq WIRECOUNT_DS (distance RP3 RP4))

          (SETQ X (/ WIRECOUNT_Z 150.0))

          (SETQ WIRECOUNT_DX (/ WIRECOUNT_DX X))
          (SETQ WIRECOUNT_DY (/ WIRECOUNT_DY X))
          (SETQ WIRECOUNT_DS (/ WIRECOUNT_DS X))
          
        )
      )

      

      (T (SETQ BOOL 1))
    )


  )

  (SETQ CI (GETINT "\nINPUT LINE COUNT : "))


  (SETQ PO (GETPOINT "\nPOCK POINT OF MIDDLE : "))


  (SETQ X (/ WIRECOUNT_Z 150.0))

  (command "undo" "be")
  (SETQ OSN (GETVAR "OSMODE"))
  (SETVAR "OSMODE" 0)


  (IF (= MODE "V")
    (IF (= SE2 "Y")
      (PROGN

        (IF (= SE1 "Y")
          (SETQ P0 (LIST (CAR PO) (+ (CADR PO) (/ (+ (+ (* CI (* X WIRECOUNT_DS)) (* X WIRECOUNT_DS)) (* (/ (- CI 1) 3) (* X WIRECOUNT_DS))) 2) ) ))
        )
        (IF (= SE1 "N")
          (SETQ P0 (LIST (CAR PO) (- (+ (CADR PO) (/ (+ (+ (* CI (* X WIRECOUNT_DS)) (* X WIRECOUNT_DS)) (* (/ (- CI 1) 3) (* X WIRECOUNT_DS))) 2) ) (* X WIRECOUNT_DS) )))
        )


        (SETQ C1 0)



        (WHILE (/= CI C1)

          (SETQ P1 (LIST (+ (CAR P0) (* X WIRECOUNT_DX)) (+ (CADR P0) (* X WIRECOUNT_DY))))
          (SETQ P2 (LIST (- (CAR P0) (* X WIRECOUNT_DX)) (- (CADR P0) (* X WIRECOUNT_DY))))

          (COMMAND "PLINE" P1 P2 "")

          (SETQ P0 (LIST (CAR P0) (- (CADR P0) (* X WIRECOUNT_DS))))

  
          (SETQ C1 (+ C1 1))

          (IF (AND (= 0 (REM C1 3)) (/= CI C1))
            (SETQ P0 (LIST (CAR P0) (- (CADR P0) (* X WIRECOUNT_DS))))
          )
        )
        (IF (= SE1 "Y")
          (progn
            (SETQ P0 (LIST (CAR P0) (- (CADR P0) (* X WIRECOUNT_DS))))
            (SETQ P1 (LIST (+ (CAR P0) (* X WIRECOUNT_DX)) (+ (CADR P0) (* X WIRECOUNT_DY))))
            (SETQ P2 (LIST (- (CAR P0) (* X WIRECOUNT_DX)) (- (CADR P0) (* X WIRECOUNT_DY))))
            (COMMAND "PLINE" P1 P2 "")
            (SETQ P0 P1)
            (SETQ P1 (LIST (CAR P0) (+ (CADR P0) (* X (/ WIRECOUNT_DS 2)))))
            (SETQ P2 (LIST (CAR P0) (- (CADR P0) (* X (/ WIRECOUNT_DS 2)))))
            (COMMAND "PLINE" P1 P2 "")
          )
        )
      )
      (PROGN
        (IF (= SE1 "Y")
        (SETQ P0 (LIST (CAR PO) (+ (CADR PO) (/ (+ (+ (* CI (* X WIRECOUNT_DS)) (* X WIRECOUNT_DS)) (* (/ (- CI 1) 3) (* X WIRECOUNT_DS))) 2) ) ))
        )
        (IF (= SE1 "N")
        (SETQ P0 (LIST (CAR PO) (- (+ (CADR PO) (/ (+ (+ (* CI (* X WIRECOUNT_DS)) (* X WIRECOUNT_DS)) (* (/ (- CI 1) 3) (* X WIRECOUNT_DS))) 2) ) (* X WIRECOUNT_DS) )))
        )
        (SETQ C1 0)

        (WHILE (/= CI C1)
          (SETQ P1 (LIST (+ (CAR P0) (* X WIRECOUNT_DX)) (+ (CADR P0) (* X WIRECOUNT_DY))))
          (SETQ P2 (LIST (- (CAR P0) (* X WIRECOUNT_DX)) (- (CADR P0) (* X WIRECOUNT_DY))))
          (COMMAND "PLINE" P1 P2 "")
          (SETQ P0 (LIST (CAR P0) (- (CADR P0) (* X WIRECOUNT_DS))))
          (SETQ C1 (+ C1 1))
          (IF (AND (= 0 (REM C1 3)) (/= CI C1))
            (SETQ P0 (LIST (CAR P0) (- (CADR P0) (* X WIRECOUNT_DS))))
          )
        )
        (SETQ P0 (LIST (CAR P0) (- (CADR P0) (* X WIRECOUNT_DS))))
        (SETQ P1 (LIST (+ (CAR P0) (* X WIRECOUNT_DX)) (CADR P0)))
        (SETQ P2 (LIST (- (CAR P0) (* X WIRECOUNT_DX)) (CADR P0)))
        (IF (= SE1 "Y")
          (COMMAND "PLINE" P1 P2 "")
        )
      )
    )
    
  )


  (IF (= MODE "H")
    (IF (= SE2 "Y")
      (PROGN
        (IF (= SE1 "Y")
          (SETQ P0 (LIST (- (CAR PO) (/ (+ (+ (* CI (* X WIRECOUNT_DS)) (* X WIRECOUNT_DS)) (* (/ (- CI 1) 3) (* X WIRECOUNT_DS))) 2) ) (CADR PO))  )
        )
        (IF (= SE1 "N")
          (SETQ P0 (LIST (+ (- (CAR PO) (/ (+ (+ (* CI (* X WIRECOUNT_DS)) (* X WIRECOUNT_DS)) (* (/ (- CI 1) 3) (* X WIRECOUNT_DS))) 2) ) (* X WIRECOUNT_DS)) (CADR PO))  )
        )

        (SETQ C1 0)
        (WHILE (/= CI C1)

          (SETQ P1 (LIST (+ (CAR P0) (* X WIRECOUNT_DX)) (+ (CADR P0) (* X WIRECOUNT_DY))))
          (SETQ P2 (LIST (- (CAR P0) (* X WIRECOUNT_DX)) (- (CADR P0) (* X WIRECOUNT_DY))))

          (COMMAND "PLINE" P1 P2 "")

          (SETQ P0 (LIST (+ (CAR P0) (* X WIRECOUNT_DS)) (CADR P0)))


          (SETQ C1 (+ C1 1))

          (IF (AND (= 0 (REM C1 3)) (/= CI C1))
            (SETQ P0 (LIST (+ (CAR P0) (* X WIRECOUNT_DS)) (CADR P0)))
          )
        )
        (IF (= SE1 "Y")
          (progn
            (SETQ P0 (LIST (+ (CAR P0) (* X WIRECOUNT_DS)) (CADR P0)))
            (SETQ P1 (LIST (+ (CAR P0) (* X WIRECOUNT_DX)) (+ (CADR P0) (* X WIRECOUNT_DY))))
            (SETQ P2 (LIST (- (CAR P0) (* X WIRECOUNT_DX)) (- (CADR P0) (* X WIRECOUNT_DY))))
            (COMMAND "PLINE" P1 P2 "")
            (SETQ P0 P1)
            (SETQ P1 (LIST (+ (CAR P0) (* X (/ WIRECOUNT_DS 2))) (CADR P0)))
            (SETQ P2 (LIST (- (CAR P0) (* X (/ WIRECOUNT_DS 2))) (CADR P0)))
            (COMMAND "PLINE" P1 P2 "")

          )
        )

      )
      (PROGN
        (IF (= SE1 "Y")
          (SETQ P0 (LIST (- (CAR PO) (/ (+ (+ (* CI (* X WIRECOUNT_DS)) (* X WIRECOUNT_DS)) (* (/ (- CI 1) 3) (* X WIRECOUNT_DS))) 2) ) (CADR PO))  )
        )
        (IF (= SE1 "N")
          (SETQ P0 (LIST (+ (- (CAR PO) (/ (+ (+ (* CI (* X WIRECOUNT_DS)) (* X WIRECOUNT_DS)) (* (/ (- CI 1) 3) (* X WIRECOUNT_DS))) 2) ) (* X WIRECOUNT_DS)) (CADR PO))  )
        )

        (SETQ C1 0)
        (WHILE (/= CI C1)
  
          (SETQ P1 (LIST (+ (CAR P0) (* X WIRECOUNT_DX)) (+ (CADR P0) (* X WIRECOUNT_DY))))
          (SETQ P2 (LIST (- (CAR P0) (* X WIRECOUNT_DX)) (- (CADR P0) (* X WIRECOUNT_DY))))

          (COMMAND "PLINE" P1 P2 "")

          (SETQ P0 (LIST (+ (CAR P0) (* X WIRECOUNT_DS)) (CADR P0)))


          (SETQ C1 (+ C1 1))

          (IF (AND (= 0 (REM C1 3)) (/= CI C1))
            (SETQ P0 (LIST (+ (CAR P0) (* X WIRECOUNT_DS)) (CADR P0)))
          )
        )


        (SETQ P0 (LIST (+ (CAR P0) (* X WIRECOUNT_DS)) (CADR P0)))
        (SETQ P1 (LIST (CAR P0) (+ (CADR P0) (* X WIRECOUNT_DY))))
        (SETQ P2 (LIST (CAR P0) (- (CADR P0) (* X WIRECOUNT_DY))))
        (IF (= SE1 "Y")
          (COMMAND "PLINE" P1 P2 "")
        )

      )
    
    
    )
    
  )

  (SETVAR "OSMODE" OSN)
  (command "undo" "e")

)


