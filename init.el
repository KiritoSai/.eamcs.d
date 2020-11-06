(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp/")

;;Package Management
;;;------------------------
(require 'init-packages)

(setq package-selected-packages my/packages)

(defun my/packages-installed-p()
  (loop for pkg in my/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))
(unless (my/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg my/packages)
    (when(not (package-installed-p pkg))
      (package-install pkg))))

;;ui
(require 'init-ui)
;;默认开启全屏
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;;自动括号匹配
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;;高亮当前行
(global-hl-line-mode 1)

;;f2打开init file
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") 'open-init-file)
;;补全
(global-company-mode 1)
;;禁止生成备份文件~
(setq make-backup-files nil)
;;禁止生成保存文件
(setq auto-save-default nil)
;;C-x C-r 打开最近的10个文件列表
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)
(global-set-key (kbd "C-x C-r")'recentf-open-files)
;;选中文字被覆盖
(delete-selection-mode 1)
;; ;;org-mode 文笔内语法高亮
;; (require 'org)
;; (setq org-src-fontify-natively t)
;; ;;设置org agenda 文件目录
;; (setq org-agenda-files '("~/org"))
;; ;;设置org-agenda打开快捷键
;; (global-set-key (kbd "C-c a")'org-agenda)

;;自动加载外部修改过的文件
(global-auto-revert-mode 1)

;;popwin关闭弹出的临时buffer
(require 'popwin)
(popwin-mode 1)

;;关闭提示音
(setq ring-bell-function 'ignore)

;;yes/no -> y/n
(fset 'yes-or-no-p 'y-or-n-p)

;;一次缩进全部缓冲区代码
(defun indent-buffer()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer()
  (interactive)
  (save-excursion
    (if (region-active-p)
	(progn
	  (indent-region (region-beginning) (region-end))
	  (message "Indent selected region."))
      (progn
	(indent-buffer)
	(message "Indent buffer.")))))

(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)

;;缩写补全
(setq-default abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(("whr" "wanghaoran")))

;;Hippie补全
(setq hippie-expand-try-functions-list '(try-expand-debbrev
					 try-expand-debbrev-all-buffers
					 try-expand-debbrev-from-kill
					 try-complete-file-name-partially
					 try-complete-file-name
					 try-expand-all-abbrevs
					 try-expand-list
					 try-expand-line
					 try-complete-lisp-symbol-partially
					 try-complete-lisp-symbol))
(global-set-key (kbd "s-/") 'hippie-expand)

;;dired mode唯一缓冲区
(put 'dired-find-alternate-file 'disabled nil)

;;pep8
;; (require 'py-autopep8)
;; (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;;MAGIT
(global-set-key (kbd "C-x g") 'magit-status)

;;set keys for Apple keyboard, for emacs in OSX
;(setq mac-command-modifier "mata")
;(setq mac-option-modifier "super")
(when (eq system-type 'darwin) ;; mac specific settings
(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta))

;; (when (eq system-type 'gnu/linux)
;;   (setq x-super-keysym 'meta)
;;   (setq x-option-keysym 'super)
;;   )

;;(load "leetcode.el")

;;epub reader
;;(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

;;clang-format
(require 'clang-format)
(global-set-key (kbd "C-c i") 'clang-format-region)
(global-set-key (kbd "C-c u") 'clang-format-buffer)
(setq clang-format-style-option "file")

;;设置默认工作目录
(setq default-directory "~/ROVER5.0/")

;;youdao-dictionary
;; Enable Cache
(setq url-automatic-caching t)
;; Example Key binding
(global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point)

;;以root权限修改文件
(defun sudo-edit-current-file ()
  (interactive)
  (when (buffer-file-name)
    (let ((old-point (point)))
      (find-file (concat "/sudo:root@localhost:" (buffer-file-name)))
      (goto-char old-point))))
;;ggtags
;;==================
(require 'ggtags)
;;c,c++,java mode setting
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
	      (ggtags-mode 1))))

;; ;;;;================================================= < for ycmd start >
;; ;;;; To use ycmd-mode in all supported modes
;; (require 'ycmd)
;; (add-hook 'after-init-hook #'global-ycmd-mode)

;; ;;;; Specify only support c/c++ mode
;; ;;(require 'ycmd)
;; ;;(add-hook 'c++-mode-hook 'company-mode)
;; ;;(add-hook 'c++-mode-hook 'ycmd-mode)

;; ;;;; Specify how to run the server
;; (set-variable 'ycmd-server-command '("/usr/bin/python3" "/home/whaoran/ycmd/ycmd"))
;; ;;(set-variable 'ycmd-server-command '("/usr/bin/python" "~/ycmd/ycmd")) ;; Cannot use ~, should use abspath

;; ;;;; Specify a global emacs configuration
;; (set-variable 'ycmd-global-config "/home/whaoran/ycmd/examples/.ycm_extra_conf.py")
;; ;;(set-variable 'ycmd-global-config "~/ycmd/examples/.ycm_extra_conf.py") ;; Cannot use ~, should use abspath

;; ;;;; Completion framework
;; (require 'company-ycmd)
;; (company-ycmd-setup)
;; (add-hook 'after-init-hook #'global-company-mode)

;; ;;;; Enable flycheck-ycmd
;; (require 'flycheck-ycmd)
;; (flycheck-ycmd-setup)
;; (add-hook 'after-init-hook #'global-flycheck-mode)
;; ;;disable cppcheck
;; ;;(setq-default flycheck-disabled-checkers' (c/c++-cppcheck))
;; ;;;; Set always complete immediately
;; (setq company-idle-delay 0)
;; ;;;;================================================== < for ycmd end >

;;括号匹配高亮
;; (require 'highlight-parentheses)
;; (define-globalized-minor-mode global-highlight-parentheses-mode
;;   highlight-parentheses-mode
;;   (lambda()
;;     (highlight-parentheses-mode t)))
;; (global-highlight-parentheses-mode t)

;;语法高亮
(require 'modern-cpp-font-lock)
(modern-c++-font-lock-global-mode t)

;;内置的智能自动补全括号
(require 'electric)
(electric-pair-mode t)
(electric-layout-mode t)

;;projectile
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;;init.el ends here

