-- FZF Configuration.
-- In Vim Script this sets a global variable by the name of "fzf_layout".
-- let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
-- Same command as above but in lua
-- vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }

-- Environment variable in .vimrc
-- $FZF_DEFAULT_OPTS="--preview-window 'right:57%' --preview 'bat --style=numbers --line-range :300 {}'
-- \ --bind ctrl-y:preview-up,ctrl-e:preview-down,
-- \ctrl-b:preview-page-up,ctrl-f:preview-page-down,
-- \ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down,
-- \shift-up:preview-top,shift-down:preview-bottom,
-- \alt-up:half-page-up,alt-down:half-page-down"

-- Converted to lua
vim.env.FZF_DEFAULT_OPTS =
    '--multi --height=80% --border=sharp --preview="tree -C {}" --preview-window="65%,border-sharp" --bind="ctrl-p:toggle-preview" --bind="ctrl-d:change-prompt(Dirs > )" --bind="ctrl-d:+reload(find . -type d 2>&1)" --bind="ctrl-d:+change-preview(tree -C {})" --bind="ctrl-d:+refresh-preview" --bind="ctrl-f:change-prompt(Files > )" --bind="ctrl-f:+reload(find . -type f 2>&1)" --bind="ctrl-f:+change-preview(bat --color=always {})" --bind="ctrl-f:+refresh-preview" --bind="ctrl-a:select-all" --bind="ctrl-x:deselect-all" --header "CTRL-D 👑 to display directories | CTRL-F to display files CTRL-A 🐙 to select all | CTRL-x 💣 to deselect all ENTER 👾 to edit | DEL 🪼 to delete CTRL-P 💎 to toggle preview" --color="bg+:-1,fg:252,fg+:178,border:241,spinner:199,hl:yellow,header:blue,info:37,pointer:196,prompt:magenta,hl+:red,separator:202" --no-height --no-reverse --multi --height=50% --margin=5%,2%,2%,5% --layout=reverse-list --border=double --info=inline --prompt="👻$>" --pointer="→" --marker="🎯"'
