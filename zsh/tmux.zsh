# Auto-start tmux if not already inside a tmux session
if command -v tmux >/dev/null 2>&1; then
    # Don't start tmux if already in tmux, or if inside SSH session without a terminal
    if [ -z "$TMUX" ] && [ -n "$PS1" ] && [ -t 1 ]; then
        # Attach to an existing session if available, otherwise start a new one
        tmux attach-session -t default || tmux new-session -s default
    fi
fi
