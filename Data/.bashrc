# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# some more ls aliases
alias l='ls -l'
alias la='ls -A'
alias ll='ls -CF'

#export HTTP_PROXY=http://proxy.example.com:80/

source /home/cisco/ncs/ncsrc

export NCS_SCRIPTS=/home/cisco/ncs-scripts
export NCS_WORKDIR=/home/cisco/ncs-run

alias unpack='$NCS_SCRIPTS/unpack.sh'
alias cvenv='$NCS_SCRIPTS/cvenv.sh'
alias cenv='$NCS_SCRIPTS/cvenv.sh'
alias nversion='$NCS_SCRIPTS/version.sh'
alias nreload='$NCS_SCRIPTS/reload.sh'
alias sreload='$NCS_SCRIPTS/sreload.sh'
alias runBackup='$NCS_SCRIPTS/runBackup.sh'
alias log='$NCS_SCRIPTS/log.sh'