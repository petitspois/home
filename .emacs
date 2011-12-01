
;; Time-stamp: "2011-12-01 22:25:33 ink"


;; Help 帮助
;; C-h f 查看 函数 文档
;; C-h v 查看 变量值 和 说明
;; C-h a 使用正则表达式来查找命令
;; C-h k 描述我接下来的键入动作
;; C-h l 显示最近的 100 个键入动作
;; C-h m 描述当前的 mode
;; C-h i 查看 info 文档

;; 目录后面的斜杠不能省略，不能展开子目录
;; http://www.emacswiki.org/emacs/LoadPath
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/plugin/")
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/")
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0/themes/")
(require 'color-theme)
;; color-theme 自带主题，需要添加下面这行
;(color-theme-initialize)
;; M-x color-theme-select 选择后按 d 获取主题配置信息
;(color-theme-charcoal-black)

(load-file "~/.emacs.d/theme/color-theme-almost-monokai.el")
(color-theme-almost-monokai)

;; 取消 mode-line 状态栏 status bar 的 3d shadow 效果
;; http://www.svenhartenstein.de/Software/Emacs
;; http://ldc.usb.ve/docs/emacs/Optional-Mode-Line.html
(set-face-attribute 'mode-line nil :box nil)

;; minibuffer 时间显示格式
(display-time-mode 1)
;;; 时间使用 24小时制
;(setq display-time-24hr-format t)
;;; 时间显示包括日期和具体时间
;(setq display-time-day-and-date t)
;;;; 时间栏旁边启用邮件设置
;;(setq display-time-use-mail-icon t)
;;; 时间的变化频率
;(setq display-time-interval 10)
;;; 显示时间的格式
;(setq display-time-format "[ %H:%M %m月%d日 ]")
;



(add-to-list 'load-path "~/.emacs.d/theme/")
(add-to-list 'load-path "~/.emacs.d/auto-complete/")

;; 通过 "菜单" 修改的配置 将会保存在 custom-file 里
;(setq custom-file "~/.emacs.d/ink-custom.el")

;; 默认 打开文件 缺省路径
;(setq default-directory "~/")

;; 交互式切换补全 打开文件 / buffer 切换 （buffer 交互式补全 iswithb-mode）
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

;; 操作错误 闪屏提示
;(setq visible-bell t)

;; 关闭启动 emacs 默认页面
(setq inhibit-startup-message t)

;; 关闭 默认 scratch buffer 提示信息
(setq initial-scratch-message nil)

;; 打开图片显示功能
(setq auto-image-file-mode t)

;; 自动保存模式，类似版本控制 自动保存，需要定义备份文件夹路径 [可自定义]
(setq auto-save-mode nil)

;; 编辑文件时，不将源文件备份为 ~filename
(setq-default make-backup-files 'nil)

;; 查找时严格区分大小写
;;(setq case-fold-search nil)

;; 在行首 C-k 时，同时删除该行
(setq-default kill-whole-line t)

;; (鼠标中键) 在光标处粘贴，而不是鼠标指针处
(setq mouse-yank-at-point t)

;; 自动重载更改的文件
(global-auto-revert-mode 1)

;; 当光标在行尾上下移动的时候，始终保持在行尾
(setq track-eol t)

;; 鼠标 自动聚焦 frame，window 或 minibuffer
(setq mouse-autoselect-window t)

;; 语法高亮
(global-font-lock-mode t)

;; 隐藏工具栏 M-x tool-bar-mode
;; 使用 C-x C-e 立即执行时，结果不同
;; 值: 一直为空
(tool-bar-mode -1)
;; 值: 正负切换
;;(tool-bar-mode 'nil)

;; 隐藏 menu-bar 和 tool-bar
;(menu-bar-mode -1)
;(menu-bar-mode 0)

;; 隐藏滚动条，可以使用鼠标滚轮
(scroll-bar-mode 'nil)

;; 显示列号
(setq column-number-mode t)

;; 显示行号
;(setq line-number-mode t)
;; 对所有 buffer 全局开启 行号
(global-linum-mode t)

;; 取消光标闪烁
(blink-cursor-mode 0)

;; 光标颜色
;(set-cursor-color "green")

;; FOR :: coding
;; 高亮标记配对的括号
(setq column-number-mode t)

;; 显示 trailing whitespace 空白字符
(setq-default show-trailing-whitespace t)

;; 使用 空格 代替 Tab 缩进
(setq indent-tabs-mode nil)

;; [?] echo-keystrokdes 控制 echo area 回显延时的变量，设为0秒，就永远不回显。设为-1秒，立即回显
(setq echo-keystrokes 0.01)

;; 默认显示 100 列，之后换行
(setq default-fill-column 100)

;; 对于长度超过窗口尺寸的文本行，自动换行
(toggle-truncate-lines t)

;; 高亮选择区域，默认开启
;(transient-mark-mode t)

;; 高亮当前所在行，使用 Emacs 默认的高亮色
;; 若要与主题一致参考 http://ann77.emacser.com/Emacs/EmacsHighlightLine.html
(global-hl-line-mode 1)
;; 或者
;(require 'hl-line)
;(hl-line-mode 1)

;; 光标靠近鼠标指针时，让鼠标指针自动让开
;(mouse-avoidance-mode 'animate)

;; 滚屏时，锁定光标位置
(scroll-lock-mode t)

;; 启用鼠标滚轮
(mouse-wheel-mode t)

;;;; 每次滚动一行，减少跳动，鼠标滚动会变慢 http://www.emacswiki.org/emacs/SmoothScrolling
;;(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
;;(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
;;(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
;;(setq scroll-step 1) ;; keyboard scroll one line at a time

;; Autosave every 500 typed characters
(setq auto-save-interval 500)

;; 平滑滚动：页面步进，页面边距，缓冲行数
(setq scroll-step 1
      scroll-margin 3
      scroll-conservatively 10000)
;; Scroll just one line when hitting bottom of window

;; 允许设置大小写 [?]
;(put 'upcase-region 'disabled nil)
;(put 'downcase-region 'disabled nil)

;; 默认 Emacs 里 M-w 不能复制内容到系统的剪切板
;; 如果需要让 M-w 复制内容到剪切板
(setq x-select-enable-clipboard t)

;; http://blog.waterlin.org/articles/emacs-adjust-window-size-position.html
;; 设置 emacs 窗口 “大小尺寸” "位置"
;; linux / windows 通用
(setq default-frame-alist
'((menu-bar-lines . 20)
(height . 36)
(width . 120)
;(top . 80)
;(left . 80)
;(cursor-type . bar)
;(tool-bar-lines . 20)
;(font . "Monospace-11")
;(background-color . "rgb:00/00/00")
;(foreground-color . "rgb:ff/ff/ff")
))

;; 保存退出文件时的当前位置，编辑比较长的文档
;(require 'saveplace)
;(setq-default save-place t)

;; 默认文本模式是 fundamental-mode 改为：text-mode
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

;; Emacs 21+ 版本支持时间戳：http://www.emacswiki.org/emacs/TimeStamp
;; 自动更新时间戳：在文件的开头 8 行，添加 Time-stamp: <时间戳> 标记
;; 注意：Time-stamp 首字母必须大写，Time-stamp：后面必须有一个空格
;; 使用命令手动更新时间戳：M-x time-stamp
;; 中文参考：http://home.lupaworld.com/home-space-uid-28556-do-blog-id-136002.html
(add-hook 'write-file-hooks 'time-stamp)

;;;; 自定义时间戳 time-stamp 格式
;;;; %:u，更新时用登录 Linux 的用户名替换
;;;; %04y-%02m-%02d，年-月-日 "YYYY-MM-DD"
;;;; %02H:%02M:%02S，时:分:秒 "HH:MM:SS"
;;(setq time-stamp-format
;;          "由 %:u 修改 时间：%04y-%02m-%02d %02H:%02M:%02S"
;;          time-stamp-active t
;;          time-stamp-warn-inactive t)
;;

;;;; 对拷贝的代码块自动重新格式化 http://zhuoqiang.me/a/torture-emacs#sec-5
;;;; 手动格式化：选中代码块，Ctrl-Alt-\
;;(dolist (command '(yank yank-pop))
;;  (eval
;;   `(defadvice ,command (after indent-region activate)
;;      (and (not current-prefix-arg)
;;           (member major-mode
;;                   '(emacs-lisp-mode
;;                     lisp-mode
;;                     scheme-mode
;;                     haskell-mode
;;                     ruby-mode
;;                     python-mode
;;                     c-mode
;;                     c++-mode
;;                     objc-mode
;;                     latex-mode
;;                     js-mode
;;                     plain-tex-mode))
;;           (let ((mark-even-if-inactive transient-mark-mode))
;;             (indent-region (region-beginning) (region-end) nil))))))
;;



;; 使用 内置 buffer-file-name 显示文件路径
;; http://www.emacswiki.org/emacs/DotEmacsChallenge
(setq frame-title-format '(buffer-file-name "%f" ("%b")))

;; 中文 字符 编码 encoding
;; M-x revert-buffer-with-coding-system 指定编码重新读入文件
;; M-x describe-coding-system 查看当前 文件格式 是否和 默认 UTF-8
;; 还可以查看，读取文件使用的编码 顺序
;; C-x <RET> c ( M-x universal-coding-system-argument ) 设置编码，保存文件
;; http://blog.waterlin.org/articles/change-emacs-coding-for-the-current-file.html

;;;; http://blog.waterlin.org/articles/set-emacs-default-coding-system.html
;;;; 只适用于 写文件 set the default text coding system
;;(setq default-buffer-file-coding-system 'utf-8)
;;;; 读取文件使用编码顺序，使用 M-x prefer-coding-system 手动设置
;;(prefer-coding-system 'utf-8)

;; plugins
(add-to-list 'load-path
              "~/.emacs.d/yasnippet")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/yasnippet/snippets")





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



