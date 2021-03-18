# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation
export ZSH="/Users/peggy/.oh-my-zsh"

# Show OS info when opening a new terminal
neofetch

# Font mode for powerlevel10K
POWERLEVEL10K_MODE='nerdfont-complete'

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Prompt elements
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context_joined battery_joined dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time custom_wifi_signal ram load ssh background_jobs)

# Prompt settings
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{014}\u2570%F{cyan}\uF460%F{073}\uF460%F{109}\uF460%f "
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
# POWERLEVEL9K_SHORTEN_STRATEGY="truncate_with_folder_marker"
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\UE0BC'
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\UE0BA'

# Wifi 
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL="zsh_wifi_signal"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_BACKGROUND="white"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_FOREGROUND="black"

zsh_wifi_signal(){
	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
		return
	fi

	local output=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I)
	local airport=$(echo $output | grep 'AirPort' | awk -F': ' '{print $2}')

	if [ "$airport" = "Off" ]; then
		local color='%F{black}'
		echo -n "%{$color%}Wifi Off"
	else
		local ssid=$(echo $output | grep ' SSID' | awk -F': ' '{print $2}')
		local speed=$(echo $output | grep 'lastTxRate' | awk -F': ' '{print $2}')
		local color='%F{black}'

		[[ $speed -gt 100 ]] && color='%F{black}'
		[[ $speed -lt 50 ]] && color='%F{red}'

		echo -n "%{$color%}$speed Mbps \uf1eb%{%f%}" # removed char not in my PowerLine font
fi
}

# Context 
POWERLEVEL9K_CONTEXT_TEMPLATE=' %n'
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='white'
POWERLEVEL9K_USER_ICON=$'\uF415'
POWERLEVEL9K_SUDO_ICON=$'\uF09C'
POWERLEVEL9K_ROOT_ICON=$'#'

# Battery
POWERLEVEL9K_BATTERY_CHARGING='yellow'
POWERLEVEL9K_BATTERY_CHARGED='green'
POWERLEVEL9K_BATTERY_DISCONNECTED='$DEFAULT_COLOR'
POWERLEVEL9K_BATTERY_LOW_THRESHOLD='10'
POWERLEVEL9K_BATTERY_LOW_COLOR='red'
POWERLEVEL9K_BATTERY_ICON='\uf1e6 '

# VCS colours
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'

# VCS icons
# POWERLEVEL9K_VCS_UNTRACKED_ICON='?'
POWERLEVEL9K_VCS_GIT_ICON=$'\uf1d2 '
POWERLEVEL9K_VCS_GIT_GITHUB_ICON=$'\uf113 '
POWERLEVEL9K_VCS_GIT_GITLAB_ICON=$'\uf296 '
# POWERLEVEL9K_VCS_BRANCH_ICON=$''
POWERLEVEL9K_VCS_STAGED_ICON=$'\uf055'
POWERLEVEL9K_VCS_UNSTAGED_ICON=$'\uf421'
POWERLEVEL9K_VCS_UNTRACKED_ICON=$'\uf00d'
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=$'\uf0ab '
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=$'\uf0aa '

# Time
POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M \uf073 %d/%m/%y}"
POWERLEVEL9K_TIME_BACKGROUND='white'

# RAM and LOAD
POWERLEVEL9K_RAM_BACKGROUND='yellow'
POWERLEVEL9K_LOAD_CRITICAL_BACKGROUND="white"
POWERLEVEL9K_LOAD_WARNING_BACKGROUND="white"
POWERLEVEL9K_LOAD_NORMAL_BACKGROUND="white"
POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND="red"
POWERLEVEL9K_LOAD_WARNING_FOREGROUND="yellow"
POWERLEVEL9K_LOAD_NORMAL_FOREGROUND="black"
POWERLEVEL9K_LOAD_CRITICAL_VISUAL_IDENTIFIER_COLOR="red"
POWERLEVEL9K_LOAD_WARNING_VISUAL_IDENTIFIER_COLOR="yellow"
POWERLEVEL9K_LOAD_NORMAL_VISUAL_IDENTIFIER_COLOR="green"

# Dir 
# POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_FOLDER_ABBREVIATION="%F{red} $(print_icon 'HOME_ICON') %F{black}"
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''

# Status
POWERLEVEL9K_STATUS_VERBOSE=true
POWERLEVEL9K_STATUS_CROSS=true

# Command auto-correction
ENABLE_CORRECTION="true"

# Command execution time stamp shown in the history command output
HIST_STAMPS="mm/dd/yyyy"
DISABLE_LS_COLORS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins to load
plugins=(
	colorize
	command-not-found
	git
	history-substring-search
	safe-paste
	ssh-agent
	thefuck
	tmux 
	zsh-autosuggestions
	zsh-completions
	zsh-syntax-highlighting
)

# for zsh-completions
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh
source $ZSH_CUSTOM/.aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"
export PATH="/opt/homebrew/opt/tcl-tk/bin:$PATH"
export XML_CATALOG_FILES="/opt/homebrew/etc/xml/catalog"
export PATH="/opt/homebrew/opt/gnu-getopt/bin:$PATH"
eval $(thefuck --alias)
export PATH="/opt/homebrew/opt/ncurses/bin:$PATH"
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
if type brew &>/dev/null; then
	FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
	autoload -Uz compinit
	compinit
fi
rm -f ~/.zcompdump; compinit
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh