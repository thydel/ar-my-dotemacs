;; >From: MAP@LCS.MIT.EDU
;; Newsgroups: comp.emacs
;; Subject: nice addition to dired
;; Message-ID: <8901072124.AA18009@gaak.LCS.MIT.EDU>
;; Date: 7 Jan 89 21:24:25 GMT
;; Sender: daemon@eddie.MIT.EDU
;; Lines: 17
;; 
;; I thought your added dired command was a nice idea.  Here's a slightly
;; improved version that doesn't lose pending deletions if there are any.
;; 
;; dired-exit hook stuff... 1/6/89 erik@mpx2.UUCP
;; 7-Jan-89  MAP@LCS.MIT.Edu do pending deletions before punting
(setq dired-mode-hook 'set-my-dired-keys-hook)

(defun set-my-dired-keys-hook ()
  "My favorite dired vars."
  (local-set-key "q" 'dired-delete-and-exit)
  (local-set-key "|" 'dired-pipe)
  (local-set-key "T" 'dired-touch))

(defun dired-pipe ()
  (interactive)
  (shell-command
   (read-from-minibuffer "Apply command : "
			 (format "cat %s | " (dired-get-filename t nil))
			 minibuffer-local-map
			 nil)))

;;; command to quit a dired session...

(defun dired-delete-and-exit ()
  "Quit editing this directory."
  (interactive)
  (dired-do-flagged-delete)
  (kill-buffer (current-buffer)))

(defun dired-touch ()
  "In dired, touches the file mentioned on this line."
  (interactive)
  (let ((buffer-read-only nil) (file (dired-get-filename)))
    (call-process "touch" nil nil nil file)
    (dired-do-redisplay file)))
