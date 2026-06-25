# liz-diff.nvim

A Neovim plugin for browsing git diffs from a centered floating window. Type any git reference — branch, commit, tag, or leave empty for unstaged changes — and navigate changed files directly into side-by-side vimdiff splits.

## Features

- Centered float with an input prompt and navigable file list
- Supports any git reference: branch, commit hash, tag, range (`main..HEAD`), or empty for unstaged changes
- Per-status vimdiff behavior: added files show empty left pane, deleted files show empty right pane, renamed treated as modified, binary files notify instead of crashing
- In-memory cache per keyword — same reference re-queries are instant
- Cursor position remembered per keyword across re-opens
- Zero dependencies beyond Neovim 0.9+ and git

## Requirements

- Neovim >= 0.9.0
- git

## Installation

**lazy.nvim**

```lua
{
  'LizardLiang/liz-diff.nvim',
  cmd = 'LizDiff',
  opts = {},
}
```

**packer.nvim**

```lua
use {
  'LizardLiang/liz-diff.nvim',
  config = function()
    require('liz_diff').setup()
  end,
}
```

## Usage

```
:LizDiff
```

Opens the floating window. Type a git reference in the prompt and press `<CR>` to load changed files. Leave the prompt empty to see unstaged working tree changes.

### Keymaps (inside the float)

| Key           | Action                        |
| ------------- | ----------------------------- |
| `<CR>`        | Open selected file in vimdiff |
| `j` / `k`    | Navigate file list            |
| `<Esc>` / `q` | Close the float               |

## Configuration

Call `setup()` with any overrides (all fields optional):

```lua
require('liz_diff').setup({
  width  = 0.8,       -- float width as fraction of editor width
  height = 0.6,       -- float height as fraction of editor height
  border = 'rounded', -- 'rounded' | 'single' | 'double' | 'none'
  keymap = {
    close     = { '<Esc>', 'q' },
    open_diff = '<CR>',
  },
})
```

## How it works

1. `:LizDiff` opens a centered float with an input prompt.
2. Typing a reference and pressing `<CR>` runs `git diff --numstat <ref>` asynchronously.
3. Results render as `<status> <path> +<insertions> -<deletions>`.
4. Pressing `<CR>` on a file closes the float and opens a vertical vimdiff split (reference version vs working tree).
5. Results are cached in memory for the session; the same keyword never re-runs git.
