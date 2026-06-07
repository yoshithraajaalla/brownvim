Most Neovim configs target Unix-based systems and break on Windows.

Every. Single. Time.

So, I decided...

```text
{##%%@@@@@@@@@@@@@@@@@@@@@@@@@@@^*%#>==~~=~~>%[==>>@{*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%
<]][[{@@@@@@@@@@@@@@@@@@@@@@@@@@*^*=~~-~---~~~===>%@{*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#[{{
>><][@@@%#%@@@@@@@@@@@@@@@@@@@@@^%<~~~-~~-~~~~~~~=]@{*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%%{[{@@%@[
>%@@@]#]]][]{[[##@@@@@@@@@@@@@@@^~<=-~-~=~---~~=<{^{(~*@@@@@@@@@@@@@[@@@@@@@@@@@@@@%#{[[[[{[[][[[[%@
@#(<(((<>(]]/{{[{[#@@@@@%%@@@@@*=*>^~-~**==~--~*=*(@~*=@@@@{#%%@%%%*=^<[@@@@@@@@@@%#{[{{{[[[[]<(][]]
(((<><(]]]]]]<([{{{{@@@@@@@@@@@@{<^***^<^^^~=****{{[==#@@@^>[>(~=**=*^<>(@@@@@@@@@@#{{[](<((]]]](((<
<><<(](]](<]]][{@@@@@@@@@@@@@@@@=(^*~^**=-~~=~==>(~=%%%%{]^>^=**~~*==~[^^>@@@><<]@<@@@@#]]]((<<((]](
<(((((<][[[[@@@@@@@@@@@@@@@#]#@@=(*^*^~*~~~=~~=~==~~~]={](=~==>^~~=~=====*^^#[(>[{%>%@@@<=]<((((<>((
<<>><(]]{@@@@@@@@@@@@@%{<<#@@@@@*^=~==~-----~--~<==>~~==~=~~~==========~=~====*]<]=~~~^--->*>@#((((<
^><(({@@@@@@@@@@@@#[<>{@@@@@@@@@[=>***=~~~~~~=~~-*(^*~~=*~=~*%%%#~~~~~~~~~~~]-----^=^[%~~*<<=@@@@%((
<(]%@@@@@==**([<(^>%@@@@@@@@@@@@<=*>>^*~~~-~~=~~-==~=~~===~^*-----*~-~~~~~~~=--------~<~>%<<=@@@@@@@
#@@@@@@(===*^~=^>*<@@@@@@@@@@@@@<*>^^^^*===*=~<^~=-~~~~~=~~~-~~~==-=~-~~~~~~~~~--------=@(<<*@@@@@@@
@@@@@@~===*~==**>]]<>@@@@@@@@@@@@*<<><=*==**^*%^*^~~~~~~~~-^~~~====~--~=~~~~==^*~-------><>^=]#%@@@@
@@%@@~==~^~==****>([(>^^>(@@@@@@>==^^*~~~~~~~~~@<=(>~-~=~-~--~===*^~---~-~==*==~=*=%---->~~~-(^^{@@@
@%#%^~===-~~~===~~~*~~=*=**^>><<=~~~==~~--------%*~^^~-~~~~---~~**~---~-~~==*==~*(%--->^>#]>~@@%>^[@
%#{>~====*==~--=*^-----~-=^*>=~~~~=~-------------<*------~~~-----~~-~~=~~~-~==*]#%---~@***({]@@@@@(^
[>^]==~~-~---~***=----~-=^*~-~~~===^--~--~-~~-~^-~*>=-----~~---~--](<^~-~~=>({%[(--~~*{=~=*=^@#@@@@@
^]@@@@@@@~-^=***^~---===~-----~~<=~=--~-~--~(](<--~~^=---~-~~-~~-~~^=~=~~=^]{#*----=**~-----^^^@@@@@
@@@@@@@*=~~~*^^***--~~~----~-==~==-~-----]##]=(%%%{<~^*~---~-----~--~-----<^~----~-~^~----~=^>(>@@@@
@@@@@@*==~=********---~**~~-==~==~~-~~*%%[<^({{##{][[=^*~----~-~~=**~(=------------^~~---~~**>(#@@@@
@@@@@*==--**********-~~*^^=~~=*=*~~~=({*=^(]]{{%#%%%%%-*^=----~~~=**=--~-----~---~~~-==-~-~=>^>[@@@@
@@@@@=~--**********--*~~==~~--*>=~~===-=^><<([[#%%%%%[~--**~-~~-~~-----~---~----~--~~-=~~~~~^^>(@%@@
@@@@*~~~%^******===--****=-==~~====---~****><([{%[~-------~<*~~---------~~~-~----~---=-(]~~=*^><@@@@

                                     "Fine, I'll do it myself."
```

I present to you:

```text
██████╗ ██████╗  ██████╗ ██╗    ██╗███╗   ██╗██╗   ██╗██╗███╗   ███╗
██╔══██╗██╔══██╗██╔═══██╗██║    ██║████╗  ██║██║   ██║██║████╗ ████║
██████╔╝██████╔╝██║   ██║██║ █╗ ██║██╔██╗ ██║██║   ██║██║██╔████╔██║
██╔══██╗██╔══██╗██║   ██║██║███╗██║██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██████╔╝██║  ██║╚██████╔╝╚███╔███╔╝██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
```

## Architecture & Philosophy

This config is built on the concept of **Deep Modules** (from *A Philosophy of Software Design*). It avoids sprawling spaghetti code by pushing complex plugin orchestration behind simple, highly-leveraged interfaces.

- **High Locality**: If you want to configure a language or a theme, you do it in one single, centralized place.
- **Simplicity**: One plugin per concern. No bloat, no redundant features.
- **Minimalism**: Fast startup, low memory, zero distractions.

Designed for Windows Terminal + Neovim ≥ 0.11 (0.12 features supported).

---

## 🛠 The Deep Modules

`brownvim` uses custom Lua modules (`lua/core/`) to abstract away boilerplate and API inconsistencies between community plugins.

### 1. The Language Manager (`lua/core/language.lua`)

Instead of bouncing between Mason, Conform, and Nvim-Lspconfig just to set up Python, the Language Manager consolidates your entire environment into a single, highly-leveraged declarative table in `init.lua`.

```lua
require("core.language").setup({
    python = {
        lsp = "pyright",
        formatters = { "black" },
        tools = { "isort" }
    },
    go = {
        lsp = "gopls",
        formatters = { "gofmt" }
    },
})
```
Behind the scenes, this deep module translates your intent into lazy-loaded plugin setups, auto-installing dependencies, mapping capabilities, and handling format-on-save without a single extra line of code.

### 2. The Theme System (`lua/core/theme.lua`)

Theme modules are usually shallow wrappers around hex codes. Our deep Theme System introduces a **Semantic Palette**.
Colorschemes in `colors/` simply export intent-based colors (`bg`, `primary`, `error`). The Theme module automatically pipes these into Neovim's Native Highlights and dynamically syncs UI plugins like Lualine.

Furthermore, Neovim automatically polls the Windows Registry via a non-blocking background process to flawlessly sync your editor with Windows OS Light/Dark mode.

```lua
require("core.theme").setup({ sync_with_os = true })
```

### 3. Editor Internals (`lua/core/{dashboard,terminal,keymaps}.lua`)

Instead of polluting `init.lua` with massive tables of keymaps, floating terminal window geometry math, and ASCII art dashboards, these concerns are isolated into their own deep modules. This leaves the root `init.lua` incredibly clean, acting only as a high-level intent bootstrap file.

---

## 📦 Stack

| Purpose               | Plugin                                 |
| :---                  | :---                                   |
| Plugin Manager        | Lazy.nvim                              |
| Deep Core             | `lua/core/*` (Language, Theme, UI)     |
| File Finder           | Telescope                              |
| LSP & Deps            | Mason + lspconfig                      |
| Completion            | Native (`vim.lsp.completion` + `vim.snippet`) |
| Syntax                | Treesitter                             |
| Theme                 | Native (Neon Circuit / Latte)          |
| File Tree             | nvim-tree                              |
| Formatter             | conform.nvim                           |
| Statusline            | lualine.nvim                           |

## ⚙️ Dependencies

- Neovim ≥ 0.11
- PowerShell 7 (`pwsh.exe`)
- Git
- GCC (for Treesitter parsers)
- Ripgrep (for Telescope live_grep)

---

## 🎮 Key Design Choices

**Black Hole Deletes**
By default, `d`, `dd`, `D` etc. delete to the black hole register (`"_d`). Your clipboard stays clean. Use `<leader>d` to delete with yank.

**Native Windows**
Forces `pwsh.exe`, disables WSL git operations, and adjusts UI for transparency.

**Native Completion & Snippets (0.11+)**
`vim.lsp.completion` (autotrigger on LSP attach) + built-in `vim.snippet` jump. Replaces nvim-cmp / LuaSnip. `<CR>` confirms, `<Tab>`/`<S-Tab>` navigate snippets.

---

## ⌨️ Key Mappings

### Navigation & Editing

| Key | Action |
| :--- | :--- |
| `<leader>t` | Toggle floating terminal |
| `<S-l>` / `<S-h>` | Next / prev buffer |
| `<C-h/j/k/l>` | Navigate window splits |
| `<leader>d` | Cut (delete + yank) |
| `<leader>p` | Paste without yanking replacement |
| `J` / `K` | Move selection up/down |

### Find, Files & Tools

| Key | Action |
| :--- | :--- |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>e` / `<leader>E` | Toggle / focus file tree |
| `<leader>rc` | Edit config |
| `<leader>w` | Format + save |

### LSP & Code

| Key | Action |
| :--- | :--- |
| `gd` / `gD` | Definition / declaration |
| `gi` / `gr` | Implementation / references |
| `K` | Hover |
| `<leader>rn` | Rename |
| `<leader>ca` | Code action |
| `<leader>lf` | Format |
| `]d` / `[d` | Next / prev diagnostic |

---

## 🚀 Setup

### Windows (recommended)

```powershell
# PowerShell
$dir = "$env:LOCALAPPDATA\nvim"
mkdir -p $dir
git clone https://github.com/yoshithraajaalla/brownvim $dir
```

Or with Command Prompt / git bash:

```cmd
mkdir "%LOCALAPPDATA%\nvim" 2>nul
git clone https://github.com/yoshithraajaalla/brownvim "%LOCALAPPDATA%\nvim"
```

On first launch, Lazy.nvim bootstraps automatically. The `Language Manager` installs LSPs and tools on demand. The config forces native Windows PowerShell (`pwsh.exe`) and disables WSL interop for git.
