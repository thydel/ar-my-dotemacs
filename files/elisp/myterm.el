(defun buffer-exists (name) (not (eq nil (get-buffer name))))

(defun mk-term-buffer-name ()
  (cond
   ((eq major-mode 'shell-mode)
    (concat "term " (file-name-nondirectory (directory-file-name (cadr (split-string (pwd)))))))
   ((or dired-directory buffer-file-name)
    (concat
     "term "
     (file-name-nondirectory
      (directory-file-name
       (or dired-directory (file-name-directory buffer-file-name))))))
   ("ansi-term")))

(defun myterm (&optional buffer)
  "Call `ansi-term', auto naming buffer from either current
directory of (dired or file name) or provided name. If prefixed
use default `*ansi-term*', if prefixes twice ask for a buffer
name"
  (interactive
   (cond
    ((equal current-prefix-arg '(16))
     (list (read-buffer "Term Buffer: " (list "ansi-term"))))
    ((equal current-prefix-arg '(4)) (list "ansi-term"))))
  (let* ((buffer-name (or buffer (mk-term-buffer-name)))
	 (term-buffer-name (concat "*" buffer-name "*")))
    (cond 
     ((buffer-exists term-buffer-name)
      (switch-to-buffer term-buffer-name))
     (t (ansi-term "/bin/bash" buffer-name)))))
