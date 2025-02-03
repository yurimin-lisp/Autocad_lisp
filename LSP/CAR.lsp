;;PROGRAMED BY RIMIN YU
;;LAST UPDATED 10-22-2024


(defun c:car ()
  (obj_prop_to_sysval)
)


(defun obj_prop_to_sysval (/ a b c d f g h) 
  (setq a (ssget "+.:E:S"))
  (if (= a nil) 
    (progn 
      (command "cecolor" "bylayer")
      (command "celtype" "bylayer")
      (command "celtscale" 1)
      (command "-LWEIGHT" "bylayer")
      (command "plinewid" 0)
    )
    (progn 
      (setq b (cdr (assoc 8 (entget (ssname a 0))))) ;;레이어
      (setq c (cdr (assoc 62 (entget (ssname a 0))))) ;;색상
      (setq d (cdr (assoc 6 (entget (ssname a 0))))) ;;선종류
      (setq e (cdr (assoc 48 (entget (ssname a 0))))) ;;선종류축적
      (setq f (cdr (assoc 370 (entget (ssname a 0))))) ;;선굵기
      (setq g (cdr (assoc 40 (entget (ssname a 0))))) ;;시작폴리선굵기
      (setq h (cdr (assoc 41 (entget (ssname a 0))))) ;;끝폴리선굵기
      (command "clayer" b)
      (if (= c nil) 
        (command "cecolor" "bylayer")
        (command "cecolor" c)
      )
      (if (= d nil) 
        (command "celtype" "bylayer")
        (command "celtype" d)
      )
      
      (if (= e nil) 
        (command "celtscale" 1)
        (command "celtscale" e)
      )
      
      
      (if (= f nil) 
        (command "-LWEIGHT" "bylayer")
        (if (= f -3) 
          (progn
            (command "-LWEIGHT" "default")
            (command "plinewid" 0)
          )
          (if (= f -2) 
            (progn
              (command "-LWEIGHT" "byblock")
              (command "plinewid" 0)
            )
            (progn
              (command "-LWEIGHT" (/ f 100.0))
              (command "plinewid" 0)
            )
          )
        )
      )
      (if (or (= g nil) (= h nil))
        (command "plinewid" 0)
        (if (= g h) 
          (progn
            (command "-LWEIGHT" "bylayer")
            (command "plinewid" g)
          )
          (progn
            (command "-LWEIGHT" "bylayer")
            (command "plinewid" 0)
          )
        )
      )
    )
  )
)
