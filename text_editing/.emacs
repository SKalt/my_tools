(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (deeper-blue)))
 '(js-indent-level 2)
 '(js-js-switch-tabs t)
 '(js2-basic-offset 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

;; GLOBAL
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
(add-to-list 'load-path
             "~/.emacs.d/elpa/yasnippet-20160924.2001")
(require 'yasnippet)
(yas-global-mode t)
(vimish-fold-mode t)
(show-paren-mode 1)
(delete-selection-mode 1)
(global-linum-mode 1)
(setq-default indent-tabs-mode nil)
;; KEYBINDINGS 
(global-set-key (kbd "M-f") 'vimish-fold)
(global-set-key (kbd "M-v") 'vimish-fold-delete)
(global-set-key (kbd "M-g") 'vimish-fold-refold)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-v") 'yank)
(global-set-key (kbd "C-o") 'find-file)
(global-set-key (kbd "C-(") 'insert-pair)
(global-set-key (kbd "M-[") 'insert-pair)
(global-set-key (kbd "C-{") 'insert-pair)
(global-set-key (kbd "C-\"") 'insert-pair)
(global-set-key (kbd "C-\'") 'insert-pair)
(global-set-key (kbd "C-`") 'insert-pair)
(global-set-key (kbd "C-a") 'mark-whole-buffer)
(global-set-key (kbd "C->") 'indent-code-rigidly)
;; PYTHON
(add-hook 'python-mode-hook (lambda ()
                  (require 'sphinx-doc)
                  (sphinx-doc-mode t)))
(defun python-args-to-google-docstring (text &optional make-fields)
  "Return a reST docstring format for the python arguments in yas-text."
  (let* ((indent (concat "\n" (make-string (current-column) 32)))
         (args (python-split-args text))
     (nr 0)
         (formatted-args
      (mapconcat
       (lambda (x)
         (concat "   " (nth 0 x)
             (if make-fields (format " ${%d:arg%d}" (incf nr) nr))
             (if (nth 1 x) (concat " \(default " (nth 1 x) "\)"))))
       args
       indent)))
    (unless (string= formatted-args "")
      (concat
       (mapconcat 'identity
          (list "" "Args:" formatted-args)
          indent)
       "\n"))))
(add-hook 'python-mode-hook (lambda () (interactive) (column-marker-1 80)))

;; JAVASCRIPT
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(require 'js-doc)
(require 'json)
(defun parse-jslinter-warning (warning)
  (flycheck-error-new
   :line (1+ (cdr (assoc 'line warning)))
   :column (1+ (cdr (assoc 'column warning)))
   :message (cdr (assoc 'message warning))
   :level 'error))
(add-hook 'js2-mode-hook
           #'(lambda ()
               (define-key js2-mode-map "\C-ci" 'js-doc-insert-function-doc)
               (define-key js2-mode-map "@" 'js-doc-insert-tag)))
(add-hook 'js2-mode-hook (lambda () (interactive) (column-marker-1 80)))

(defun jslinter-error-parser (output checker buffer)
  (mapcar 'parse-jslinter-warning
          (cdr (assoc 'warnings (aref (json-read-from-string output) 0)))))
(flycheck-define-checker javascript-jslinter
  "A JavaScript syntax and style checker based on JSLinter.

See URL `https://github.com/tensor5/JSLinter'."
  :command ("/usr/local/lib/node_modules/jslinter/jslint" "--raw" source)
  :error-parser jslinter-error-parser
  :modes (js-mode js2-mode js3-mode))

;; (require 'multi-web-mode)
;; (setq mweb-default-major-mode 'html-mode)
;; (setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
;;                   (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
;;                   (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
;; (setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
;; (multi-web-global-mode 1)

;; WEB
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;; BASH
(add-hook 'sh-mode-hook (lambda () (interactive) (column-marker-1 80)))
;; END
(provide 'emacs)
;;; .emacs ends here
