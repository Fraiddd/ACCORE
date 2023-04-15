(defun c:accore (/ dir scr fb ret) 
	(if (and(setq dir (getdir))
			(setq scr (getfiled "Choose a file" "c:\\Data\\git\\lsp\\ACCORE\\scr\\" "scr" 4)))
		(progn 
			(setq fb (open "c:\\Data\\temp.bat" "w")) 
			(write-line (strcat "@echo off\ncd \""
								dir 
								"\"\nfor /f \"delims=\" %%f IN ('dir /b \"*.dwg\"') do accoreconsole.exe /i \"%%f\" /s \"" 
								scr 
								"\"\n")
								fb)
			(close fb)
			(setq ret (run "c:\\Data\\temp.bat"))
		)
		(princ "\nHave you lost your way?")
	)
	(if ret
		
	)

)