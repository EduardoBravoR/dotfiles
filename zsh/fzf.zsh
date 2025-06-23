# Fuzzy file finder with bat preview
fzf_find_file() {
  local file
  file=$(fd --type f --hidden --exclude .git . | \
    fzf --height=40% --layout=reverse --border \
        --preview 'bat --style=numbers --color=always --line-range :100 {}' \
        --preview-window=right:60%) && \
  nvim "$file"
}

# Fuzzy directory finder with eza tree preview
fzf_cd() {
  local dir
  dir=$(fd --type d --hidden --exclude .git . | \
    fzf --height=40% --layout=reverse --border \
        --preview 'eza --color=always --icons --tree --level=2 {}' \
        --preview-window=right:60%) && \
  cd "$dir"
}

fzf_history() {
  local cmd
  cmd=$(fc -l 1 | awk '{$1=""; print substr($0,2)}' | \
    fzf --height=40% --layout=reverse --border \
        --preview 'echo {}' --preview-window=down:3:wrap) && \
  print -z "$cmd"
}
# Optional keybindings (Ctrl-O = open file, Ctrl-G = cd)
bindkey -s '^O' 'fzf_find_file\n'
bindkey -s '^G' 'fzf_cd\n'
bindkey -s '^H' 'fzf_history\n'
# fd = Modern file finder.
# fzf = Fuzzy selector.
# bat = Better cat with syntax highlighting.
# eza = Modern ls with colors, icons, and tree view.
