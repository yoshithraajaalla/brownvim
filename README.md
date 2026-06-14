> **This project is deprecated.** Development has moved to [**minimalist_neovim**](https://github.com/yoshithraajaalla/minimalist_neovim). Please use that repository for new installations and ongoing updates.

---

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

## [*] The Deep Modules

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

Furthermore, Neovim automatically polls the Windows Registry via a non-blocking background process to flawlessly sync your editor with Windows OS Light/Dark mode, caching the result locally to eliminate unstyled startup flashes.

```lua
require("core.theme").setup({ sync_with_os = true })
```

### 3. The Keymap Registry (`lua/core/keymaps.lua`)

Instead of scattering `vim.keymap.set` calls across plugins and files, this module acts as a deep, declarative registry for all global Neovim bindings, ensuring single-source-of-truth locality.

### 4. The Environment Manager (`lua/core/env.lua`)

Abstracts OS detection, shell resolution, and Git environment variables behind a single `env.apply_os_quirks()` call, keeping OS-specific hacks out of the global scope.

### 5. Editor Internals (`lua/core/{dashboard,terminal}.lua`)

Floating terminal window geometry math and isolated dashboard buffer states are hidden behind simple setup calls. This leaves the root `init.lua` incredibly clean, acting only as a high-level intent bootstrap file.

---

## [=] Stack

| Purpose               | Plugin                                 |
| :---                  | :---                                   |
| Plugin Manager        | Lazy.nvim                              |
| Deep Core             | `lua/core/*` (Language, Theme, Env, UI) |
| File Finder           | Telescope                              |
| LSP & Deps            | Mason + lspconfig                      |
| Completion            | Native (`vim.lsp.completion` + `vim.snippet`) |
| Syntax                | Treesitter                             |
| Theme                 | Native (Moonchrome Light / Dark)       |
| File Tree             | nvim-tree                              |
| Formatter             | conform.nvim                           |
| Statusline            | lualine.nvim                           |


## [~] Key Design Choices

**Black Hole Deletes**
By default, `d`, `dd`, `D` etc. delete to the black hole register (`"_d`). Your clipboard stays clean. Use `<leader>d` to delete with yank.

**Native Windows**
Forces `pwsh.exe`, disables WSL git operations, and adjusts UI for transparency.

**Native Completion & Snippets (0.11+)**
`vim.lsp.completion` (autotrigger on LSP attach) + built-in `vim.snippet` jump. Replaces nvim-cmp / LuaSnip. `<CR>` confirms, `<Tab>`/`<S-Tab>` navigate snippets.

---

## [+] Key Mappings

### Navigation
| Key | Action |
| :--- | :--- |
| `<leader>t` | Toggle floating terminal (use `<Esc>` to exit) |
| `<S-l>` / `<S-h>` | Next / prev buffer |
| `<leader>bd` | Delete buffer |
| `<C-h/j/k/l>` | Navigate window splits |
| `<C-Up/Down/Left/Right>` | Resize window splits |
| `<leader>q` / `<leader>Q` | Quit / Force Quit |
| `<leader>R` | Restart Neovim |

### Editing
| Key | Action |
| :--- | :--- |
| `<leader>d` / `<leader>dd` | Cut (delete + yank) / Cut line |
| `<leader>p` | Paste without yanking replacement |
| `J` / `K` | Move selection up/down |
| `<` / `>` | Indent left/right (keeps selection) |
| `<leader>cc` | Copy entire file |
| `<leader>s` | Select entire file |
| `<leader>w` | Format and save |
| `<Esc>` | Clear highlights |

### Find, Files & Tools
| Key | Action |
| :--- | :--- |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` / `<leader>fr` | Browse buffers / Recent files |
| `<leader>/` | Search current buffer |
| `<leader>fh` | Help tags |
| `<leader>ra` | Toggle to alternate file |
| `<leader>e` / `<leader>E` | Toggle / focus file tree |
| `<leader>a` | Add to Harpoon |
| `<C-e>` | Harpoon menu |
| `<leader>1-4` | Jump to Harpoon slot 1-4 |
| `<leader>rc` | Edit config |

### Code & Git
| Key | Action |
| :--- | :--- |
| `gd` / `gD` | Definition / declaration |
| `gi` / `gr` | Implementation / references |
| `K` / `<C-s>` | Hover / Signature help |
| `<leader>D` | Type definition |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>lf` | Format file |
| `]d` / `[d` | Next / prev diagnostic |
| `<leader>l` / `<leader>la` | Show line diagnostics / All diagnostics |
| `]h` / `[h` | Next / prev git hunk |
| `<leader>hs` / `<leader>hr` | Stage / Reset git hunk |
| `<leader>hp` / `<leader>hb` | Preview git hunk / Blame line |
| `<leader>hd` | Diff this |

---

## [>] Setup

> [!IMPORTANT]
> **brownvim is deprecated.** For setup instructions and the latest config, see [**minimalist_neovim**](https://github.com/yoshithraajaalla/minimalist_neovim).

> [!NOTE]
> The instructions below are kept for reference only. New users should clone the successor project instead.

### [-] Dependencies

- Neovim ≥ 0.11
- PowerShell 7 (`pwsh.exe`)
- Git
- GCC (for Treesitter parsers)
- Ripgrep (for Telescope live_grep)

### Windows (recommended)

```powershell
# PowerShell
$dir = "$env:LOCALAPPDATA\nvim"
mkdir -p $dir
git clone https://github.com/yoshithraajaalla/minimalist_neovim $dir
```

Or with Command Prompt / git bash:

```cmd
mkdir "%LOCALAPPDATA%\nvim" 2>nul
git clone https://github.com/yoshithraajaalla/minimalist_neovim "%LOCALAPPDATA%\nvim"
```

On first launch, Lazy.nvim bootstraps automatically. The `Language Manager` installs LSPs and tools on demand. The config forces native Windows PowerShell (`pwsh.exe`) and disables WSL interop for git.
