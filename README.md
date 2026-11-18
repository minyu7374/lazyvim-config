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

## AI 编程助手

使用 [agentic.nvim](https://github.com/carlos-algms/agentic.nvim)，默认通过 `codex-acp` 接入 Codex，也可切换到 OpenCode（`opencode acp`）。
Codex ACP 适配器使用当前维护的 `@agentclientprotocol/codex-acp` 包，统一由下方依赖脚本的 `ai` 组安装。
对应 CLI 需要已安装并位于 Neovim 的 PATH 中，登录和模型配置沿用各自 CLI；root 用户下不加载 AI 插件。
Avante 的加载入口及配置已注释保留，未清理已安装目录。

- 普通／可视模式 `<leader>ta`：显示或隐藏聊天面板。
- 普通／可视模式 `<leader>aa`：添加当前文件或选区到聊天上下文。
- `<leader>an`：新建会话；`<leader>ap`：切换 ACP 助手；`<leader>ar`：恢复历史会话（需助手支持）。
- 面板普通模式 `q` 隐藏，`<localleader>m` 切换模型，`<localleader>s` 切换助手，`Shift-Tab` 切换助手支持的模式。
- 输入框中输入 `@` 选择文件、`/` 选择助手提供的命令；普通模式 `Enter` 或 `Ctrl-s` 发送，插入模式用 `Ctrl-s` 发送。
- `:checkhealth agentic`：检查插件及 ACP CLI 状态。

更新配置后重启 Neovim；首次加载由 lazy.nvim 安装 agentic。暂时保留 Avante 时不要执行 `:Lazy clean`。

## 外部工具依赖

Mason 已禁用，插件所需的外部工具和三方库通过 [script/lang_dep.sh](script/lang_dep.sh) 安装。脚本复用现有基础环境，优先使用 pnpm，没有 pnpm 时使用 npm。
按所选分组准备相应的运行时和包管理器：Node.js/npm（或 pnpm）、Rust/Cargo、Go、Python/uv，以及 C 编译器、Git、curl、tar。

```sh
# AI 插件附加依赖：Codex ACP 适配器
bash script/lang_dep.sh ai

# 公共工具：ripgrep、fd、ImageMagick、tree-sitter CLI
bash script/lang_dep.sh neovim

# 也可以组合指定语言分组
bash script/lang_dep.sh c haskell markdown python sql

# 不带参数时安装全部分组，包含 neovim、ai
bash script/lang_dep.sh
```

- `ai` 只安装最新版 `@agentclientprotocol/codex-acp`。Codex、OpenCode 基础 CLI 由现有方式管理，不在本脚本中安装；OpenCode 内置 ACP，无需额外适配器。
- `neovim` 通过系统包安装搜索和图片工具，通过 Cargo 安装 tree-sitter CLI；MacPorts 的 ImageMagick7 命令目录需按 `port notes ImageMagick7` 加入 PATH。
- `python` 组安装 `basedpyright`、`ruff` 和 `debugpy`；`sql` 组安装 `sqruff`；`c` 组的 CMake 工具使用 `neocmakelsp` 和 `cmakelang`。
- `markdown` 组安装 `prettier`、`markdownlint-cli2` 和 `markdown-toc`。部分工具按脚本输出的手动安装提示处理。

安装后确保对应工具目录位于 Neovim 的 PATH 中。脚本按指定分组执行安装命令，可能要求 sudo。
