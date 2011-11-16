;; Help 帮助
;; C-h f 查看某个函数的文档
;; C-h v 查看某个变量的文档
;; C-h a 使用正则表达式来查找命令
;; C-h k 描述我接下来的键入动作
;; C-h l 显示最近的 100 个键入动作
;; C-h m 描述当前的 mode
;; C-h i 查看 info 文档

;; 打开文件 补全 / buffer 切换补全（buffer 补全还有 iswithb）

(require 'ido)
(ido-mode t)

;; 屏蔽 C - <Space>，启用输入法
(global-set-key (kbd "C-SPC") 'nil)

;; ;; 重启 emacs M-x ibus-enable即可
;; (require 'ibus)

;; ;; Turn on ibus-mode automatically after loading .emacs
;; (add-hook 'after-init-hook 'ibus-mode-on)

;; ;; Use C-SPC for Set Mark command
;; (ibus-define-common-key ?\C-\s nil)

;; ;; Use C-/ for Undo command
;; (ibus-define-common-key ?\C-/ nil)

;; ;; Change cursor color depending on IBus status
;; (setq ibus-cursor-color '("red" "blue" "limegreen"))

;; ;; Use s-SPC to toggle input status
;; (global-set-key (kbd "s-SPC") 'ibus-toggle)


; 设置打开文件的缺省路径
;(setq default-directory "~/")

; 关闭启动提示
(setq inhibit-startup-message t)

; 关闭 出错 提示声
;(setq visible-bell t)

;; 关闭 默认 scratch buffer 提示信息
(setq initial-scratch-message nil)

; 打开图片显示功能
;(auto-image-file-mode t)
(setq auto-image-file-mode t)

; 自动保存模式
(setq auto-save-mode nil)

; 编辑文件时，不将源文件备份为 ~filename
(setq-default make-backup-files 'nil)

;;查找时严格区分大小写
;;(setq case-fold-search nil)

; 在行首 C-k 时，同时删除该行
(setq-default kill-whole-line t)

; 不在鼠标点击的那个地方插入剪贴板内容
(setq mouse-yank-at-point t)

;;自动重载更改的文件
(global-auto-revert-mode 1)

; 当光标在行尾上下移动的时候，始终保持在行尾
(setq track-eol t)

;;当鼠标移动的时候自动转换frame，window或者minibuffer
(setq mouse-autoselect-window t)

; 语法高亮
(global-font-lock-mode t)

; 隐藏工具栏
;(tool-bar-mode 'nil)
; 不要menu-bar和tool-bar
;(menu-bar-mode -1)

; GUI 下显示 Toolbar 的话 select-buffer 会出问题
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))

; 隐藏滚动条，可以使用鼠标滚轮
(scroll-bar-mode 'nil)

; 显示列号
;(column-number-mode t)
(setq column-number-mode t)

; 显示行号
(setq line-number-mode t)
(global-linum-mode t)

; 取消光标闪烁
(blink-cursor-mode -1)

; 光标颜色
;(set-cursor-color "green")

; 默认显示 80列，之后换行
(setq default-fill-column 100)

;; 自动换行 From：sm-base
(toggle-truncate-lines t)

; 高亮选择区域
(transient-mark-mode t)

;;高亮当前所在行，使用 Emacs 默认的高亮色
;;若要与主题一致参考 http://ann77.emacser.com/Emacs/EmacsHighlightLine.html
(global-hl-line-mode 1)
;;或者
;(require 'hl-line)
;(hl-line-mode 1)

; 光标靠近鼠标指针时，让鼠标指针自动让开
;(mouse-avoidance-mode 'animate)

;;是用滚轴鼠标
(mouse-wheel-mode t)
;;滚动页面时比较舒服，不要整页的滚动
(setq scroll-step 1
  scroll-margin 3
  scroll-conservatively 10000)


(put 'upcase-region 'disabled nil)

;; 默认 Emacs 里 M-w 不能复制内容到系统的剪切板
;; 如果需要让 M-w 复制内容到剪切板
(setq x-select-enable-clipboard t)

;; http://blog.waterlin.org/articles/emacs-adjust-window-size-position.html
;; 设置 emacs 窗口 “大小尺寸” "位置"
;; linux / windows 通用
(setq default-frame-alist
'((top . 42)
(left . 42)
(height . 36)
(width . 120)
(menu-bar-lines . 20)
;(tool-bar-lines . 20)
;(background-color . “rgb:00/00/00″)
;(foreground-color . “rgb:ff/ff/ff”)
;(font . “Monospace-11″)
;(cursor-type . bar)
))

;; 保存退出文件时的当前位置，编辑比较长的文档
;(require ‘saveplace)
;(setq-default save-place t)

;; 默认 mode fundamental-mode 改为：text-mode
(setq default-major-mode 'text-mode)

;; 即使 LC_CTYPE=zh_CN.UTF-8 仍定义 emacs 默认语音为 English
;; 避免帮助文档变为 中文
(set-language-environment 'English)

;; 对于同名 buffer 引用父目录来区分
;; http://lifegoo.pluskid.org/wiki/EmacsTip.html
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; http://www.emacswiki.org/emacs/HideShow
;; http://article.yeeyan.org/view/179850/185790
;; M-x hs-minor-mode 激活之后，menu 出现 [Hide/Show] 菜单
;; 进入下面的 mode 时自动开启自带的 hide show mode 折叠
(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)

;; 定义 F1 开关折叠函数
(global-set-key [f1] 'hs-toggle-hiding)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
