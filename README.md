# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## 分屏导航

使用 smart-splits v3 的 Kitty、tmux 后端，保留 Ctrl+h/j/k/l 导航、Alt+h/j/k/l 缩放和 Ctrl+反斜线返回上一个窗口。
Kitty 配套配置在同级 `kitty` 仓库；普通 Vim 和另一套 Neovim 配置在同级 `vimrc` 仓库。
Herdr 使用共享本地后端，先在同级 Kitty 仓库执行 `bash herdr/install.sh`，再重启 Neovim。
安装和验证说明见 `../kitty/herdr/smart-splits/README.md`；`dot_conf/` 保存相应的 Kitty/tmux 配置片段。

## 翻译

使用 [pantran.nvim](https://github.com/potamides/pantran.nvim)，与同级 `vimrc` 保持 `<leader>yt` 键位一致。
本项目使用 Neovim 原生交互面板；`vimrc` 仍使用兼容 Vim 的 `vim-translator`。
需要 Neovim 0.6.1+ 和 curl 7.76.0+，默认使用 Google、自动识别原文语言并译为简体中文。
未配置 Google API 凭据时使用插件内置的 Web 后端。

- 普通模式 `<leader>yt`：翻译光标下的单词。
- 可视模式 `<leader>yt`：翻译选区，支持段落与字符选区。
- `:Pantran`：打开空白交互面板，也可使用选区范围，例如 `:'<,'>Pantran`。
- 面板左右显示原文与译文，可以滚动阅读、编辑原文后自动重新翻译。
- 面板普通模式按 `q` / `Esc` 关闭，`gy` 复制译文并关闭，`g?` 查看帮助。
- 面板插入模式按 `Esc` 返回普通模式，`Ctrl-c` 直接关闭。

更新配置后重启 Neovim，通过 `:Lazy install` 安装新插件；旧的 `vim-translator` 可通过 `:Lazy clean` 清理。
