if status is-interactive
    # Commands to run in interactive sessions can go here

    if test -f /usr/share/doc/fzf/examples/key-bindings.fish
      source /usr/share/doc/fzf/examples/key-bindings.fish
      fzf_key_bindings
    end

    set BASE16_SHELL "$HOME/.config/base16-shell/"
    if test -f "$BASE16_SHELL/profile_helper.fish"
      source "$BASE16_SHELL/profile_helper.fish"
      base16-gruvbox-dark-medium
    end

    zoxide init fish | source
    starship init fish | source
end
