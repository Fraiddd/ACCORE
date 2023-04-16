; ANSI-Windows 1252
; Autolisp, Visual Lisp
;|
    accore.lsp 1.0

    Uses accoreconsole.exe to apply a script to a folder of DWGs.

    Enter accore in Autocad, choose the folder containing the DWGs and the script.

    Drawings are not open.

    Tested on Windows 10 and Autocad 2015.

    No copyright: (!) 2023 by Frédéric Coulon.
    No license: Do with it what you want.

|;
;Dependencies
;(load "run.lsp")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun c:accore (/ dir scr bat dirbat cpt)
    (setq dirbat "c:\\Data\\TMP\\temp.bat") 
    (if (and        
          (setq dir (acet-ui-pickdir "Choose the folder containing the DWGs" "c:\\")); Displays a directory selection dialog.
          (setq cpt (length (vl-directory-files dir "*.dwg" 1))); 
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




