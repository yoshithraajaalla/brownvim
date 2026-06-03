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
| Theme                 | Neon Circuit (customized Gruvbox)   |
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

## Key Design Choices

**Black Hole Deletes**  
By default, `d`, `dd`, `D` etc. delete to the black hole register (`"_d`). Your clipboard stays clean. Use `<leader>d` to cut with yank.

**Native Windows**  
Forces `pwsh.exe`, disables WSL git operations, and adjusts UI for transparency.

**Centered Scrolling**  
`Ctrl-d/Ctrl-u`, `n/N` keep the cursor centered for sustained focus.

**Native Completion & Snippets (0.11+)**  
`vim.lsp.completion` (autotrigger on LSP attach) + built-in `vim.snippet` jump. Replaces nvim-cmp / LuaSnip. `<CR>` confirms, `<Tab>`/`<S-Tab>` navigate snippets.

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
