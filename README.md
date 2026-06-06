Most Neovim configs target Unix-based systems and break on Windows.

Every. Single. Time.

So, I decided...

```
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

```
██████╗ ██████╗  ██████╗ ██╗    ██╗███╗   ██╗██╗   ██╗██╗███╗   ███╗
██╔══██╗██╔══██╗██╔═══██╗██║    ██║████╗  ██║██║   ██║██║████╗ ████║
██████╔╝██████╔╝██║   ██║██║ █╗ ██║██╔██╗ ██║██║   ██║██║██╔████╔██║
██╔══██╗██╔══██╗██║   ██║██║███╗██║██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██████╔╝██║  ██║╚██████╔╝╚███╔███╔╝██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
```

## Philosophy

This config is built on three principles:

- **Simplicity**: One plugin per concern. No bloat, no redundant features.
- **Intentionality**: Every mapping and setting serves a clear purpose.
- **Minimalism**: Fast startup, low memory, zero distractions.

Designed for Windows Terminal + Neovim ≥ 0.11 (0.12 features supported).

---

## Stack

| Purpose               | Plugin                                 |
| :---                  | :---                                   |
| Plugin Manager        | Lazy.nvim                              |
| File Finder           | Telescope                              |
| LSP & Deps            | Mason + lspconfig                      |
| Completion            | Native (`vim.lsp.completion` + `vim.snippet`) |
| Syntax                | Treesitter                             |
| Theme                 | Native (Neon Circuit / Latte)          |
| File Tree             | nvim-tree                              |
| Git                   | gitsigns                               |
| Formatter             | conform.nvim                           |
| Statusline            | lualine.nvim                           |
| Harpoon               | harpoon (2)                            |
| Autopairs             | nvim-autopairs                         |
| Cursor Animations     | smear-cursor.nvim                      |
| Smooth Scrolling      | cinnamon.nvim                          |
| Render Markdown       | render-markdown.nvim                   |


---

## Dependencies

- Neovim ≥ 0.11
- PowerShell (`pwsh.exe`)
- Git
- GCC (for Treesitter parsers)
- Mason (installs LSP servers: pyright, gopls, lua_ls, rust-analyzer)
- Language runtimes: Python, Go, Rust
- Ripgrep (for Telescope live_grep)

## Key Design Choices

**Black Hole Deletes**
By default, `d`, `dd`, `D` etc. delete to the black hole register (`"_d`). Your clipboard stays clean. Use `<leader>d` to delete with yank.

**Native Windows**
Forces `pwsh.exe`, disables WSL git operations, and adjusts UI for transparency.

**Centered Scrolling**
`Ctrl-d/Ctrl-u`, `n/N` keep the cursor centered for sustained focus.

**Native Completion & Snippets (0.11+)**
`vim.lsp.completion` (autotrigger on LSP attach) + built-in `vim.snippet` jump. Replaces nvim-cmp / LuaSnip. `<CR>` confirms, `<Tab>`/`<S-Tab>` navigate snippets.

**Native Theming & OS Auto-Sync**
Zero plugin bloat for themes. Themes are implemented natively in the `colors/` directory. Neovim automatically polls the Windows Registry to seamlessly sync the colorscheme with your Windows OS Light/Dark mode, without being interfered with by terminal emulator limitations.

---

## Custom Themes & Configuration

This config uses entirely native Neovim themes located in the `colors/` directory, avoiding bloated external plugins.

### 1. The Active Themes
- **Neon Circuit (Dark)**: A vibrant, high-contrast dark theme optimized for readability.
- **Latte (Light)**: A soft, pleasing light theme (Catppuccin-inspired) that looks great with transparency.

### 2. How to Add a New Theme
Creating your own theme is incredibly fast:
1. Create a new file in the `colors/` directory (e.g., `colors/my_theme.lua`).
2. Clear existing highlights and declare your theme name:
   ```lua
   vim.cmd("highlight clear")
   if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
   vim.g.colors_name = "my_theme"
   ```
3. Define your colors and `vim.api.nvim_set_hl(0, group, hl)` mappings (look at `colors/neon_circuit.lua` for a complete reference).

### 3. Wiring it into Auto-Sync
If you want your custom theme to be triggered automatically by the Windows Light/Dark mode syncing:
1. Open `init.lua`.
2. Locate the `apply_theme_for_bg` function (under `AUTOMATIC SYSTEM THEME SYNC`).
3. Change the target colorschemes:
   ```lua
   local function apply_theme_for_bg(bg)
       if bg == "light" then
           if vim.g.colors_name ~= "my_light_theme" then
               vim.cmd("colorscheme my_light_theme")
           end
           -- ...
   ```

---

## Key Mappings

### Navigation

| Key | Action |
| :--- | :--- |
| `<leader>t` | Toggle floating terminal |
| `<S-l>` / `<S-h>` | Next / prev buffer |
| `<C-h/j/k/l>` | Navigate window splits |
| `<C-Up/Down/Left/Right>` | Resize splits |
| `<leader>bd` | Delete buffer |

### Editing

| Key | Action |
| :--- | :--- |
| `<leader>d` / `<leader>dd` | Cut (delete + yank) |
| `<leader>p` | Paste without yanking replacement |
| `J` / `K` | Move selection up/down |
| `<` / `>` | Indent (keeps selection) |

### Find & Files

| Key | Action |
| :--- | :--- |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fr` | Recent files |
| `<leader>/` | Search buffer |

### Code

| Key | Action |
| :--- | :--- |
| `gd` / `gD` | Definition / declaration |
| `gi` / `gr` | Implementation / references |
| `K` | Hover |
| `<leader>rn` | Rename |
| `<leader>ca` | Code action |
| `<leader>lf` | Format |
| `]d` / `[d` | Next / prev diagnostic |

### Tools

| Key | Action |
| :--- | :--- |
| `<leader>e` / `<leader>E` | Toggle / focus file tree |
| `<C-e>` | Harpoon menu |
| `<leader>a` | Add to Harpoon |
| `<leader>1-4` | Jump to Harpoon slot |
| `<leader>rc` | Edit config |
| `<leader>w` | Format + save |
| `<leader>q` / `<leader>Q` | Quit / force quit |

---

## Setup

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

### Unix / macOS (for reference)

```bash
mkdir -p ~/.config/nvim
git clone https://github.com/yoshithraajaalla/brownvim ~/.config/nvim
```

On first launch, Lazy.nvim bootstraps automatically. Mason installs LSPs and tools on demand. The config forces native Windows PowerShell (`pwsh.exe`) and disables WSL interop for git.

