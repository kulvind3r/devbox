#Git
alias gst='git status'
alias gsh='git show'
alias gpr='git pull --rebase'
alias gpu='git push'
alias gcm='git commit -m'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gad='git add'
alias gd='git diff'
alias gdc='git diff --cached'
alias gco='git checkout'
alias send='gpr && gpu'

#Utilites
alias ping='ping -c 50'
alias grep='grep --color'
alias wget='wget -c'
alias clear='clear -x'
alias gm='/usr/local/bin/git_multi.sh'
alias gmpr='gm "pull --rebase"'
alias gms='gm "status"'
alias o='open'
alias bat='batcat'

#kubectl
alias k='kubectl'
alias kg='kubectl get'
alias kl='kubectl logs'
alias ked='kubectl edit'
alias kei='kubectl exec -it'
alias kdes='kubectl describe'
alias kdel='kubectl delete'

#docker
alias dp='docker pull'
alias drd='docker run -d'

#Directories
alias ll='ls -lrt'
alias lla='ls -lart'
alias ..='cd ..'
alias cd..='cd ..'
alias mkdir='mkdir -pv'

#Sudo commands
alias svi='sudo vi'

#Resources
alias free='free -m -l -t -h'
