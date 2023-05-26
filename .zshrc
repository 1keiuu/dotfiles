# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
export PATH="$PATH:/opt/homebrew/bin" 

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

export PATH=$PATH:$HOME/.nodebrew/current/bin

export PATH=$PATH:/usr/local/opt/mongodb-community@4.4/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/s16428/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/s16428/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/s16428/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/s16428/google-cloud-sdk/completion.zsh.inc'; fi

[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
  eval "$(rbenv init -)"

# pnpm
export PNPM_HOME="/Users/s16428/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
