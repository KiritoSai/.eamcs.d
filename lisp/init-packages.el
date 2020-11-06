;;中文社区镜像
;; (when (>= emacs-major-version 24)
;;   (require 'package)
;;   (package-initialize)
;;   (setq package-archives '(("gnu" ."http://elpa.emacs-china.org/gnu/")
;; 			   ("melpa" ."http://elpa.emacs-china.org/melpa/"))))
(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

;;cl-Common Lisp Extension
(require 'cl)
;;Add Packages
(defvar my/packages '(
		      ;;--Auto-completion--
		      company
		      ;;--Better Editor --
		      smooth-scrolling
		      hungry-delete
		      swiper
		      counsel
;;		      hightlight-parenthesis
		      popwin
		      ;;--Major Mode--
		      js2-mode
		      markdown-mode
		      ;;--Minor Mode--
		      nodejs-repl
		      exec-path-from-shell
		      ;;--Themes--
		      monokai-theme
		      ;;solarized-theme
		      ;;
		      flycheck
		      leetcode
		      projectile
		      py-autopep8
		      ycmd
		      youdao-dictionary
		      google-c-style
		      ggtags
		      flycheck-ycmd
		      company-ycmd
		      magit
		      clang-format
		      modern-cpp-font-lock
		      )"Default packages")

(provide 'init-packages)
