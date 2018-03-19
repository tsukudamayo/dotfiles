(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)

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

;; ddskk
(setq load-path (cons "c:/Users/USER/opt/emacs-25.3-x86_64/share/emacs/site-lisp/skk" load-path))
(setq Info-default-directory-list
      (cons "c:/Users/USER/opt/emacs-25.3-x86_64/share/info" Info-default-directory-list))
(global-set-key (kbd "C-x C-j") 'skk-mode)

;; fly-check
(add-hook 'after-init-hook #'global-flycheck-mode)

;; company-mode
;; (add-hook 'after-init-hook 'global-company-mode)
(require 'company)
(with-eval-after-load 'company
	(setq company-transformers '(company-sort-by-backend-importance))
	(setq company-selection-wrap-around t)
	(global-set-key (kbd "C-M-i") 'company-complete)
	(define-key company-active-map (kbd "C-n") 'company-select-next)
	(define-key company-active-map (kbd "C-p") 'company-select-previous)
	(define-key company-active-map (kbd "C-s") 'company-filter-candidates)
	(define-key company-active-map [tab] 'company-complete-selection)
	(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete))

;; ;; auto-complete
;; (require 'auto-complete-config)
;; (ac-config-default)
;; ;; (global-auto-complete-mode t)
;; (setq ac-use-menu-map t)
;; (setq ac-use-fuzzy t)

;; helm
(require 'helm)
(require 'helm-config)
(helm-mode 1)

;; projectile
(require 'projectile)
(projectile-global-mode)
;; ;; TODO
;; (setq projectile-completion-system 'helm)
;; (helm-projectile-on)

;; ;; slime
;; (setq inferior-lisp-program "clisp")
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/slime"))
;; (require 'slime)
;; (slime-setup '(slime-repl slime-fancy slime-banner))

;; shell-mode
(add-hook 'shell-mode-hook 'company-mode)

;; eshell-mode
(add-hook 'eshell-mode-hook 'company-mode)

;; python-mode
(when (autoload 'python-mode "python-mode" "Python editing mode." t)
  (setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
  (setq interpreter-mode-alist (cons '("python" . python-mode)
				     interpreter-mode-alist)))

;; ein(emacs ipython notebook)
(require 'ein)

;; jedi settings
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; goloang
(add-to-list 'exec-path (expand-file-name "c:/tools/go/bin/"))
(add-to-list 'exec-path (expand-file-name "c:/Users/USER/lib/go/bin/"))
(require 'go-mode)
(require 'company-go)
(add-hook 'go-mode-hook 'company-mode)
(add-hook 'go-mode-hook 'flycheck-mode)
(add-hook 'go-mode-hook (lambda ()
	(add-hook 'before-save-hook' 'gogmt-before-save)
	(local-set-key (kbd "M-.") 'godef-jump)
	(set (make-local-variable 'compamy-backends) '(company-go))
	(company-mode)
	(setq indent-tabs-mode nil)
	(setq c-basic-offset 4)
	(setq tab-width 4)))


;; rust-mode
(add-to-list 'exec-path 'expand-file-name "c:/Program Files/Rust stable GNU 1.24/bin/")
(eval-after-load "rust-mode"
  '(setq-default rust-format-on-save t))
;; (add-hook 'rust-mode-hook 'lambda ()
;; 	  (racer-mode)
;; 	  (flycheck-rust-setup)))
;; (add-hook 'racer-mode-hook #'eldoc-mode)
;; (add-hook 'racer-mode-hook (lambda ()
;; 			     (company-mode)))


;; c, c++
(require 'irony)
(add-to-list 'exec-path "C:/Users/USER/tools/LLVM/bin")
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'company-mode)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(add-to-list 'company-backends 'company-irony)
;; (setq irony-lang-compile-option-alist
;;       '((c++-mode . ("c++" "-std=c++11" "-lstdc++" "-lm"))
;;         (c-mode . ("c"))))
(defun irony--loang-compile-option ()
  (irony--awhen (cdr-safe (assq major-mode irony-lang-compile-option-alist))
    (append '("-x") it)))
(setq w32-pipe-read-delay 0)

;; c#
(add-hook 'csharp-mode-hook 'omnisharp-mode)
(eval-after-load
    'company
    '(add-to-list 'company-backends #'company-omnisharp))
(add-hook 'charp-mode-hook #'compamy-mode)

;; markdown
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(tool-bar-mode -1)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ricty Diminished" :foundry "outline" :slant normal :weight bold :height 110 :width normal))))
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
    (company-irony flycheck-rust rust-mode auto-complete-c-headers projectile helm omnisharp company-go ein flycheck python-mode markdown-mode jedi flymake-python-pyflakes flymake-cursor)))
 '(tool-bar-mode nil))
