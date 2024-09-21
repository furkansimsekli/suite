# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
if [ -d "$HOME/Workspace/suite/scripts" ] ; then
    PATH="$HOME/Workspace/suite/scripts:$PATH"
fi

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Aliases
# For a full list of active aliases, run `alias`
alias devcs="ssh b2210356075@dev.cs.hacettepe.edu.tr"
alias work="cd ~/Documents/Workspace"
alias tree="tree -I '__pycache__|venv|.venv|node_modules'"

# Added by Nix installer
if [ -e /home/finch/.nix-profile/etc/profile.d/nix.sh ]; then . /home/finch/.nix-profile/etc/profile.d/nix.sh; fi

deploy() {
    local project=$1
    local hostname=$2
    local port=${3:-22}
    local user=${4:-f1nch}

    case $project in
        hu-announcement-bot)
            ssh -p $port $user@$hostname 'bash -s' < $HOME/Workspace/suite/scripts/deploy_hu-announcement-bot.sh
            ;;
        hu-cafeteria-bot)
            ssh -p $port $user@$hostname 'bash -s' < $HOME/Workspace/suite/scripts/deploy_hu-cafeteria-bot.sh
            ;;
        pseudocontact)
            ssh -p $port $user@$hostname 'bash -s' < $HOME/Workspace/suite/scripts/deploy_pseudocontact.sh
            ;;
        Leakie)
            ssh -p $port $user@$hostname 'bash -s' < $HOME/Workspace/suite/scripts/deploy_Leakie.sh
            ;;
        konyaticaretborsasi-bot)
            ssh -p $port $user@$hostname 'bash -s' < $HOME/Workspace/suite/scripts/deploy_konyaticaretborsasi-bot.sh
            ;;
        *)
            echo "Unknown project: $project"
            return 1
            ;;
    esac
}
