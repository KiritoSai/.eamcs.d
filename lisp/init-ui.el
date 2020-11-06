;;display time
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)

;;安装主题
(add-to-list 'my/packages 'monokai-theme)
(load-theme 'monokai 1)
;;删除tool bar
(tool-bar-mode -1)
;;删除scroll bar
(scroll-bar-mode -1)
;;显示行号
(global-linum-mode 1)
;;更改光标
;; (setq-default cursor-type 'bar)
;;关闭启动帮助画面
(setq inhibit-splash-screen 1)
;; hide the startup message
(setq inhibit-startup-message t) 
;;字号
(set-face-attribute 'default nil :height 200)

(provide 'init-ui)
