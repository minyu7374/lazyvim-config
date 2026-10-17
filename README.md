# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## 分屏导航

使用 smart-splits v3 的 Kitty、tmux 后端，保留 Ctrl+h/j/k/l 导航、Alt+h/j/k/l 缩放和 Ctrl+反斜线返回上一个窗口。
Kitty 配套配置在同级 `kitty` 仓库；普通 Vim 和另一套 Neovim 配置在同级 `vimrc` 仓库。
Herdr 使用共享本地后端，先在同级 Kitty 仓库执行 `bash herdr/install.sh`，再重启 Neovim。
安装和验证说明见 `../kitty/herdr/smart-splits/README.md`；`dot_conf/` 保存相应的 Kitty/tmux 配置片段。
