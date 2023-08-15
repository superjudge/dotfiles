if status is-interactive
  # First clone base16-shell:
  # git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
  
  # Commands to run in interactive sessions can go here
  set BASE16_SHELL "$HOME/.config/base16-shell/"
  source "$BASE16_SHELL/profile_helper.fish"
end

base16-gruvbox-dark-medium
