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

;; encoding
(prefer-coding-system 'utf-8)

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; company-mode
;; (add-hook 'after-init-hook 'global-company-mode)
(require 'company)
(with-eval-after-load 'company
  (setq company-transformers '(company-sort-by-backend-importance))
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (setq company-selection-wrap-around t)
  (global-set-key (kbd "C-M-i") 'company-complete)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "C-s") 'company-filter-candidates)
  (define-key company-active-map [tab] 'company-complete-selection)
  (define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete))

;; auto-complete
(require 'auto-complete-config)
(ac-config-default)
(setq ac-use-menu-map t)
(setq ac-use-fuzzy t)
(setq ac-delay 0)
(setq ac-auto-show-menu 0.05)

;; helm
(require 'helm)
(require 'helm-config)
(helm-mode 1)

;; ;; projectile
;; (require 'projectile)
;; (projectile-global-mode)
;; ;; ;; TODO
;; ;; (setq projectile-completion-system 'helm)
;; ;; (helm-projectile-on)

;; ;; slime
;; (setq inferior-lisp-program "clisp")
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/slime"))
;; (require 'slime)
;; (slime-setup '(slime-repl slime-fancy slime-banner))

;; markdown
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; ddskk settings
(when (require 'skk nil t)
  (global-set-key (kbd "C-x C-j") 'skk-auto-fill-mode)
  (setq default-input-method "japanese-skk")
  (require 'skk-study))

;; python-mode
(setenv "PYTHONPATH" "/home/tsukudamayo/lib/miniconda3/envs/cnn/lib/python3.6/site-packages")
(when (autoload 'python-mode "python-mode" "Python editing mode." t)
  (setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
  (setq interpreter-mode-alist (cons '("python" . python-mode)
				     interpreter-mode-alist)))

;; ein(emacs ipython notebook)
(require 'ein)

;; ;; company-jedi settings
;; (require 'jedi-core)
;; (setq jedi:complete-on-dot t)
;; (setq jedi:use-shortcuts t)
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (add-to-list 'company-backends 'company-jedi)

;; jedi settings
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; autopep8 settings
(require 'py-autopep8)
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)

;; yapf settings
(require 'py-yapf)
(add-hook 'python-mode-hook 'py-yapf-enable-on-save)

;; isort settings
(require 'py-isort)
(add-hook 'python-mode-hook
	 '(lambda()
	    (add-hook 'before-save-hook 'py-isort-before-save)))

;; golang
(add-to-list 'exec-path (expand-file-name "/usr/lib/go-1.10/bin"))
(add-to-list 'exec-path (expand-file-name "~/go/bin"))
(require 'go-mode)

;; ;; company-go
;; (require 'company-go)
;; (add-hook 'go-mode-hook 'company-mode)
;; (add-hook 'go-mode-hook 'flycheck-mode)

;; go-autocomplete
(eval-after-load "go-mode"
  '(progn
     (require 'go-autocomplete)))
(add-hook 'go-mode-hook (lambda ()
	(add-hook 'before-save-hook' 'gofmt-before-save)
	(local-set-key (kbd "M-.") 'godef-jump)
	(local-set-key (kbd "C-f C-m") 'gofmt)
	(set (make-local-variable 'compamy-backends) '(company-go))
	(company-mode)
	(setq indent-tabs-mode nil)
	(setq c-basic-offset 4)
	(setq tab-width 4)))

;; go-eldoc
(require 'go-eldoc)
(add-hook 'go-mode-hook 'go-eldoc-setup)
(set-face-attribute 'eldoc-highlight-function-argument nil
		    :underline t :foreground "green"
		    :weight 'bold)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-go-expand-arguments-into-snippets nil)
 '(custom-enabled-themes (quote (manoj-dark)))
 '(package-selected-packages
   (quote
    (py-autopep8 go-eldoc py-isort py-yapf go-autocomplete auto-complete-auctex company-tern company-racer racer toml-mode company-go go-mode company-jedi flycheck-rust rust-mode company-irony irony ddskk markdown-mode jedi-direx python-mode jedi flymake-python-pyflakes flymake-cursor auto-virtualenvwrapper))))

;; ;; rust-mode
;; (add-to-list 'exec-path 'expand-file-name "c:/Program Files/Rust stable GNU 1.24/bin/")
;; (eval-after-load "rust-mode"
;;   '(setq-default rust-format-on-save t))
;; (require 'company-racer)
;; (eval-after-load 'company-mode
;;   (add-to-list 'company-backends 'company-racer))
;; (add-hook 'rust-mode-hook #'racer-mode)
;; (add-hook 'racer-mode-hook #'company-mode)
;; (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
;; (unless (getenv "RUST_SRC_PATH")
;;   (setenv "RUST_SRC_PATH" (expand-file-name "lib/src/rust/src")))

;; ;; c, c++
;; (require 'irony)
;; ;; (add-to-list 'exec-path "C:/Users/USER/tools/LLVM/bin")
;; (add-hook 'c-mode-hook 'irony-mode)
;; (add-hook 'c-mode-hook 'company-mode)
;; (add-hook 'c++-mode-hook 'irony-mode)
;; (add-hook 'c++-mode-hook 'company-mode)
;; (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
;; (add-to-list 'company-backends 'company-irony)
;; ;; (setq irony-lang-compile-option-alist
;; ;;       '((c++-mode . ("c++" "-std=c++11" "-lstdc++" "-lm"))
;; ;;         (c-mode . ("c"))))
;; (defun irony--loang-compile-option ()
;;   (irony--awhen (cdr-safe (assq major-mode irony-lang-compile-option-alist))
;;     (append '("-x") it)))
;; (setq w32-pipe-read-delay 0)

;; ;; js
;; (setq company-tern-property-marker "")
;; (defun company-tern-depth (candidate)
;;   "Return depth attribute for CANDIDATE. 'nil' entries are treated as 0."
;;   (let ((depth (get-text-property 0 'depth candidate)))
;;     (if (eq depth nil) 0 depth)))
;; (add-hook 'js2-mode-hook 'tern-mode)
;; (add-to-list 'company-backends 'company-tern)

;; emacs-lisp-mode
(add-hook 'emacs-lisp-mode-hook 'company-mode)

;; shell-mode
(add-hook 'shell-mode-hook 'company-mode)

;; eshell-mode
(add-hook 'eshell-mode-hook 'company-mode)

(tool-bar-mode -1)

;; keyboard macro
;; python import
(fset 'importpy
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([18 105 109 112 111 114 116 return 67108896 67108896 67108896 5 23 134217788 return 16 25 21 67108896 21 67108896] 0 "%d")) arg)))
;; frompy
(fset 'frompy
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([18 102 114 111 109 return 67108896 67108896 67108896 5 5 23 134217788 return 16 25 21 67108896 21 67108896] 0 "%d")) arg)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; highlight flymake error and warnings
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-error ((((class color)) (:foreground "yellow" :bold t :background "red"))))
 '(flycheck-warning ((((class color)) (:foreground "red" :bold t :background "yellow")))))
