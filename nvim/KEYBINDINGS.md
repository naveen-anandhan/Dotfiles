# ⌨️ Complete Neovim Keybindings Cheatsheet

> **Leader Key**: `Space` (`<leader>`)  
> This document lists all custom and plugin keybindings configured in this setup.

---

## 🧭 Navigation & Motions

| Mode | Shortcut | Action | Description |
| :--- | :--- | :--- | :--- |
| **Normal / Visual** | `H` | Start of line | Moves to first non-blank character (`^`) |
| **Normal / Visual** | `ee` | End of line | Moves to the end of the line (`$`) |
| **Normal / Visual / Op** | `ss` | **Flash Jump** | Interactive two-character lightning search to any visible word |
| **Normal** | `-` | **Oil File Manager** | Opens the parent directory as an editable text buffer |
| **Normal** | `<leader>h` | Clear search highlight | Runs `:nohlsearch` to clear active search highlights |

---

## 🪟 Windows & Tmux Navigation
Seamless pane navigation across Neovim splits and Tmux sessions:

| Mode | Shortcut | Action |
| :--- | :--- | :--- |
| **Normal** | `<Ctrl + h>` | Focus left split / Tmux pane |
| **Normal** | `<Ctrl + j>` | Focus lower split / Tmux pane |
| **Normal** | `<Ctrl + k>` | Focus upper split / Tmux pane |
| **Normal** | `<Ctrl + l>` | Focus right split / Tmux pane |
| **Normal** | `<Ctrl + \>` | Focus previous split / Tmux pane |
| **Normal** | `<leader>q` | Close current buffer (`:bd`) |

---

## ✍️ Editing & Text Manipulation

| Mode | Shortcut | Action | Description |
| :--- | :--- | :--- | :--- |
| **Normal** | `<Enter>` (`<CR>`) | Split line | Inserts a newline at cursor without staying in insert mode |
| **Normal** | `dd` | Delete line (Black Hole) | Deletes current line **without** overwriting your clipboard register (`"_dd`) |
| **Visual** | `d` | Delete selection (Black Hole) | Deletes selection **without** overwriting your clipboard register (`"_d`) |
| **Visual** | `J` | Move lines down | Shifts highlighted lines down (keeps selection active) |
| **Visual** | `K` | Move lines up | Shifts highlighted lines up (keeps selection active) |
| **Normal** | `<Tab>` / `<S-Tab>` | Indent / Unindent | Shifts line indentation right (`>>`) or left (`<<`) |
| **Visual** | `<Tab>` / `<S-Tab>` | Indent / Unindent | Shifts highlighted block right (`>`) or left (`<`) (keeps selection) |
| **Normal / Visual** | `<Ctrl + />` or `<Ctrl + _>` | Toggle Comment | Comments or uncomments current line or selection |

### 🔲 Surround with Brackets / Quotes (VS Code Style)
Highlight any text in **Visual mode** and press any of the keys below to immediately wrap it:
* Press `(` or `)`: Wraps selection in `( ... )`
* Press `[` or `]`: Wraps selection in `[ ... ]`
* Press `{` or `}`: Wraps selection in `{ ... }`
* Press `"`: Wraps selection in `" ... "`
* Press `'`: Wraps selection in `' ... '`

---

## ⌨️ Insert Mode Shortcuts

| Shortcut | Action | Description |
| :--- | :--- | :--- |
| `jk` | **Fast Escape** | Instantly exits insert mode to normal mode |
| `<Ctrl + h>` | Left | Move cursor left without taking hands off home row |
| `<Ctrl + l>` | Right | Move cursor right without taking hands off home row |
| `<Ctrl + j>` | Down | Move cursor down without taking hands off home row |
| `<Ctrl + k>` | Up | Move cursor up without taking hands off home row |
| `<S-Tab>` | Unindent line | Shifts current line left (`<C-d>`) |

---

## 🤖 Autocompletion (`blink.cmp`)

| Mode | Shortcut | Action |
| :--- | :--- | :--- |
| **Insert** | `<Tab>` | **Accept** completion item |
| **Insert** | `<Ctrl + j>` | Select **next** completion item |
| **Insert** | `<Ctrl + k>` | Select **previous** completion item / show signature |

* Context-aware: supports language LSP, buffer words, snippets, paths, and Dadbod SQL tables & columns.
* Documentation preview appears automatically beside active suggestion.

---

## 🚀 Code Runners (`<leader>r`)

Press `<leader>r` (or `<Space>r`) to execute code depending on the filetype:

| Filetype | Normal Mode (`<leader>r`) | Visual Mode (`<leader>r`) |
| :--- | :--- | :--- |
| **SQL** (`.sql`) | Runs entire SQL script against active DB | Runs **only the selected SQL query** |
| **Python** (`.py`) | Saves and runs file in split terminal (`python3 %`) | Runs selected lines via Python (`w !python3`) |

---

## 📓 Jupyter Notebooks (`.ipynb`)

For complete details, see [`IPYNB_GUIDE.md`](./IPYNB_GUIDE.md).

### Modes & Cell Navigation
| Shortcut | Mode | Action |
| :--- | :--- | :--- |
| `i` or `<Enter>` | Notebook | **Enter Cell Edit Mode** (cursor moves into cell) |
| `<Esc>` | Edit | **Exit to Notebook Mode** (navigate notebook facade) |
| `]]` or `<Ctrl + j>` | Both | **Jump to next cell** |
| `[[` or `<Ctrl + k>` | Both | **Jump to previous cell** |
| `<leader>kj` | Both | Open fuzzy cell picker |

### Cell Management
| Shortcut | Mode | Action |
| :--- | :--- | :--- |
| `<leader>kb` | Both | Add new cell **below** |
| `<leader>ka` | Both | Add new cell **above** |
| `<leader>kd` (or `dd` in Notebook mode) | Both | **Cut / Delete current cell** (undo with `u`, paste with `p`) |
| `p` / `P` | Notebook | Paste cell below / above |
| `<Alt + j>` / `<Alt + k>` | Notebook | Move current cell down / up |
| `<leader>ky` | Both | Convert cell type to **Code** |
| `<leader>km` | Both | Convert cell type to **Markdown** |

### Execution & Outputs
| Shortcut | Mode | Action |
| :--- | :--- | :--- |
| `<leader>ks` | Both | **Start Python kernel** |
| `<Ctrl + Enter>` (or `<leader>kx`) | Both | **Execute current cell** (stay on cell) |
| `<Shift + Enter>` (or `<leader>kX`) | Both | **Execute cell & move to next** |
| `<leader>ko` (or `:NotebookOutput`) | Both | **View current cell output** in floating window (copyable with `Y`) |
| `<leader>kc` | Both | Clear current cell output |
| `<leader>kC` | Both | Clear all notebook outputs |
| `<leader>k0` | Both | Restart kernel |
| `<leader>kS` | Both | Shutdown kernel |
| `<leader>kn` | Both | Check kernel status info |
| `<Ctrl + c>` | Both | Interrupt running cell execution |

---

## 🗄️ Database & SQL Explorer (`DBUI`)

For complete details, see [`SQL_GUIDE.md`](./SQL_GUIDE.md).

| Command / Shortcut | Action |
| :--- | :--- |
| `:DBUI` or `:DBUIToggle` | Toggle Database Explorer sidebar drawer |
| `o` or `<Enter>` (in DBUI) | Expand/collapse database or table; preview table rows |
| `S` or `K` (in DBUI) | Open new scratch query buffer for selected database |
| `a` (in DBUI) | Add new database connection (SQLite, Postgres, MySQL, etc.) |
| `d` (in DBUI) | Delete saved connection from drawer |
| `r` (in DBUI) | Refresh schemas and table lists |
| `q` (in DBUI) | Close DBUI drawer |

---

## 🔭 Telescope & Finders

| Shortcut | Action |
| :--- | :--- |
| `<leader>tt` | **Theme Switcher** (Live preview colorschemes with Telescope) |
| `<leader>fp` | Find Neovim plugin files |
| `<leader>ff` | Find files in workspace (LazyVim default) |
| `<leader>sg` / `<leader>/` | Live grep text in workspace (LazyVim default) |

---

## 📖 Language Server (LSP)

| Shortcut | Mode | Action |
| :--- | :--- | :--- |
| `K` | Normal | **Show documentation hover** for symbol under cursor |
| `gd` | Normal | Go to definition |
| `gr` | Normal | Go to references |
| `<leader>cr` | Normal | Rename symbol |
| `<leader>ca` | Normal | Code actions |
| `[d` / `]d` | Normal | Jump to previous / next diagnostic error |
