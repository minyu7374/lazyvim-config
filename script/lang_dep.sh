#!/usr/bin/env bash
# 安装各语言的 LSP / formatter / linter / DAP 依赖工具。
# set -x

case "$(uname -s)" in
Linux)
    OS=Linux
    os_name="$(grep '^NAME=' /etc/os-release | cut -d= -f2 | xargs)"
    [ -z "$os_name" ] && { os_name="$(uname -a)"; }
    ;;
Darwin)
    OS=Mac
    ;;
esac

if [ "$OS" == Linux ]; then
    DISTRO=""
    [[ "$os_name" =~ "Gentoo" ]] && {
        DISTRO=Gentoo
    }
    [[ "$os_name" =~ "Arch" ]] && {
        DISTRO=Arch
    }
    [[ "$os_name" =~ "Ubuntu" || "$os_name" =~ "Debian" ]] && {
        DISTRO=Debian
    }
    [[ "$os_name" =~ "Centos" || "$os_name" =~ "Fedora" || "$os_name" =~ "RHEL" || "$os_name" =~ "Oracle" ]] && {
        DISTRO=RHEL
    }
    [[ "$os_name" =~ "openSUSE" ]] && {
        DISTRO=SUSE
    }
fi

if [ "$OS" == Mac ]; then
    which port >/dev/null 2>&1 && DISTRO="MacPorts"
    [ -z "$DISTRO" ] && which brew >/dev/null 2>&1 && DISTRO="Homebrew"
fi

function pre_task() {
    npm_install="npm install -g"
    which pnpm >/dev/null && npm_install="pnpm add -g"
}

function for_c() {
    # clangd + clang-format 随 clang/llvm 一起安装
    case "$DISTRO" in
    Gentoo)
        # USE extra: 构建 clangd / clang-tidy 等
        sudo emerge --update llvm-core/clang
        ;;
    Arch)
        sudo pacman -Sy --noconfirm clang
        ;;
    SUSE)
        sudo zypper in -y clang
        ;;
    Debian)
        sudo apt-get install clangd
        ;;
    RHEL)
        sudo dnf install clang-tools-extra
        ;;
    MacPorts)
        sudo port install clang-19
        ;;
    Homebrew)
        brew install llvm
        ;;
    esac
    # neocmakelsp: CMake LSP（cmake-language-server 已疏于维护，改用它）
    cargo install neocmakelsp
    # cmakelang: 提供 cmake-format + cmake-lint（是 cmakelint 的超集，取其一）
    uv tool install cmakelang
    # codelldb (C/C++ DAP): 无包管理器安装方式，
    # 请从 vadimcn/codelldb releases 下载，或用 llvm 自带的 lldb-dap
    echo "codelldb: download from vadimcn/codelldb releases, or use llvm's lldb-dap"
}

function for_go() {
    go install golang.org/x/tools/gopls@latest         # LSP
    go install golang.org/x/tools/cmd/goimports@latest # imports 整理
    go install mvdan.cc/gofumpt@latest                 # formatter
    go install github.com/go-delve/delve/cmd/dlv@latest # DAP

    # golangci-lint: 包管理器版本较旧，用官方脚本装到 GOPATH/bin
    curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh |
        sh -s -- -b "$(go env GOPATH)/bin"
    golangci-lint --version
}

function for_haskell() {
    # hlint: linter
    case "$DISTRO" in
    Arch)
        sudo pacman -Sy --noconfirm ghc hlint cabal-install
        ;;
    SUSE)
        sudo zypper in -y ghc ghc-hlint cabal-install
        ;;
    Homebrew)
        brew install hlint
        ;;
    *)
        curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
        ghcup install ghc cabal
        cabal install hlint
        ;;
    esac
}

function for_markdown() {
    $npm_install markdownlint-cli2@latest # linter
    $npm_install markdown-toc@latest      # 目录生成

    # vale: prose linter; marksman: markdown LSP（单二进制）
    case "$DISTRO" in
    Homebrew)
        brew install vale marksman
        ;;
    *)
        echo "vale: download from errata-ai/vale releases"
        echo "marksman: download from artempyanykh/marksman releases"
        ;;
    esac
}

function for_python() {
    uv tool install basedpyright # LSP（优于 pyright，取其一）
    uv tool install ruff@latest  # lint + format
    uv tool install debugpy      # DAP
}

function for_shell() {
    # shellcheck: linter
    case "$DISTRO" in
    Gentoo)
        sudo emerge --update shellcheck-bin
        ;;
    Arch)
        sudo pacman -Sy --noconfirm shellcheck
        ;;
    SUSE)
        sudo zypper in -y ShellCheck
        ;;
    MacPorts)
        sudo port install shellcheck
        ;;
    Homebrew)
        brew install shellcheck
        ;;
    *)
        cabal install ShellCheck --overwrite-policy=always
        ;;
    esac

    $npm_install bash-language-server@latest    # LSP
    go install mvdan.cc/sh/v3/cmd/shfmt@latest  # formatter
}

function for_lua() {
    cargo install stylua # formatter
    # lua-language-server: LSP
    case "$DISTRO" in
    Arch)
        sudo pacman -Sy --noconfirm lua-language-server
        ;;
    Homebrew)
        brew install lua-language-server
        ;;
    *)
        echo "lua-language-server: download from LuaLS/lua-language-server releases"
        ;;
    esac
}

function for_json() {
    $npm_install vscode-langservers-extracted@latest # 提供 vscode-json-language-server

    # jq: JSON 处理 CLI
    case "$DISTRO" in
    Gentoo)
        sudo emerge --update app-misc/jq
        ;;
    Arch)
        sudo pacman -Sy --noconfirm jq
        ;;
    SUSE)
        sudo zypper in -y jq
        ;;
    MacPorts)
        sudo port install jq
        ;;
    Homebrew)
        brew install jq
        ;;
    *)
        echo "jq: install via distro package"
        ;;
    esac
}

function for_yaml() {
    $npm_install yaml-language-server@latest     # LSP
    go install github.com/mikefarah/yq/v4@latest # yq: YAML 处理 CLI
}

function for_toml() {
    # taplo: TOML 的 LSP + formatter（需开启 lsp feature）
    cargo install taplo-cli --features lsp
}

function for_sql() {
    # sqruff: lint + format（Rust 单二进制，取代 sqlfluff，取其一）
    cargo install sqruff
}

function for_nginx() {
    uv tool install nginxfmt # nginx 配置 formatter
}

function for_copilot() {
    $npm_install @github/copilot-language-server@latest # Copilot LSP
}

pre_task

[ -z "$*" ] &&
    # grep -oP '(?<=for_).*(?=\(\) \{)' ./script/lang_dep.sh | xargs
    set -- c go haskell markdown python shell lua json yaml toml sql nginx copilot

for lang in "$@"; do
    eval "for_$lang"
done
