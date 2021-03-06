(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
	("melpa" . "https://melpa.org/packages/")
	("org" . "http://orgmode.org/elpa/")))
(package-initialize)

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
(require-package 'company)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; company-mode
;; (add-hook 'after-init-hook 'global-company-mode)
(require-package 'flycheck)
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
(require-package 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(setq ac-use-menu-map t)
(setq ac-use-fuzzy t)
(setq ac-delay 0)
(setq ac-auto-show-menu 0.05)

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

;; ;; slime
(load (expand-file-name "~/.roswell/helper.el"))
;; (setq inferior-lisp-program "clisp")
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/slime"))
;; (require 'slime)
;; (slime-setup '(slime-repl slime-fancy slime-banner))

;; ;; geiser
(require-package 'geiser)
(load-file "~/.emacs.d/elpa/geiser-20200103.1329/geiser.el")
(setq geiser-active-implementations '(racket))

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

;; ;; company-jedi settings
;; (require 'jedi-core)
;; (setq jedi:complete-on-dot t)
;; (setq jedi:use-shortcuts t)
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (add-to-list 'company-backends 'company-jedi)

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

;; golang
(add-to-list 'exec-path (expand-file-name "/usr/lib/go-1.10/bin"))
(add-to-list 'exec-path (expand-file-name "~/go/bin"))
(require-package 'go-mode)
(require 'go-mode)
(require-package 'go-autocomplete)

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
(require-package 'go-eldoc)
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
    (rjsx-mode vue-mode web-mode tide typescript-mode py-autopep8 go-eldoc py-isort py-yapf go-autocomplete auto-complete-auctex company-tern company-racer racer toml-mode company-go go-mode company-jedi flycheck-rust rust-mode company-irony irony ddskk markdown-mode jedi-direx python-mode jedi flymake-python-pyflakes flymake-cursor auto-virtualenvwrapper))))

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
(require-package 'tide)
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
(require-package 'web-mode)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; vue-mode
(require-package 'vue-mode)
(require 'vue-mode)
(require 'flycheck)
(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
(eval-after-load 'vue-mode
  '(add-hook 'vue-mode-hook #'add-node-modules-path))
(flycheck-add-mode 'javascript-eslint 'vue-mode)
(flycheck-add-mode 'javascript-eslint 'vue-html-mode)
(flycheck-add-mode 'javascript-eslint 'css-mode)
(add-hook 'vue-mode-hook 'flycheck-mode)

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
