
(defun myshell (&optional buffer)
  "Call `shell', auto naming buffer from either current directory
of (dired or file name) or provided name. If prefixed use default
`*shell*', if prefixes twice generate new unique buffer name"
  (interactive
   (cond
    ((equal current-prefix-arg '(16))
     (list
      (read-buffer
       "Shell Buffer: "
       (generate-new-buffer-name (mk-shell-buffer-name)))))
    ((equal current-prefix-arg '(4)) (list "*shell*"))))
  (shell (or buffer (mk-shell-buffer-name))))

(defun mk-shell-buffer-name ()
  (cond
   ((eq major-mode 'shell-mode)
    (replace-regexp-in-string "<.*>" "" (buffer-name)))
   ((eq major-mode 'term-mode)
    (concat "$" (file-name-nondirectory (directory-file-name (cadr (split-string (pwd)))))))
   ((or dired-directory buffer-file-name)
    (concat
     "$"
     (file-name-nondirectory
      (directory-file-name
       (or dired-directory (file-name-directory buffer-file-name))))))
   ("*shell*")))
