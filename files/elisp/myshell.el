
(defun myshell (&optional buffer)
  "Call `shell', auto naming buffer from either current directory
of (dired or file name) or provided name. If prefixed generate
new unique buffer name, If prefixes twice use default `*shell*'"
  (interactive
   (cond
    ((equal current-prefix-arg '(4))
     (list
      (read-buffer
       "Shell Buffer: "
       (generate-new-buffer-name (mk-shell-buffer-name)))))
    ((equal current-prefix-arg '(16)) (list "*shell*"))))
  (shell (or buffer (mk-shell-buffer-name))))

(defun mk-shell-buffer-name ()
  (cond
   ((eq major-mode 'shell-mode)
    (replace-regexp-in-string "<.*>" "" (buffer-name)))
   ((or dired-directory buffer-file-name)
    (concat
     "$"
     (file-name-nondirectory
      (directory-file-name
       (or dired-directory (file-name-directory buffer-file-name))))))
   ("*shell*")))
