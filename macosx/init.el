(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; settings load-path
(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/elpa")

;; auto-install
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/elpa")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

;; settings backup directory
(setq backup-directory-alist
  (cons (cons ".*" (expand-file-name "~/.emacs.d/backup"))
        backup-directory-alist))
(setq auto-save-file-name-transforms
      `((".*", (expand-file-name "~/.emacs.d/backup/") t)))

;; using backspace C-h
(define-key global-map "\C-h" 'delete-backward-char)

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
(require 'auto-complete)
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

;; yasnippet
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/mysnippets"
       yas-installed-snippets-dir))
(require 'helm-c-yasnippet)
(setq helm-yas-space-match-any-greedy t)
(global-set-key (kbd "C-c y") 'helm-yas-complete)
(push '("emacs.+/snippets/" . snippet-mode) auto-mode-alist)
(yas-global-mode 1)

;; python-mode
(setenv "PYTHONPATH" "~/lib/python")
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

;; yapf settings
(require 'py-yapf)
(add-hook 'python-mode-hook 'py-yapf-enable-on-save)

;; isort settings
(require 'py-isort)
(add-hook 'python-mode-hook
	 '(lambda()
	    (add-hook 'before-save-hook 'py-isort-before-save)))

;; golang
(add-to-list 'exec-path (expand-file-name "c:/tools/go/bin/"))
(add-to-list 'exec-path (expand-file-name "c:/Users/USER/lib/go/bin/"))
(require 'go-mode)

;; ;; company-go
;; (require 'company-go)
;; (add-hook 'go-mode-hook 'company-mode)

;; auto-complete-go
(eval-after-load "go-mode"
  '(progn
     (require 'go-autocomplete)))

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
(require 'company-racer)
(eval-after-load 'company-mode
  (add-to-list 'company-backends 'company-racer))
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'company-mode)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
(unless (getenv "RUST_SRC_PATH")
  (setenv "RUST_SRC_PATH" (expand-file-name "lib/src/rust/src")))

;; c, c++
(require 'irony)
;; (add-to-list 'exec-path "C:/Users/USER/tools/LLVM/bin")
(add-hook 'c-mode-hook (lambda () (auto-complete-mode -1)))
(add-hook 'c++-mode-hook (lambda () (auto-complete-mode -1)))
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

;; js
(setq company-tern-property-marker "")
(defun company-tern-depth (candidate)
  "Return depth attribute for CANDIDATE. 'nil' entries are treated as 0."
  (let ((depth (get-text-property 0 'depth candidate)))
    (if (eq depth nil) 0 depth)))
(add-hook 'js2-mode-hook 'tern-mode)
(add-to-list 'company-backends 'company-tern)


;; R
(require 'ess-site)
(add-to-list 'auto-mode-alist '("\\.[rR]$" . R-mode))
(autoload 'R-mode "ess-site" "Emacs Speaks Statistics mode" t)
(add-hook 'R-mode-hook (lambda () (auto-complete-mode -1)))
(add-hook 'R-mode-hook 'company-mode)
(define-key company-active-map (kbd "M-h") 'company-show-doc-buffer)
(setq ess-ask-for-ess-directory nil)
(ess-toggle-underscore nil)


;; (setq ess-loaded-p nil)
;; (defun ess-load-hook (&optional from-iess-p)
;;   (setq ess-indent-level 2)
;;   (setq ess-arg-function-offset-new-line (list ess-indent-level))
;;   (make-variable-buffer-local 'comment-add)
;;   (setq comment-add 0)

;;   (when (not ess-loaded-p)
;;     (setq ess-use-auto-complete t)
;;     (setq ess-use-ido nil)
;;     (setq ess-eldoc-show-on-symbol t)
;;     (setq ess-ask-for-ess-directory nil)
;;     (setq ess-fancy-comments nil)
;;     (setq ess-loaded-p t)
;;     (unless from-iess-p
;;       (when (one-window-p)
;;         (split-window-below)
;;         (let ((buf (current-buffer)))
;;           (ess-switch-to-ESS nil)
;;           (switch-to-buffer-other-window buf)))
;;       (when (and ess-use-auto-complete (require 'auto-complete nil t))
;;         (add-to-list 'ac-modes 'ess-mode)
;;         (mapcar (lambda (el) (add-to-list 'ac-trigger-commands el))
;;                 '(ess-smart-comma smart-operator-comma skeleton-pair-insert-maybe))
;;         (setq ac-sources '(ac-source-acr
;;                            ac-source-R
;;                            ac-source-filename
;;                            ac-source-yasnippet)))))

;;   (if from-iess-p
;;       (if (> (length ess-process-name-list) 0)
;;           (when (one-window-p)
;;             (split-window-horizontally)
;;             (other-window 1)))
;;     (ess-force-buffer-current "Process to load into: ")))

;; (add-hook 'R-mode-hook 'ess-load-hook)

;; (defun ess-pre-run-hooks ()
;;   (ess-load-hook t))
;; (add-hook 'ess-pre-run-hook 'ess-pre-run-hooks)

;; auto-complete-acr
;; (require 'auto-complete)
;; (require 'auto-complete-yasnippet)
;; (require 'auto-complete-acr)

;; julia
(require 'julia-mode)
;; (autoload 'julia-mode "julia-mode" "Emacs mode for Julia" t)
;; (add-to-list 'auto-mode-alist '("\\.jl'" . julia-mode)
(autoload 'julia-mode "julia-mode" "Emacs mode for Julia" t)
(add-to-list 'auto-mode-alist '("\\.jl\\'" . julia-mode))
(add-hook 'julia-mode-hook (lambda () (auto-complete-mode -1)))
(add-hook 'julia-mode-hook 'company-mode)
(define-key company-active-map (kbd "M-h") 'company-show-doc-buffer)

;; SQL
(eval-after-load "sql"
  '(load-library "sql-indent"))

(defun sql-mode-hooks()
  (setq sql-indent-offset 2)
  (setq indennt-tabs-mode nil)
  (sql-set-product "postgres"))

(add-hook 'sql-mode-hook 'sql-mode-hooks)

;; markdown
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; emacs-lisp-mode
(add-hook 'emacs-lisp-mode-hook 'company-mode)

;; shell-mode
(add-hook 'shell-mode-hook 'company-mode)

;; eshell-mode
(add-hook 'eshell-mode-hook 'company-mode)

;; tool-bar setting
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



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (manoj-dark)))
 '(package-selected-packages
   (quote
    (ess go-autocomplete helm-c-yasnippet yasnippet sql-indent closql company-tern company-racer racer toml-mode company-go go-mode company-jedi flycheck-rust rust-mode company-irony irony ddskk markdown-mode jedi-direx python-mode jedi flymake-python-pyflakes flymake-cursor auto-virtualenvwrapper)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
