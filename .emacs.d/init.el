(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; settings load-path
(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/elpa")

;; settings backup directory
(setq backup-directory-alist
  (cons (cons ".*" (expand-file-name "~/.emacs.d/backup"))
        backup-directory-alist))
(setq auto-save-file-name-transforms
  `((".*", (expand-file-name "~/.emacs.d/backup/") t)))

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; company
(require 'company)
(global-company-mode)

;; markdown
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; ddskk settings
(when (require 'skk nil t)
  (global-set-key (kbd "C-x C-j") 'skk-auto-fill-mode)
  (setq default-input-method "japanese-skk")
  (require 'skk-study))

;; python-mode settings
(require 'python-mode)
(setq auto-mode-alist (cons '("\\.py\\'" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode) interpreter-mode-alist))

;; jedi settings
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; ein(emacs ipython notebook)
(require 'ein)

;; golang
(add-to-list 'exec-path (expand-file-name "/home/tsukudamayo/opt/go/bin/"))
(add-to-list 'exec-path (expand-file-name "/home/tsukudamayo/.go/bin/"))
(require 'go-mode)
(require 'company-go)
(add-hook 'go-mode-hook 'company-mode)
(add-hook 'go-mode-hook 'flycheck-mode)
(add-hook 'go-mode-hook (lambda ()
			  (add-hook 'before-save-hook' 'gofmt-before-save)
			  (local-set-key (kbd "M-.") 'godef-jump)
			  (set (make-local-variable 'company-backends) '(company-go))
			  (company-mode)
			  (setq indent-tabs-mode nil)
			  (setq c-basic-offset 4)
			  (setq tab-width 4)))


;; c,c++
(require 'irony)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-to-list 'company-backends 'company-irony)

;; rust
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin/"))
(eval-after-load "rust-mode"
  '(setq-default rust-format-on-save t))
(add-hook 'racer-mode-hook (lambda ()
			     (racer-mode)
			     (flycheck-rust-setup)))
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook (lambda ()
			     (company-mode)))


;; ;; TODO
;; ;; google translate
;; (require 'google-translate)
;; (defvar google-translate-english-chars "[:ascii:]’“”–"
;;   "これらの文字が含まれているときは英語とみなす")
;; (defun google-translate-enja-or-jaen (&optional string)
;;   "regionか、現在のセンテンスを言語自動判別でGoogle翻訳する。"
;;   (interactive)
;;   (setq string
;;         (cond ((stringp string) string)
;;               (current-prefix-arg
;;                (read-string "Google Translate: "))
;;               ((use-region-p)
;;                (buffer-substring (region-beginning) (region-end)))
;;               (t
;;                (save-excursion
;;                  (let (s)
;;                    (forward-char 1)
;;                    (backward-sentence)
;;                    (setq s (point))
;;                    (forward-sentence)
;;                    (buffer-substring s (point)))))))
;;   (let* ((asciip (string-match
;;                   (format "\\`[%s]+\\'" google-translate-english-chars)
;;                   string)))
;;     (run-at-time 0.1 nil 'deactivate-mark)
;;     (google-translate-translate
;;      (if asciip "en" "ja")
;;      (if asciip "ja" "en")
;;      string)))
;; (global-set-key (kbd "C-c t") 'google-translate-enja-or-jaen)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; highlight flymake error and warnings
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-error ((((class color)) (:foreground "yellow" :bold t :background "red"))))
 '(flycheck-warning ((((class color)) (:foreground "red" :bold t :background "yellow")))))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (manoj-dark)))
 '(package-selected-packages
   (quote
    (flycheck-rust rust-mode company-irony irony ddskk markdown-mode jedi-direx python-mode jedi flymake-python-pyflakes flymake-cursor auto-virtualenvwrapper))))

