(require 'profiler)
(profiler-start 'cpu)

(require 'package)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
	("melpa" . "http://melpa.org/packages/")
	("org" . "http://orgmode.org/elpa/")))

(package-initialize)
;; (package-refresh-contents))

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

;; calculate performance tp launch Emacs
(add-hook 'after-init-hook
	  (lambda ()
	    (message "init time: %.3f sec"
		     (float-time
		      (time-subtract after-init-time before-init-time)))))

;; use-package
(require-package 'use-package)
(require 'use-package)

;; settings load-path
(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/elpa")

;; straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
      (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
        "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
        'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

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
;; widonws
(global-set-key (kbd "C-c C-SPC") 'set-mark-command)

;; backslash for japanese keyboard
(defun insert-backslash ()
  (interactive)
  (insert "\\"))
(define-key global-map [?\M-¥] 'insert-backslash)
(defun isearch-add-backslash()
  (interactive)
  (isearch-printing-char ?\\ 1))
(define-key isearch-mode-map [?\M-¥] 'isearch-add-backslash)

;; C-' as dabbrev-expand
(global-set-key (kbd "C-'") 'dabbrev-expand)

;; share docker containers and clipboard
;; apt install xsel in docker containers
(unless window-system
  (defun xsel-cut-function (text &optional push)
    (with-temp-buffer
      (insert text)
      (call-shell-region (point-min) (point-max) "DISPLAY=$DISPLAY xsel -bi")))
  (defun xsel-paste-function ()
    (let ((xsel-output (shell-command-to-string "DISPLAY=$DISPLAY xsel --clipboard --output")))
      (unless (string= (car kill-ring) xsel-output) xsel-output)))
  (setq interprogram-cut-function 'xsel-cut-function)
  (setq interprogram-paste-function 'xsel-paste-function))

;; flycheck
(require-package 'flycheck)
(use-package flycheck
  :defer t
  )
;; (require 'flycheck)
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
(require-package 'lsp-mode)
;; (require 'lsp-mode)
(use-package lsp-mode
  :ensure t
  :defer t
  :hook (
	 (go-mode . lsp-deferred)
	 (rust-mode . lsp-deferred)
	 (python-mode . lsp-deferred)
	 (typescript-mode . lsp-deferred)
	 (lean4-mode . lsp-deferred)
	 (lsp-managed-mode . (lambda () (setq-local company-backends '(company-capf))))
	 )

  :bind ("C-c h" . lsp-describe-thing-at-point)
  ;; :commands (lsp . lsp-deferred)
  )

(advice-add 'lsp :before (lambda (&rest _args) (eval '(setf (lsp-session-server-id->folders (lsp-session)) (ht)))))


(require-package 'lsp-ui)
;; (require 'lsp-ui)
(use-package lsp-ui
  :defer t
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode))
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(require-package 'jsonrpc)
(require-package 'spinner)
(require 'spinner)

(setq lsp-response-timeout 4)

;; setting xref in lsp-mode
(defun lsp-mode-init ()
  (lsp)
  (global-set-key (kbd "M-/") 'xref-pop-marker-stack)
  (global-set-key (kbd "M-.") 'xref-find-definitions)
  (global-set-key (kbd "M-*") 'xref-find-references)
  )
(require-package 'lsp-docker)
(require 'lsp-docker)


;; helm
(require-package 'helm)
(use-package helm
  :defer t)
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

;; magit
(require-package 'magit)
(require 'magit)
(defalias 'magit 'magit-status)
(global-set-key "\C-xg" 'magit-status)
(setenv "GIT_EDITOR" "emacsclient")
(add-hook 'shell-mode-hook 'with-editor-export-git-editor)

;; Docker
(require-package 'docker)
(require-package 'dockerfile-mode)
(require-package 'docker-compose-mode)
(require-package 'docker-tramp)
(use-package docker)
(use-package dockerfile-mode)
(use-package docker-compose-mode)
(use-package docker-tramp-compat)
(use-package docker-tramp)
(autoload 'dockerfile-mode "dockerfile-mode" nil t)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))
(set-variable 'docker-tramp-use-names t)
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)


;; python-mode
(require-package 'python-mode)
(when (autoload 'python-mode "python-mode" "Python editing mode." t)
  (setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
  (setq interpreter-mode-alist (cons '("python" . python-mode)
				     interpreter-mode-alist)))
(add-hook 'python-mode-hook 'company-mode)
(add-hook 'python-mode-hook
	  (lambda () (auto-complete-mode -1)))

(require-package 'lsp-pyright)
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
			 (require 'lsp-pyright)
			 (lsp-deferred))))
(setq lsp-log-io t)
(setq lsp-pyright-use-library-code-for-types t)
(setq lsp-pyright-diagnostic-mode "workspace")
(lsp-register-client
  (make-lsp-client
    :new-connection (lsp-tramp-connection (lambda ()
                                    (cons "pyright-langserver"
                                          lsp-pyright-langserver-command-args)))
    :major-modes '(python-mode)
    :remote? t
    :server-id 'pyright-remote
    :multi-root t
    :initialization-options (lambda () (ht-merge (lsp-configuration-section "pyright")
                                                 (lsp-configuration-section "python")))
    :initialized-fn (lambda (workspace)
                      (with-lsp-workspace workspace
                        (lsp--set-configuration
                        (ht-merge (lsp-configuration-section "pyright")
                                  (lsp-configuration-section "python")))))
    :download-server-fn (lambda (_client callback error-callback _update?)
                          (lsp-package-ensure 'pyright callback error-callback))
    :notification-handlers (lsp-ht ("pyright/beginProgress" 'lsp-pyright--begin-progress-callback)
                                  ("pyright/reportProgress" 'lsp-pyright--report-progress-callback)
                                  ("pyright/endProgress" 'lsp-pyright--end-progress-callback))))

;; ein(emacs ipython notebook)
(require-package 'ein)
(require 'ein)

;; ob-ipython
(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"))

(require-package 'ob-ipython)
(require 'ob-ipython)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((ipython . t)
   ;; other languages..
   ))

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
(require-package 'rust-mode)
(use-package rust-mode
  :ensure t
  :custom rust-format-on-save t)

(require-package 'cargo)
(use-package cargo
  :ensure t
  :hook (rust-mode . cargo-minor-mode))

(lsp-register-client
 (make-lsp-client
  :new-connection (lsp-tramp-connection "rust-analyzer")
  :major-modes '(rust-mode rustic-mode)
  :multi-root t
  :remote? t
  :add-on? t
  ;; :priority 1
  :initialization-options 'lsp-rust-analyzer--make-init-options
  :action-handlers (ht ("rust-analyzer.runSingle" #'lsp-rust--analyzer-run-single))
  :ignore-messages nil
  :server-id 'rust-analyzer-docker))


;; golang
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
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'go-mode-hook 'company-mode))
(add-hook 'go-mode-hook 'lsp-mode-init)

(add-hook 'go-mode-hook (lambda () (auto-complete-mode -1)))

(add-hook 'go-mode-hook #'lsp-deferred)
(with-eval-after-load 'lsp-mode
  (setq lsp-enable-snippet nil))

(lsp-register-custom-settings
 '(("gopls.completeUnimported" t t)
   ("gopls.staticcheck" t t)))

(lsp-register-client
 (make-lsp-client
  :new-connection (lsp-tramp-connection "gopls")
  :major-modes '(go-mode)
  :multi-root t
  :remote? t
  :add-on? t
  ;; :priority 1
  :ignore-messages nil
  :server-id 'gopls-docker))


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

;; (use-package web-mode
;;   :init
;;   (add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))
;;   (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))

;;   :config
;;   (setq web-mode-attr-indent-offset nil)

;;   (setq web-mode-enable-auto-closing t)
;;   (setq web-mode-enable-auto-pairing t)

;;   (setq web-mode-auto-close-style 2)
;;   (setq web-mode-tag-auto-close-style 2)


;;   (setq web-mode-markup-indent-offset 2)
;;   (setq web-mode-css-indent-offset 2)
;;   (setq web-mode-code-indent-offset 2)

;;   (setq indent-tabs-mode nil)
;;   (setq tab-width 2)
;;   )


(require-package 'typescript-mode)
(require 'typescript-mode)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
(add-hook 'typescript-mode-hook #'lsp)
;; (require-package 'tide)
;; (require 'tide)
;; (add-hook 'typescript-mode-hook
;; 	  (lambda ()
;; 	    (tide-setup)
;; 	    (flycheck-mode t)
;; 	    (setq flycheck-check-syntax-automatically '(save mode-enabled))
;; 	    (eldoc-mode t)
;; 	    (company-mode-on)))
(setq typescript-indent-level 2)

(lsp-register-client
 (make-lsp-client
 :new-connection (lsp-tramp-connection (list "typescript-language-server" "--stdio"))
 :major-modes '(typescript-mode)
 :remote? t
 :server-id 'ts-remote
 :multi-root t ))
 
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration
    '(typescript-mode . "typescript")))

(setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs helm-lsp projectile hydra flycheck company avy which-key helm-xref dap-mode zenburn-theme json-mode))
(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))
(load-theme 'zenburn t)
;; (helm-mode)
;; (require 'helm-xref)
;; (define-key global-map [remap find-file] #'helm-find-files)
;; (define-key global-map [remap execute-extended-command] #'helm-M-x)
;; (define-key global-map [remap switch-to-buffer] #'helm-mini)
(which-key-mode)
(add-hook 'prog-mode-hook #'lsp)
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      create-lockfiles nil) ;; lock files will kill `npm start'
(with-eval-after-load 'lsp-mode
  (require 'dap-chrome)
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (yas-global-mode))


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


;; ;; scala
;; ;; Install use-package if not already installed
;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package))
;; 
;; (require-package 'use-package)
;; (require 'use-package)
;; (require-package 'spinner)
;; (require 'spinner)
;; 
;; ;; Enable defer and ensure by default for use-package
;; ;; Keep auto-save/backup files separate from source code:  https://github.com/scalameta/metals/issues/1027
;; (setq use-package-always-defer t
;;       use-package-always-ensure t
;;       backup-directory-alist `((".*" . ,temporary-file-directory))
;;       auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
;; 
;; ;; Enable scala-mode and sbt-mode
;; (require-package 'scala-mode)
;; (use-package scala-mode
;;   :mode "\\.s\\(cala\\|bt\\)$")
;; 
;; (require-package 'sbt-mode)
;; (use-package sbt-mode
;;   :commands sbt-start sbt-command
;;   :config
;;   ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
;;   ;; allows using SPACE when in the minibuffer
;;   (substitute-key-definition
;;    'minibuffer-complete-word
;;    'self-insert-command
;;    minibuffer-local-completion-map)
;;    ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
;;    (setq sbt:program-options '("-Dsbt.supershell=false"))
;; )
;; 
;; ;; Enable nice rendering of diagnostics like compile errors.
;; (use-package flycheck
;;   :init (global-flycheck-mode))
;; 
;; (require-package 'lsp-mode)
;; (require 'lsp-mode)
;; (use-package lsp-mode
;;   ;; Optional - enable lsp-mode automatically in scala files
;;   :hook
;;   (scala-mode . lsp)
;;   (lsp-managed-mode . (lambda () (setq-local company-backends '(company-capf))))
;;   :config (setq lsp-prefer-flymake nil))
;; 
;; (require-package 'lsp-ui)
;; (use-package lsp-ui)
;; 
;; ;; lsp-mode supports snippets, but in order for them to work you need to use yasnippet
;; ;; If you don't want to use snippets set lsp-enable-snippet to nil in your lsp-mode settings
;; ;;   to avoid odd behavior with snippets and indentation
;; (use-package yasnippet)
;; 
;; (require 'scala-bootstrap)
;; (require-package 'lsp-mode)
;; (require 'lsp-mode)
;; 
;; (add-hook 'scala-mode-hook
;;           '(lambda ()
;;              (scala-bootstrap:with-metals-installed
;;               (scala-bootstrap:with-bloop-server-started
;;                (lsp)))))

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
(require-package 'lsp-julia)
(require 'lsp-julia)


;; ;; php
;; (require-package 'php-mode)
;; (use-package phpunit
;;   :ensure t)
;; (provide 'long-php)
;; (require-package 'lsp-mode)
;; (use-package lsp-mode
;;   :config
;;   (setq lsp-prefer-flymake nil)
;;   :hook (php-mode . lsp)
;;   :commands lsp)

;; SQL
(require-package 'cl-lib)
(require 'cl-lib)
(require-package 'sql-indent)
(require 'sql-indent)
(add-hook 'sql-mode-hook 'company-mode)
(eval-after-load "sql"
  '(load-library "sql-indent"))
;; Update indentation rules, select, insert, delete and update keywords
;; are aligned with the clause start

(defvar my-sql-indentation-offsets-alist
  `((select-clause 0)
    (select-column ++)
    (select-table ++)
    (select-table-continuation ++)
    (insert-clause 0)
    (delete-clause 0)
    (update-clause 0)
    ;; (in-select-clause sqlind-lineup-to-clause-end)
    ;; (in-insert-clause sqlind-lineup-to-clause-end)
    ;; (in-delete-clause sqlind-lineup-to-clause-end)
    ;; (in-update-clause sqlind-lineup-to-clause-end)
    (in-select-clause ++)
    (in-insert-clause ++)
    (in-delete-clause ++)
    (in-update-clause ++)
    ,@sqlind-default-indentation-offsets-alist))

(add-hook 'sqlind-minor-mode-hook
    (lambda ()
       (setq sqlind-indentation-offsets-alist
             my-sql-indentation-offsets-alist)))
(defconst sql-completions
  '(
    "all"
    "and"
    "any"
    "array"
    "as"
    "asc"
    "assert_rows_modified"
    "at"
    "between"
    "by"
    "case"
    "cast"
    "collate"
    "contains"
    "create"
    "cross"
    "cube"
    "current"
    "default"
    "define"
    "desc"
    "distinct"
    "else"
    "end"
    "enum"
    "escape"
    "except"
    "exclude"
    "exists"
    "extract"
    "false"
    "fetch"
    "following"
    "for"
    "from"
    "full"
    "group"
    "grouping"
    "groups"
    "hash"
    "having"
    "if"
    "ignore"
    "in"
    "inner"
    "intersect"
    "interval"
    "into"
    "is"
    "join"
    "lateral"
    "left"
    "like"
    "limit"
    "lookup"
    "merge"
    "natural"
    "new"
    "no"
    "not"
    "null"
    "nulls"
    "of"
    "on"
    "or"
    "order"
    "outer"
    "over"
    "partition"
    "preceding"
    "proto"
    "range"
    "recursive"
    "respect"
    "right"
    "rollup"
    "rows"
    "select"
    "set"
    "some"
    "struct"
    "tablesample"
    "then"
    "to"
    "treat"
    "true"
    "unbounded"
    "union"
    "unnest"
    "using"
    "when"
    "where"
    "window"
    "with"
    "within"
    "any_value"
    "array_agg"
    "array_concat_agg"
    "avg"
    "bit_and"
    "bit_or"
    "bit_xor"
    "count"
    "countif"
    "logical_and"
    "logical_or"
    "max"
    "min"
    "string_agg"
    "sum"
    "corr"
    "covar_pop"
    "covar_samp"
    "stddev_pop"
    "stddev_samp"
    "stddev"
    "var_pop"
    "var_samp"
    "variance"
    "approx_count_distinct"
    "approx_quantiles"
    "approx_top_count"
    "approx_top_sum"
    "hll_count.init"
    "hll_count.merge"
    "hll_count.merge_partial"
    "hll_count.extract"
    "rank"
    "dense_rank"
    "percent_rank"
    "cume_dist"
    "ntile"
    "row_number"
    "bit_count"
    "abs"
    "sign"
    "is_inf"
    "is_nan"
    "ieee_divide"
    "rand"
    "sqrt"
    "pow"
    "power"
    "exp"
    "ln"
    "log"
    "greatest"
    "least"
    "div"
    "safe_divide"
    "safe_multiply"
    "safe_negate"
    "safe_add"
    "safe_subtract"
    "mod"
    "round"
    "trunc"
    "ceil"
    "ceiling"
    "floor"
    "cos"
    "cosh"
    "acos"
    "acosh"
    "sin"
    "sinh"
    "asin"
    "asinh"
    "tan"
    "tanh"
    "atan"
    "atanh"
    "range_bucket"
    "first_value"
    "last_value"
    "nth_value"
    "lead"
    "lag"
    "percentile_cont"
    "percentile_disc"
    "farm_fingerprint"
    "byte_length"
    "char_length"
    "character_length"
    "code_points_to_bytes"
    "code_points_to_string"
    "concat"
    "ends_with"
    "format"
    "from_hex"
    "length"
    "lpad"
    "lower"
    "ltrim"
    "normalize"
    "normalize_and_casefold"
    "regexp_contains"
    "regexp_extract"
    "regexp_extract_all"
    "regexp_replace"
    "replace"
    "repeat"
    "reverse"
    "rpad"
    "rtrim"
    "safe_convert_bytes_to_string"
    "split"
    "starts_with"
    "strpos"
    "substr"
    "to_code_points"
    "to_hex"
    "trim"
    "upper"
    "to_json_string"
    "array"
    "array_concat"
    "array_length"
    "array_to_string"
    "generate_array"
    "generate_date_array"
    "generate_timestamp_array"
    "array_reverse"
    "current_date"
    "extract"
    "date"
    "date_add"
    "date_sub"
    "date_diff"
    "date_trunc"
    "date_from_unix_date"
    "format_date"
    "parse_date"
    "unix_date"
    "current_datetime"
    "datetime"
    "datetime_add"
    "datetime_sub"
    "datetime_diff"
    "datetime_trunc"
    "format_datetime"
    "parse_datetime"
    "current_time"
    "time"
    "time_add"
    "time_sub"
    "time_diff"
    "time_trunc"
    "format_time"
    "parse_time"
    "current_timestamp"
    "extract"
    "string"
    "timestamp"
    "timestamp_add"
    "timestamp_sub"
    "timestamp_diff"
    "timestamp_trunc"
    "format_timestamp"
    "parse_timestamp"
    "timestamp_seconds"
    "timestamp_millis"
    "timestamp_micros"
    "unix_seconds"
    "unix_millis"
    "unix_micros"
    "st_geogpoint"
    "st_makeline"
    "st_makepolygon"
    "st_makepolygonoriented"
    "st_geogfromgeojson"
    "st_geogfromtext"
    "st_geogfromwkb"
    "st_geogpointfromgeohash"
    "st_asgeojson"
    "st_astext"
    "st_geohash"
    "st_asbinary"
    "st_boundary"
    "st_centroid"
    "st_closestpoint"
    "st_difference"
    "st_intersection"
    "st_snaptogrid"
    "st_union"
    "st_x"
    "st_y"
    "st_contains"
    "st_coveredby"
    "st_covers"
    "st_disjoint"
    "st_dwithin"
    "st_equals"
    "st_intersects"
    "st_intersectsbox"
    "st_touches"
    "st_within"
    "st_isempty"
    "st_iscollection"
    "st_dimension"
    "st_numpoints"
    "st_area"
    "st_distance"
    "st_length"
    "st_maxdistance"
    "st_perimeter"
    "st_union_agg"
    "st_centroid_agg"
    "session_user"
    "generate_uuid"
    "net.ip_from_string"
    "net.safe_ip_from_string"
    "net.ip_to_string"
    "net.ip_net_mask"
    "net.ip_trunc"
    "net.host"
    "net.public_suffix"
    "net.reg_domain"
    "error"
    ))

(defun company-sql-backend (command &optional arg &rest ignored)
  (interactive (list 'interactive))

  (cl-case command
    (interactive (company-begin-backend 'company-sql-backend))
    (prefix (and (eq major-mode 'sql-mode)
                (company-grab-symbol)))
    (candidates
    (cl-remove-if-not
      (lambda (c) (string-prefix-p arg c))
      sql-completions))))

(add-to-list 'company-backends 'company-sql-backend)

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

;; terraform
(require-package 'terraform-mode)
(require 'terraform-mode)
(add-to-list 'lsp-language-id-configuration '(terraform-mode . "terraform"))

(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection
				   '("/usr/bin/terraform-ls" "serve"))
                  :major-modes '(terraform-mode)
                  :server-id 'terraform-ls))
(add-hook 'terraform-mode-hook #'lsp)
(require-package 'company-terraform)
(require 'company-terraform)
(company-terraform-init)
(add-hook 'terraform-mode-hook #'terraform-format-on-save-mode)

;; lean4-mode
(use-package lean4-mode
  :straight (lean4-mode
	     :type git
	     :host github
	     :repo "leanprover/lean4-mode"
	     :files ("*.el" "data"))
  ;; to defer loading the package until required
  :commands (lean4-mode))
(lsp-register-client
 (make-lsp-client
  :new-connection (lsp-tramp-connection '("lake" "serve"))
  :major-modes '(lean4-mode)
  :multi-root t
  :remote? t
  :add-on? t
  :server-id 'lean4-docker))
(setq lean4-rootdir "/docker:calculus:/home/.elan")
(add-to-list 'exec-path "/docker:calculus:/home/.elan/bin")

;; (add-to-list 'auto-mode-alist '("\\.lean$" . lean4-mode))

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
      (lambda (&optional arg) "keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([18 105 109 112 111 114 116 return 67108896 67108896 67108896 5 23 134217788 return 16 25 21 67108896 21 67108896] 0 "%d")) arg)))
;; frompy
(fset 'frompy
      (lambda (&optional arg) "keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([18 102 114 111 109 return 67108896 67108896 67108896 5 5 23 134217788 return 16 25 21 67108896 21 67108896] 0 "%d")) arg)))


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
 '(ansi-color-names-vector
   ["#3f3f3f" "#cc9393" "#7f9f7f" "#f0dfaf" "#8cd0d3" "#dc8cc3" "#93e0e3" "#dcdccc"])
 '(company-quickhelp-color-background "#4f4f4f")
 '(company-quickhelp-color-foreground "#dcdccc")
 '(custom-enabled-themes '(manoj-dark))
 '(fci-rule-color "#383838")
 '(nrepl-message-colors
   '("#cc9393" "#dfaf8f" "#f0dfaf" "#7f9f7f" "#bfebbf" "#93e0e3" "#94bff3" "#dc8cc3"))
 '(package-selected-packages
   '(phpunint php-mode highlight-indentation yaml-mode lsp-ui sbt-mode scala-mode julia-mode ess eglot lsp-mode rjsx-mode vue-mode web-mode tide typescript-mode js2-mode rustic spinner py-autopep8 go-eldoc py-isort py-yapf go-autocomplete auto-complete-auctex company-tern company-racer racer toml-mode company-go go-mode company-jedi flycheck-rust rust-mode company-irony irony ddskk markdown-mode jedi-direx python-mode jedi flymake-python-pyflakes flymake-cursor auto-virtualenvwrapper))
 '(pdf-view-midnight-colors '("#dcdccc" . "#383838"))
 '(rustic-format-display-method 'pop-to-buffer-without-switch)
 '(vc-annotate-background "#2b2b2b")
 '(vc-annotate-color-map
   '((20 . "#bc8383")
     (40 . "#cc9393")
     (60 . "#dfaf8f")
     (80 . "#d0bf8f")
     (100 . "#e0cf9f")
     (120 . "#f0dfaf")
     (140 . "#5f7f5f")
     (160 . "#7f9f7f")
     (180 . "#8fb28f")
     (200 . "#9fc59f")
     (220 . "#afd8af")
     (240 . "#bfebbf")
     (260 . "#93e0e3")
     (280 . "#6ca0a3")
     (300 . "#7cb8bb")

     (340 . "#94bff3")
     (360 . "#dc8cc3")))
 '(vc-annotate-very-old-color "#dc8cc3")
 '(warning-suppress-log-types '((lsp-mode)))
 '(warning-suppress-types '((use-package))))
(put 'set-goal-column 'disabled nil)
(put 'downcase-region 'disabled nil)


(profiler-report)
(profiler-stop)
