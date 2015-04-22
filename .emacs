; (add-to-list 'default-frame-alist '(height . 24))
;; (add-to-list 'default-frame-alist '(width . 80))
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(tool-bar-mode -1)
(scroll-bar-mode -1)

(require 'package)


(defvar local-packages '(magit autocomplete jedi key-chord
			       evil projectile hlinum ample-zen-theme
			       AUCTeX neotree
			       websocket request markdown-mode ein python-mode
			       ))

(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; (dolist (p local-packages)
;;  (when (not (package-installed-p p))
;;      (package-install p)))



;; (require 'tree-mode)
;; (require 'windata)
;; (require 'dirtree)
;; (global-set-key [f8] 'dirtree-show)






(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-window-width 28)
 (add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "l") 'neotree-enter)
              (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
              (define-key evil-normal-state-local-map (kbd "h") 'neotree-hidden-file-toggle)
              (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-change-root)
              (define-key evil-normal-state-local-map (kbd "d") 'neotree-delete-node)
              (define-key evil-normal-state-local-map (kbd "r") 'neotree-rename-node)
              (define-key evil-normal-state-local-map (kbd "n") 'neotree-create-node)
              (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))

(require 'auto-complete-config)
(ac-config-default)

(require 'jedi)
;; Hook up to autocomplete
(add-to-list 'ac-sources 'ac-source-jedi-direct)
;; Enable for python-mode
(add-hook 'python-mode-hook 'jedi:setup)

;; (require 'projectile)
;; (projectile-global-mode)


(require 'ein)
(setq ein:use-auto-complete t)
(add-hook 'ein:connect-mode-hook 'ein:jedi-setup)

(require 'evil)
(evil-mode 1)

(require 'hlinum)
(hlinum-activate)


(require 'key-chord)
(key-chord-mode 1)
(key-chord-define evil-insert-state-map  "jj" 'evil-normal-state)
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)



(set-face-attribute 'default nil
		    :family "Bitstream Vera Sans Mono"
		    ;; :height 150
		    :weight 'bold
		    ;; :foreground "grey10")
		    ;:family "Inconsolata" :height 140
		    )
(set-face-attribute 'font-lock-comment-face nil
		    :family "Inconsolata"
		    ;; :height 150
		    :slant 'italic
		    ;; :background "#eeeeff" :foreground "#545454"
		    )
(set-face-attribute 'font-lock-string-face nil
		    :family "Bitstream Vera Sans Mono"
		    ;; :height 150
		    :weight 'normal
		    ;; :foreground "#006400" :background 'unspecified
		    )

(global-visual-line-mode 1); Proper line wrapping
(global-hl-line-mode 1); Highlight current row
(show-paren-mode 1); Matches parentheses and such in every mode
(set-fringe-mode '(0 . 0)); Disable fringe because I use visual-line-mode
(setq visible-bell t); Flashes on error
;; (set-face-background hl-line-face "light cyan") 

(load-theme 'ample-zen t)
(global-linum-mode t)
(setq show-paren-delay 0)
;; (windmove-default-keybindings)
;; (setq org-replace-disputed-keys t)
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

(defun add-py-debug ()  
      "add debug code and move line down"  
    (interactive)  
   (back-to-indentation)
  ;; this preserves the correct indentation in case the line above
  ;; point is a nested block
  (split-line)   ;; (move-beginning-of-line 1)  
    (insert "import ipdb; ipdb.set_trace();")  
    (highlight-lines-matching-regexp "^[ ]*import ipdb; ipdb.set_trace()"))

(define-key evil-normal-state-map (kbd "<f9>") 'add-py-debug)
 
(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)

(define-key input-decode-map [?\C-i] [C-i])
(global-set-key (kbd "<C-i>") 'indent-region)

(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args ""
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")


;;; AUCTeX
;; Customary Customization, p. 1 and 16 in the manual, and http://www.emacswiki.org/emacs/AUCTeX#toc2
(setq TeX-parse-self t); Enable parse on load.
(setq TeX-auto-save t); Enable parse on save.
(setq-default TeX-master nil)

(setq TeX-PDF-mode t); PDF mode (rather than DVI-mode)








(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
