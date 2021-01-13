(require 'package)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
	("melpa" . "http://melpa.org/packages/")
	("org" . "http://orgmode.org/elpa/")))
(package-initialize)
(package-refresh-contents)

(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(defun require-package (package &optional min-version no-refresh)
    "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
    (if (package-installed-p package min-version)
	t
      (if (or (assoc package package-archive-contents) no-refresh)
	  (if (boundp 'package-selected-packages)
	      ;; Record this as a package the user installed explicitly
	      (package-install package nil)
	    (package-install package))
	(progn
  (package-refresh-contents)
	  (require-package package min-version t)))))

(defun maybe-require-package (package &optional min-version no-refresh)
    "Try to install PACKAGE, and return non-nil if successful.
In the event of failure, return nil and print a warning message.
Optionally require MIN-VERSION.  If NO-REFRESH is non-nil, the
available package lists will not be re-downloaded in order to
locate PACKAGE."
    (condition-case err
	(require-package package min-version no-refresh)
      (error
       (message "Couldn't install optional package `%s': %S" package err)
             nil)))

;; use-package
(require-package 'use-package)
(require 'use-package)

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

;; backspace using C-h
(global-set-key "\C-h" 'delete-backward-char)

;; flycheck
(require-package 'flycheck)
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)


;; company-mode
;; (add-hook 'after-init-hook 'global-company-mode)
(require-package 'company)
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
  (define-key company-active-map (kbd "C-i") 'company-complete-selection)
  (define-key company-active-map (kbd "C-h") nil)
  (define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete))


;; auto-complete
(require-package 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(setq ac-use-menu-map t)
(setq ac-use-fuzzy t)
(setq ac-delay 0)
(setq ac-auto-show-menu 0.05)


;; lsp-mode
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(require-package 'jsonrpc)
(require-package 'spinner)
(require 'spinner)
;; setting xref in lsp-mode
(defun lsp-mode-init ()
  (lsp)
  (global-set-key (kbd "M-/") 'xref-pop-marker-stack)
  (global-set-key (kbd "M-.") 'xref-find-definitions)
  (global-set-key (kbd "M-*") 'xref-find-references)
  )

(add-hook 'go-mode-hook 'lsp-mode-init)


;; helm
(require-package 'helm)
(require 'helm)
(require 'helm-config)
(helm-mode 1)


;; ;; ivy-mode
;; counsel: M-x
(require-package 'swiper-helm)
(require 'swiper-helm)
(ivy-mode 1)


;; M-x dumb-jump-go
(require-package 'dumb-jump)
(require 'dumb-jump)
(setq dumb-jump-mode t)


;; ;; projectile
;; (require 'projectile)
;; (projectile-global-mode)
;; ;; ;; TODO
;; ;; (setq projectile-completion-system 'helm)
;; ;; (helm-projectile-on)

;; ;; ;; slime
;; (load (expand-file-name "~/.roswell/helper.el"))
;; ;; (setq inferior-lisp-program "clisp")
;; ;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/slime"))
;; ;; (require 'slime)
;; ;; (slime-setup '(slime-repl slime-fancy slime-banner))

;; ;; ;; geiser
;; (require-package 'geiser)
;; (load-file "~/.emacs.d/elpa/geiser-20200103.1329/geiser.el")
;; (setq geiser-active-implementations '(racket))


;; markdown
(require-package 'markdown-mode)
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


;; ddskk settings
(require-package 'ddskk)
(when (require 'skk nil t)
  (global-set-key (kbd "C-x C-j") 'skk-auto-fill-mode)
  (setq default-input-method "japanese-skk")
  (require 'skk-study))


;; yasnippet
(require-package 'yasnippet)
(require-package 'helm-c-yasnippet)
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
(require-package 'python-mode)
(setenv "PYTHONPATH" "/home/tsukudamayo/lib/miniconda3/envs/kaggle/lib/python3.6/site-packages")
(setenv "PYTHONPATH" "/home/tsukudamayo/lib/miniconda3/envs/pytorch_book/lib/python3.6/site-packages")
(when (autoload 'python-mode "python-mode" "Python editing mode." t)
  (setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
  (setq interpreter-mode-alist (cons '("python" . python-mode)
				     interpreter-mode-alist)))

;; ein(emacs ipython notebook)
(require-package 'ein)
(require 'ein)

;; jedi settings
(require-package 'jedi)
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; ;; autopep8 settings
;; (require 'py-autopep8)
;; (add-hook 'python-mode-hook 'py-autopep8-enable-on-save)

;; yapf settings
(require-package 'py-yapf)
(require 'py-yapf)
(add-hook 'python-mode-hook 'py-yapf-enable-on-save)

;; isort settings
(require-package 'py-isort)
(require 'py-isort)
(add-hook 'python-mode-hook
	 '(lambda()
	    (add-hook 'before-save-hook 'py-isort-before-save)))


;; rust-mode
(require-package 'eglot)
(require-package 'flymake)
(require 'jsonrpc)
(require 'eglot)
(require 'flymake)
(with-eval-after-load 'eglot
  (define-key eglot-mode-map (kbd "C-c C-d") 'eglot-help-at-point)
  (define-key eglot-mode-map (kbd "C-c C-r") 'eglot-code-actions)
  )
(require-package 'spinner)
(require-package 'rust-mode)
(require-package 'rustic)
(require 'rust-mode)
(require 'spinner)
(require 'rustic)
(cl-delete-if (lambda (element) (equal (cdr element) 'rust-mode)) auto-mode-alist)
(cl-delete-if (lambda (element) (equal (cdr element) 'rustic-mode)) auto-mode-alist)
(add-to-list 'auto-mode-alist '("\\.rs$" . rustic-mode))

(defun pop-to-buffer-without-switch (buffer-or-name &optional action norecord)
  (pop-to-buffer buffer-or-name action norecord)
  (other-window -1)
  )


;; golang
(add-to-list 'exec-path (expand-file-name "/usr/local/go/bin/"))
(add-to-list 'exec-path (expand-file-name "/go/bin/"))
(add-to-list 'exec-path (expand-file-name "~/go/bin/"))

(defun lsp-go-install-save-hooks()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(require-package 'go-mode)
(require 'go-mode)
(use-package go-mode
  :ensure t
  :mode (("\\.go\\'" . go-mode))
  :init
  (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
  (add-hook 'go-mode-hook 'company-mode))

(require-package 'lsp-mode)
(require 'lsp-mode)
(use-package lsp-mode
  :ensure t
  :hook
  (go-mode . lsp-deferred)
  :commands (lsp lsp-deferred))

(require-package 'lsp-ui)
(require 'lsp-ui)
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(require-package 'company-lsp)
(require 'company-lsp)
(use-package company-lsp
  :ensure t
  :commands company-lsp)

(add-hook 'go-mode-hook (lambda () (auto-complete-mode -1)))

(add-hook 'go-mode-hook #'lsp-deferred)
(with-eval-after-load 'lsp-mode
  (setq lsp-enable-snippet nil))


;; c, c++
(require-package 'irony)
(require 'irony)
;; (add-to-list 'exec-path "C:/Users/USER/tools/LLVM/bin")
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'company-mode)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(require-package 'company-irony)
(require 'irony)
(add-to-list 'company-backends 'company-irony)
;; (setq irony-lang-compile-option-alist
;;       '((c++-mode . ("c++" "-std=c++11" "-lstdc++" "-lm"))
;;         (c-mode . ("c"))))
(defun irony--loang-compile-option ()
  (irony--awhen (cdr-safe (assq major-mode irony-lang-compile-option-alist))
    (append '("-x") it)))
(setq w32-pipe-read-delay 0)
(add-hook 'irony-mode-hook
	  (lambda () (auto-complete-mode -1)))

;; js
(require-package 'js2-mode)
(when (require 'js2-mode)
  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.es$" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.es6$" . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx$" . js2-mode))

  (add-hook 'js2-mode-hook 'company-mode)
  (setq js-indent-level 2)

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
(require-package 'typescript-mode)
(require 'typescript-mode)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
(require-package 'tide)
(require 'tide)
(add-hook 'typescript-mode-hook
	  (lambda ()
	    (tide-setup)
	    (flycheck-mode t)
	    (setq flycheck-check-syntax-automatically '(save mode-enabled))
	    (eldoc-mode t)
	    (company-mode-on)))
(setq typescript-indent-level 4)

;; web-mode
(require-package 'web-mode)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-hook 'web-mode-hook
	  '(lambda ()
	     (setq web-mode-attr-indent-offset nil)
	     (setq web-mode-markup-indent-offset 2)
	     (setq web-mode-css-indent-offset 2)
	     (setq web-mode-code-indent-offset 2)
	     (setq web-mode-sql-indent-offset 2)
	     (setq indent-tabs-mode nil)
	     (setq tab-width 2)))

;; ;; vue-mode
;; (require-package 'vue-mode)
;; (require 'vue-mode)
;; (require 'flycheck)
;; (add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
;; (eval-after-load 'vue-mode
;;   '(add-hook 'vue-mode-hook #'add-node-modules-path))
;; (flycheck-add-mode 'javascript-eslint 'vue-mode)
;; (flycheck-add-mode 'javascript-eslint 'vue-html-mode)
;; (flycheck-add-mode 'javascript-eslint 'css-mode)
;; (add-hook 'vue-mode-hook 'flycheck-mode)

;; rjsx-mode
(require-package 'rjsx-mode)
(require 'rjsx-mode)
(add-to-list 'auto-mode-alist '(".*\\.js\\'" . rjsx-mode))
(add-hook 'rjsx-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq js-indent-level 2)
            (setq js2-strict-missing-semi-warning nil)))

;; eslint-auto
(defun eslint-fix-file ()
  (interactive)
  (call-process-shell-command
   (mapconcat 'shell-quote-argument
              (list "eslint" "--fix" (buffer-file-name)) " ") nil 0))
(defun eslint-fix-file-and-revert ()
  (interactive)
  (eslint-fix-file)
  (revert-buffer t t))

;; scala
;; Install use-package if not already installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require-package 'use-package)
(require 'use-package)
(require-package 'spinner)
(require 'spinner)

;; Enable defer and ensure by default for use-package
;; Keep auto-save/backup files separate from source code:  https://github.com/scalameta/metals/issues/1027
(setq use-package-always-defer t
      use-package-always-ensure t
      backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;; Enable scala-mode and sbt-mode
(require-package 'scala-mode)
(use-package scala-mode
  :mode "\\.s\\(cala\\|bt\\)$")

(require-package 'sbt-mode)
(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map)
   ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
   (setq sbt:program-options '("-Dsbt.supershell=false"))
)

;; Enable nice rendering of diagnostics like compile errors.
(use-package flycheck
  :init (global-flycheck-mode))

(require-package 'lsp-mode)
(require 'lsp-mode)
(use-package lsp-mode
  ;; Optional - enable lsp-mode automatically in scala files
  :hook (scala-mode . lsp)
  :config (setq lsp-prefer-flymake nil))

(require-package 'lsp-ui)
(use-package lsp-ui)

;; lsp-mode supports snippets, but in order for them to work you need to use yasnippet
;; If you don't want to use snippets set lsp-enable-snippet to nil in your lsp-mode settings
;;   to avoid odd behavior with snippets and indentation
(use-package yasnippet)

;; Add company-lsp backend for metals
(require-package 'company-lsp)
(use-package company-lsp)

(require 'scala-bootstrap)
(require-package 'lsp-mode)
(require 'lsp-mode)

(add-hook 'scala-mode-hook
          '(lambda ()
             (scala-bootstrap:with-metals-installed
              (scala-bootstrap:with-bloop-server-started
               (lsp)))))

;; R
(require-package 'ess)
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
(require 'auto-complete-acr) ;; donwload from github
(require 'ess-R-object-popup)
(define-key ess-mode-map "\C-c\C-g" 'ess-R-object-popup)

;; julia
(require-package 'julia-mode)
(require 'julia-mode)

;; php
(require-package 'php-mode)
(use-package phpunit
  :ensure t)

(provide 'long-php)

(require-package 'lsp-mode)
(use-package lsp-mode
  :config
  (setq lsp-prefer-flymake nil)
  :hook (php-mode . lsp)
  :commands lsp)


;; yaml-mode
(require-package 'yaml-mode)
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))
(require-package 'highlight-indentation)
(require 'highlight-indentation)
(add-hook 'yaml-mode-hook 'highlight-indentation-mode)
(add-hook 'yaml-mode-hook 'highlight-indentation-current-column-mode)
(add-hook 'yaml-mode-hook '(lambda () (setq highlight-indentation-offset 2)))

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

;; toolbar settings
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
 '(ac-go-expand-arguments-into-snippets nil)
 '(custom-enabled-themes '(manoj-dark))
 '(package-selected-packages
   '(phpunit php-mode highlight-indentation yaml-mode company-lsp lsp-ui sbt-mode scala-mode julia-mode ess eglot lsp-mode rjsx-mode vue-mode web-mode tide typescript-mode js2-mode rustic spinner py-autopep8 go-eldoc py-isort py-yapf go-autocomplete auto-complete-auctex company-tern company-racer racer toml-mode company-go go-mode company-jedi flycheck-rust rust-mode company-irony irony ddskk markdown-mode jedi-direx python-mode jedi flymake-python-pyflakes flymake-cursor auto-virtualenvwrapper))
 '(rustic-format-display-method 'pop-to-buffer-without-switch))

