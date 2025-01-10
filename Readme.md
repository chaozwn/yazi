# Install

```shell
brew install file yazi ffmpegthumbnailer unar jq poppler fd ripgrep fzf zoxide exiftool bat lazygit lazydocker sevenzip imagemagick font-symbols-only-nerd-font ripgrep-all mediainfo glow eza
brew tap homebrew/cask-fonts && brew install --cask font-symbols-only-nerd-font
```

```shell
echo 'export PATH="/opt/homebrew/opt/file-formula/bin:$PATH"' >> ~/.zshrc
```

# Add before to shell

> zsh/bash

```shell
function ff() {
 local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
 yazi "$@" --cwd-file="$tmp"
 if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
  cd -- "$cwd"
 fi
 rm -f -- "$tmp"
}
```

# how to upgrade plugins

```shell
# Add the plugin
ya pack -a lpnh/fg

# Install the plugin
ya pack -i

# Upgrade the plugin
ya pack -u
```

# exa

> add to `.zshrc`

```shell
eval "$(zoxide init zsh)"
```

## FZF

```shell
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none
  --color=bg+:#2d3f76 \
  --color=bg:#1e2030 \
  --color=border:#589ed7 \
  --color=fg:#c8d3f5 \
  --color=gutter:#1e2030 \
  --color=header:#ff966c \
  --color=hl+:#65bcff \
  --color=hl:#65bcff \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#65bcff \
  --color=query:#c8d3f5:regular \
  --color=scrollbar:#589ed7 \
  --color=separator:#ff966c \
  --color=spinner:#ff007c \
"
```

# eza

> add to `.zshrc`

```shell
# 默认显示 icons：
alias ls="eza --icons"
# 显示文件目录详情
alias ll="eza --icons --long --header"
# 显示全部文件目录，包括隐藏文件
alias la="eza --icons --long --header --all"
# 显示详情的同时，附带 git 状态信息
alias lg="eza --icons --long --header --all --git"

# 替换 tree 命令
alias lt="eza --tree -L 2 --icons"

eval "$(zoxide init zsh)"
```

## Keybindings

:::tip
For all keybindings, see the [default `keymap.toml` file](https://github.com/sxyazi/yazi/blob/latest/yazi-config/preset/keymap.toml).
:::

### Navigation

To navigate between files and directories you can use the arrow keys <kbd>←</kbd>, <kbd>↓</kbd>, <kbd>↑</kbd> and <kbd>→</kbd>
or Vim-like keys such as <kbd>h</kbd>, <kbd>j</kbd>, <kbd>k</kbd>, <kbd>l</kbd>:

| Key binding  | Alternate key | Action                                          |
| ------------ | ------------- | ----------------------------------------------- |
| <kbd>k</kbd> | <kbd>↑</kbd>  | Move the cursor up                              |
| <kbd>j</kbd> | <kbd>↓</kbd>  | Move the cursor down                            |
| <kbd>l</kbd> | <kbd>→</kbd>  | Enter hovered directory                         |
| <kbd>h</kbd> | <kbd>←</kbd>  | Leave the current directory and into its parent |

Further navigation commands can be found in the table below.

| Key binding                 | Action                       |
| --------------------------- | ---------------------------- |
| <kbd>K</kbd>                | Move the cursor up 5 lines   |
| <kbd>J</kbd>                | Move the cursor down 5 lines |
| <kbd>g</kbd> ⇒ <kbd>g</kbd> | Move cursor to the top       |
| <kbd>G</kbd>                | Move cursor to the bottom    |

### Selection

To select files and directories, the following commands are available.

| Key binding                    | Action                                     |
| ------------------------------ | ------------------------------------------ |
| <kbd>Space</kbd>               | Toggle selection of hovered file/directory |
| <kbd>v</kbd>                   | Enter visual mode (selection mode)         |
| <kbd>V</kbd>                   | Enter visual mode (unset mode)             |
| <kbd>Ctrl</kbd> + <kbd>a</kbd> | Select all files                           |
| <kbd>Ctrl</kbd> + <kbd>r</kbd> | Inverse selection of all files             |
| <kbd>Esc</kbd>                 | Cancel selection                           |

### File/directory operations

To interact with selected files/directories use any of the commands below.

| Key binding                        | Action                                                                      |
| ---------------------------------- | --------------------------------------------------------------------------- |
| <kbd>o</kbd>                       | Open the selected files                                                     |
| <kbd>O</kbd>                       | Open the selected files interactively                                       |
| <kbd>Enter</kbd>                   | Open the selected files                                                     |
| <kbd>Ctrl</kbd> + <kbd>Enter</kbd> | Open the selected files interactively (some terminals don't support it yet) |
| <kbd>y</kbd>                       | Yank the selected files (copy)                                              |
| <kbd>x</kbd>                       | Yank the selected files (cut)                                               |
| <kbd>p</kbd>                       | Paste the yanked files                                                      |
| <kbd>P</kbd>                       | Paste the yanked files (overwrite if the destination exists)                |
| <kbd>Y</kbd> or <kbd>X</kbd>       | Cancel the yank state (unyank)                                              |
| <kbd>-</kbd>                       | Create a symbolic link to the yanked files (absolute path)                  |
| <kbd>\_</kbd>                      | Create a symbolic link to the yanked files (relative path)                  |
| <kbd>d</kbd>                       | Move the files to the trash                                                 |
| <kbd>D</kbd>                       | Permanently delete the files                                                |
| <kbd>a</kbd>                       | Create a file or directory (ends with "/" for directories)                  |
| <kbd>r</kbd>                       | Rename a file or directory                                                  |
| <kbd>;</kbd>                       | Run a shell command                                                         |
| <kbd>:</kbd>                       | Run a shell command (block the UI until the command finishes)               |
| <kbd>.</kbd>                       | Toggle the visibility of hidden files                                       |
| <kbd>Ctrl</kbd> + <kbd>s</kbd>     | Cancel the ongoing search                                                   |
| <kbd>z</kbd>                       | Jump to a directory using zoxide                                            |
| <kbd>Z</kbd>                       | Jump to a directory, or reveal a file using fzf                             |
