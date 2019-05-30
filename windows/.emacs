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
(set-file-name-coding-system 'cp932)
(set-keyboard-coding-system 'cp932)
(set-terminal-coding-system 'cp932)

;; backspace using C-h
(global-set-key "\C-h" 'delete-backward-char)

;; fly-check
(add-hook 'after-init-hook #'global-flycheck-mode)

;; tramp
(setenv "PATH" (concat "c:/Users/tsukuda/tools/PuTTY" ";" (getenv "PATH")))
(setq tramp-default-method "plink")


;; company-mode
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


;; yasnippet
(require 'yasnippet)
(require 'helm-c-yasnippet)
(setq helm-yas-space-match-any-greedy t)
(global-set-key (kbd "C-c y") 'helm-yas-complete)
(yas-load-directory "~/.emacs.d/snippets/")
(setq yas-snippet-dirs
      '("~/.emacs.d/mysnippets"
	yas-installed-snippets-dir))
(push '("emacs.+/snippets/" . snippet-mode) auto-mode-alist)
(yas-global-mode 1)


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


;; ddskk
(global-set-key (kbd "C-x C-j") 'skk-mode)


;; markdown
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


;; python-mode
(setenv "PYTHONPATH" "c:/Users/tsukuda/tools/Miniconda3/envs/anomaly_detection/Lib/site-packages")
;; (setenv "PYTHONPATH" "c:/Users/tsukuda/tools/Miniconda3/envs/crawler/Lib/site-packages")
;; (setenv "PYTHONPATH" "c:/Users/tsukuda/lib/opencv/modules/python/src2")
(when (autoload 'python-mode "python-mode" "Python editing mode." t)
  (setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
  (setq interpreter-mode-alist (cons '("python" . python-mode)
				     interpreter-mode-alist)))

(defun auto-python-format()
  (when (eq major-mode 'python-mode)
    (interactive)
    (let ((pep8 "autopep8 -i ")
	  (filepath buffer-file-name)))
    (message pep8)
    (message filepath)))
    ;; (shell-command-to-string "pwd")
    ;; (message cmd)))
(add-hook 'after-save-hook 'auto-python-format)

;; ein(emacs ipython notebook)
(require 'ein)

;; ;; company-jedi settings
;; ;; M-x package-install company-jedi
;; (require 'jedi-core)
;; (setq jedi:complete-on-dot t)
;; (setq jedi:use-shortcuts t)
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (add-to-list 'company-backends 'company-jedi)

;; jedi settings
(require 'jedi)
(setq jedi:complete-on-dot t)
;; (setq jedi:use-shortcuts t)
(add-hook 'python-mode-hook 'jedi:setup)

;; ;; virtualenvwapper
;; (require 'virtualenvwrapper)
;; (require 'auto-virtualenvwrapper)
;; (add-hook 'python-mode-hook #'auto-virtualenvwrapper-activate)


;; golang
(add-to-list 'exec-path (expand-file-name "c:/Users/USER/tools/go/bin/"))
(add-to-list 'exec-path (expand-file-name "c:/Users/USER/go/bin/"))
(require 'go-mode)

;; ;; golang company-go
;; (require 'company-go)
;; (add-hook 'go-mode-hook 'company-mode)
;; (add-hook 'go-mode-hook 'flycheck-mode)

;; golang go-autocomplete
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)
(eval-after-load "go-mode"
  '(progn
     (require 'go-autocomplete)))

(add-hook 'go-mode-hook (lambda ()
	(add-hook 'before-save-hook' 'gogmt-before-save)
	(local-set-key (kbd "M-.") 'godef-jump)
	;; (set (make-local-variable 'compamy-backends) '(company-go))
	;; (company-mode)
	(setq indent-tabs-mode nil)
	(setq c-basic-offset 4)
	(setq tab-width 4)))


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
;; (add-to-list 'exec-path "C:/Users/USER/tools/LLVM/bin")
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

;; ;; c#
;; (add-hook 'csharp-mode-hook 'omnisharp-mode)
;; (eval-after-load
;;     'company
;;     '(add-to-list 'company-backends #'company-omnisharp))
;; (add-hook 'charp-mode-hook #'compamy-mode)


;; js
(when (require 'js2-mode)
  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.es$" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.es6$" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx$" . js2-mode))

  (add-hook 'js2-mode-hook 'company-mode)

  (setq company-tern-property-marker "")
  (defun company-tern-depth (candidate)
    "Return depth attribute for CANDIDATE. 'nil' entries are treated as 0."
    (let ((depth (get-text-property 0 'depth candidate)))
      (if (eq depth nil) 0 depth)))

  (add-hook 'js2-mode-hook
            '(lambda ()
               (setq tern-command '("tern" "--no-port-file"))
               (tern-mode t)))

  (add-to-list 'company-backends 'company-tern)


  (when (require 'flycheck)
     (flycheck-add-mode 'javascript-eslint 'js2-mode))
)


;; typescript
(require 'typescript-mode)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(require 'tide)
(add-hook 'typescript-mode-hook
	  (lambda ()
	    (tide-setup)
	    (flycheck-mode t)
	    (setq flycheck-check-syntax-automatically '(save mode-enabled))
	    (eldoc-mode t)
	    (company-mode-on)))
(setq typescript-indent-level 2)

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; vue-mode
(require 'vue-mode)
(require 'flycheck)
(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
(eval-after-load 'vue-mode
  '(add-hook 'vue-mode-hook #'add-node-modules-path))
(flycheck-add-mode 'javascript-eslint 'vue-mode)
(flycheck-add-mode 'javascript-eslint 'vue-html-mode)
(flycheck-add-mode 'javascript-eslint 'css-mode)
(add-hook 'vue-mode-hook 'flycheck-mode)


;; R
(require 'ess-site)
(add-to-list 'auto-mode-alist '("\\.[rR]$" . R-mode))
(autoload 'R-mode "ess-site" "Emacs Speaks Statistics mode" t)
(autoload 'R "ess-site" "start R" t)
(setq ess-loaded-p nil)
(defun ess-load-hook (&optional from-iess-p)
  (setq ess-indent-level 2)
  (setq ess-arg-function-offset-new-line (list ess-indent-level))
  (make-variable-buffer-local 'comment-add)
  (setq comment-add 0)
  (when (not ess-loaded-p)
    (setq ess-use-auto-complete t)
    (setq ess-use-ido nil)
    (setq ess-eldoc-show-on-symbol t)
    (setq ess-ask-for-ess-directory nil)
    (setq ess-fancy-comments nil)
    (setq ess-loaded-p t)
    (unless from-iess-p

      (when (one-window-p)
        (split-window-below)
        (let ((buf (current-buffer)))
          (ess-switch-to-ESS nil)
          (switch-to-buffer-other-window buf)))
      (when (and ess-use-auto-complete (require 'auto-complete nil t))
        (add-to-list 'ac-modes 'ess-mode)
        (mapcar (lambda (el) (add-to-list 'ac-trigger-commands el))
                '(ess-smart-comma smart-operator-comma skeleton-pair-insert-maybe))
        (setq ac-sources '(ac-source-acr
                           ac-source-R
                           ac-source-filename
                           ac-source-yasnippet)))))

  (if from-iess-p
      (if (> (length ess-process-name-list) 0)
          (when (one-window-p)
            (split-window-horizontally)
            (other-window 1)))
    (ess-force-buffer-current "Process to load into: ")))

(add-hook 'R-mode-hook 'ess-load-hook)

(defun ess-pre-run-hooks ()
  (ess-load-hook t))
(add-hook 'ess-pre-run-hook 'ess-pre-run-hooks)
;; auto-complete-acr
(require 'auto-complete-acr)
(require 'ess-R-object-popup)
(define-key ess-mode-map "\C-c\C-g" 'ess-R-object-popup)

;; ;; julia
;; (setq inferior-julia-program-name "c:/Users/USER/tools/Julia-1.1.0/bin/julia.exe")

;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(setq web-mode-markup-indent-offset 2)

(tool-bar-mode -1)


;; ;; python keyboard macro
(fset 'importpy
      [return ?\C-  ?\C-  ?\C-p ?\C-  ?\C-e ?\C-w ?\M-< return ?\C-p ?\C-y ?\C-u ?\C-  ?\C-u ?\C- ])

;; emacs-lisp-mode
(add-hook 'emacs-lisp-mode-hook 'company-mode)
(add-hook 'emacs-lisp-mode-hook
	  (lambda () (auto-complete-mode -1)))

;; shell-mode
(add-hook 'shell-mode-hook 'company-mode)
(add-hook 'shell-mode-hook
	  (lambda () (auto-complete-mode -1)))

;; eshell-mode
(add-hook 'eshell-mode-hook 'company-mode)
(add-hook 'eshell-mode-hook
	  (lambda () (auto-complete-mode -1)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ricty Diminished" :foundry "outline" :slant normal :weight bold :height 120 :width normal))))
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
    (ess-R-data-view tern-auto-complete company-tern py-autopep8 py-yapf py-isort yasnippet-snippets go-autocomplete company-jedi 0blayout company-irony flycheck-rust rust-mode auto-complete-c-headers projectile helm omnisharp company-go ein flycheck python-mode markdown-mode jedi flymake-python-pyflakes flymake-cursor)))
 '(tool-bar-mode nil))
