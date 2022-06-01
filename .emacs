;; Tab settings
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default c-basic-offset 2)

;; Show line numbers
(global-linum-mode t)

;; Set color theme
(load-theme 'manoj-dark)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes '(tango-dark))
 '(package-selected-packages
   '(company flycheck-color-mode-line web-mode tide typescript-mode yaml-mode flycheck fireplace js2-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; mouse commands
(require 'mouse)
(xterm-mouse-mode t)

;; line by line scrolling with mouse and keyboard
;; Thanks to https://www.emacswiki.org/emacs/SmoothScrolling
(setq-default scroll-step 1)
(setq-default mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq-default mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq-default mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-conservatively 1000 scroll-preserve-screen-position 1) ;; extra smooth scrolling to avoid random jumps


;; ~~NJ modifications on CS107 config~~ ;;

;; Enable scrolling; wasn't working with above settings for some reason
(global-set-key [mouse-4] 'scroll-down-line)
(global-set-key [mouse-5] 'scroll-up-line)

;; Enable whitespace highlighting for any file (from CS107 Advanced Emacs Features)
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(setq whitespace-line-column 100) ;; Or whatever other column number.
(global-whitespace-mode t)

;; Tell Emacs where you want it to look to install packages (from CS107 Advanced Emacs Features)
(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


;; Random from somewhere... but workssss!!!
;; Need to tidy this the fuck up :P
(setq-default
    standard-indent 2
    tab-width 2
    indent-tabs-mode nil
    js-indent-level 2
    js2-basic-offset 2
    js2-strict-semi-warning nil
    js2-missing-semi-one-line-override nil
    web-mode-markup-indent-offset 2
    web-mode-css-indent-offset 2
    web-mode-code-indent-offset 2
    web-mode-indent-style 2
  )

;; Most excellent closing brace adding thing (for C files only)
;; (From CS107 Advanced Emacs Features)
(add-hook 'c-mode-common-hook 'electric-pair-mode)


;; (From CS107 Advanced Emacs Features)
;; "Automatically Check For Compiler Issues with Flycheck:
;; Instead of waiting for your compiler to tell you when you're writing code
;; that will emit warnings from the compiler, you can have this feedback come
;; while you're editing your program. To do so, first install the flycheck
;; package using the package list above. Once you've done this, then also add
;; the following at the end of your .emacs file:"
;; (global-flycheck-mode)
;; (add-hook 'c-mode-common-hook
;;      (lambda () (setq flycheck-gcc-language-standard "c++11")))
;; "From now on, when you are editing a C file, you'll see feedback as you type.
;; Specifically, look for code bolded and underlined, and navigate your cursor
;; over that content and wait a few seconds to see the issue message pop up
;; in the Emacs console at the bottom."

(add-hook 'yaml-mode-hook
          (lambda ()
            (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; format
(setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))


;; tsx
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
;; enable typescript-tslint checker
;; (package-install 'flycheck)
;; (global-flycheck-mode)
(require 'flycheck)
 (flycheck-add-mode 'typescript-tslint 'web-mode)

(define-generic-mode 'vimrc-generic-mode
    '()
    '()
    '(("^[\t ]*:?\\(!\\|ab\\|map\\|unmap\\)[^\r\n\"]*\"[^\r\n\"]*\\(\"[^\r\n\"]*\"[^\r\n\"]*\\)*$"
       (0 font-lock-warning-face))
      ("\\(^\\|[\t ]\\)\\(\".*\\)$"
      (2 font-lock-comment-face))
      ("\"\\([^\n\r\"\\]\\|\\.\\)*\""
       (0 font-lock-string-face)))
    '("/vimrc\\'" "\\.vim\\(rc\\)?\\'")
    '((lambda ()
        (modify-syntax-entry ?\" ".")))
    "Generic mode for Vim configuration files.")
