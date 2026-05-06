source $HOME/.profile

# Ona injects user secrets here; the upstream hook only patches .bashrc, so source it from zsh too.
[ -f /etc/profile.d/ona-secrets.sh ] && . /etc/profile.d/ona-secrets.sh
