
(vl-load-com)
  
(defun c:accore (/ dir scr bat dirbat cpt)
    (setq dirbat "c:\\Data\\TMP\\temp.bat") 
    (if (and
          (setq dir (acet-ui-pickdir "Choose the folder containing the DWGs" "c:\\"))
          (setq cpt (length (vl-directory-files dir "*.dwg" 1)))
          (setq scr (getfiled "Choose a Script" "c:\\Data\\scr\\" "scr" 4))
        )
		(progn
			(setq bat (open dirbat "w"))
			(write-line (strcat "@echo off\nchcp 1252\ncd \""
							dir 
							"\"\nfor /f \"delims=\" %%f IN ('dir /b \"*.dwg\"') do accoreconsole.exe /i \"%%f\" /s \"" 
							scr 
							"\"\n")
							bat)
			(close bat)
			(if (run dirbat)
				(princ (strcat "\nSuccessful processing for "(itoa cpt)" files."))
				(princ "\nProcessing Failure. Check your script.")
			)
		)
        (princ "\n->Abort, or Unknown Error.<-")
    )
    (princ)
)




