Most Neovim configs are targeted for unix-based systems (MacOS/Linux), and breaks in Windows.

Every. Single. Time!

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

Designed for Windows Terminal + Neovim ≥ 0.9.

---

## Stack

| Purpose | Plugin |
| :--- | :--- |
| Plugin Manager | Lazy.nvim |
| File Finder | Telescope |
| LSP & Deps | Mason + lspconfig |
| Completion | nvim-cmp |
| Syntax | Treesitter |
| Theme | Gruvbox (hard contrast, transparent) |
| File Tree | nvim-tree |
| Git | gitsigns |
| Formatter | conform.nvim |

---

## Key Design Choices

**Black Hole Deletes**  
By default, `d`, `dd`, `D` etc. delete to the black hole register (`"_d`). Your clipboard stays clean. Use `<leader>d` to cut with yank.

**Native Windows**  
Forces `pwsh.exe`, disables WSL git operations, and adjusts UI for transparency.

**Centered Scrolling**  
`Ctrl-d/Ctrl-u`, `n/N` keep the cursor centered for sustained focus.

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

Clone this repo to your Neovim config:

```bash
mkdir -p ~/.config/nvim
git clone https://github.com/your-repo/nvim ~/.config/nvim
```

On first launch, Lazy.nvim bootstraps automatically. Mason installs LSPs and tools on demand.