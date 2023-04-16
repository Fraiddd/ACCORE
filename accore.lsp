
(vl-load-com)
  
(defun c:accore (/ WriteStream dir scr bat dirbat cpt)
    (defun WriteStream (txt fil char / ado)
        (setq ado (vlax-create-object "ADODB.Stream"))
        (vlax-put ado 'Charset char)
        (vlax-invoke ado 'Open)
        (vlax-invoke ado 'WriteText txt 0)
        (vlax-invoke ado 'SaveToFile fil 2)
        (vlax-invoke ado 'Close)
        (vlax-release-object ado)
        fil
    )
    (setq dirbat "c:\\Data\\TMP\\temp.bat") 
    (if (and
          (setq dir (acet-ui-pickdir "Choose the folder containing the DWGs" "c:\\"))
          (setq cpt (length (vl-directory-files dir "*.dwg" 1)))
          (setq scr (getfiled "Choose a Script" "c:\\Data\\git\\lsp\\ACCORE\\scr\\" "scr" 4))
          (not (vl-catch-all-error-p (vl-catch-all-apply 
            'WriteStream (list
                (strcat "@echo off\ncd \""
                        dir 
                        "\"\nfor /f \"delims=\" %%f IN ('dir /b \"*.dwg\"') do accoreconsole.exe /i \"%%f\" /s \"" 
                        scr 
                        "\"\n")
                        dirbat
                        "utf-8")
                        )))
          (utf8noBOM dirbat)
        )
        (if (run dirbat)
            (princ (strcat "\nSuccessful processing for "(itoa cpt)" files."))
            (princ "\nProcessing Failure. Check your script.")
        )
        (princ "\n->Abort, or Unknown Error.<-")
    )
    (princ)
)


;;;utf8noBOM
;;;Supprime le BOM d'un fichier encodé en UTF8 avec BOM
;;;Arg: String Nom du fichier ou chemin complet
;;;Retour: T ou nil
;;;Doc https://stackoverflow.com/questions/31435662/vba-save-a-file-with-utf-8-without-bom 
;;;    https://www.w3schools.com/asp/ado_ref_stream.asp 
(defun utf8noBOM (file / rid wri)
    (and (setq file (findfile file))
         (not (vl-catch-all-error-p (vl-catch-all-apply 
              (function 
                (lambda () 
                    (setq rid (vlax-create-object "ADODB.Stream")
                          wri (vlax-create-object "ADODB.Stream")
                    )
                    (vlax-put rid 'Charset  "utf-8")
                    (vlax-invoke rid 'Open)
                    (vlax-invoke rid 'LoadFromFile file)
                    (vlax-put rid 'Position  3)
                    (vlax-put wri 'Type  1)
                    (vlax-invoke wri 'Open)
                    (vlax-invoke rid 'CopyTo wri)
                    (vlax-invoke rid 'Close)
                    (vlax-invoke wri 'SaveToFile file 2)
                    (vlax-invoke wri 'Close)
                    (vlax-release-object rid)
                    (vlax-release-object wri)
                )
              )
              ))
         )
    )
)

