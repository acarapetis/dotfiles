# vim: ft=sh
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

export LC_ALL=en_US.utf-8 # REQUIRED for the PS1 to work properly

# some more ls aliases
alias ll='ls -alh --file-type'
alias la='ls -a'
alias l='ls -CF'
alias ltr='ls -Alhrt --file-type'

# start fullscreen fugitive status
alias fugitive="nvim +'call GFull()'"

# paged pretty ripgrep
function rg {
    command rg -p "$@" | less -RF
}

#export TERM=xterm-256color
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30:ow=34:st=37;44:ex=32;1:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;"

# Two-line prompt with $? and git branch info
RESET="\[\e[0m\]"
GREEN="\[\e[38;5;108m\]"
BLUE="\[\e[38;5;104m\]"

PS_LINE=`printf -- '——%.0s' {1..200}`
function parse_git_branch {
    errcode=$?
    PS_BRANCH=''
    PS_FILL=${PS_LINE:0:$COLUMNS}
    ref=$(git -c color.ui=always log -n1 --oneline --decorate=short 2>/dev/null| sed 's/).*/)/' | sed 's/HEAD -> //') || return
    [ -z "$ref" ] || PS_BRANCH="// $ref "
}
function errorcolor {
    [ "$errcode" == 0 ] && echo -ne "\e[32m" || echo -ne "\e[31m"
}
function printretcode {
    errorcolor
    [ "$errcode" != 0 ] && printf " FAIL %3s" $errcode || echo -n "—————————"
}
function awsprofile {
    if [ "${AWS_PROFILE-default}" != "default" ]; then
        echo -ne "\e[31m[AWS=$AWS_PROFILE] "
    fi
}
PROMPT_COMMAND=parse_git_branch
PS_INFO="$GREEN\u@\h$RESET:$BLUE\w"
PS_GIT="$RESET\$PS_BRANCH"
PS_TIME="\[\e[\$((COLUMNS-19))G\]$RESET"'`printretcode $?`'$RESET" [\t]"
export PS1='`errorcolor`'"\${PS_FILL}\[\033[0G\]"'`awsprofile`'"$RESET${PS_INFO} ${PS_GIT}${PS_TIME}\n${RESET}"'\$ '

# helper functions
gcd() {
    cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)"/"$1"
}

set -o noclobber # don't allow > to overwrite existing files
