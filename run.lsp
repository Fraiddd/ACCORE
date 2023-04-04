; ANSI-Windows 1252
; Autolisp, Visual Lisp
;|
    run.lsp 1.0

    Using Windows command lines with Autolisp.

    (run file)
    
    Argument: file, String, name or full path .bat.
    
    Return: T or String, error message
    

    Tested on Windows 10 and Autocad 2015.
    
    first post : https://cadxp.com/topic/49596-lancer-un-bat-sans-la-fen%C3%AAtre-noire/
    No copyright: (!) 2021 by Frédéric Coulon.
    No license: Do with it what you want.
https://www.theswamp.org/index.php?topic=36170.0
https://learn.microsoft.com/en-us/windows/win32/shell/scriptable-shell-objects-roadmap
https://www.vbsedit.com/html/6f28899c-d653-4555-8a59-49640b0e32ea.asp
|;
;Dependencies
(vl-load-com)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun run (file / objWS ret)
    (setq ret T)
    ; Check the existence of the file. 
    (if (findfile file) 
        ; Check the raising of an exception.
        (if (vl-catch-all-error-p 
                (vl-catch-all-apply 'vlax-invoke-method 
                    (list
                        ; Creation of the object "WScript.Shell".
                        (setq objWS (vlax-get-or-create-object "WScript.Shell"))
                         "Run"           ; String, command line to execute.
                          file           ; String, file .bat
                          0              ; Int, 0 to 10, 0 -> Hides the window and activates another window.
                          :vlax-true     ; Boolean, Waits for the end before carrying out the continuation.
                    )
                )
            )   
            (setq ret "Invalid file")
            ; Release the object "WScript.Shell".
            (vlax-release-object objWS)
        )
      (setq ret "File not found")
    )
    ret
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


