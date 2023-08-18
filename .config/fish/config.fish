if status is-interactive
    # Commands to run in interactive sessions can go here

    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"

    base16-gruvbox-dark-medium

    zoxide init fish | source
    starship init fish | source
end
