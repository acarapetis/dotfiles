# vim: ft=sh
# enable color support of ls and also add handy aliases
#PATH="$HOME/.local/bin:$PATH"

set -o noclobber # don't allow > to overwrite existing files

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

export LC_ALL=en_US.utf-8
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30:ow=34:st=37;44:ex=32;1:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;"
export EDITOR=nvim
export TF_CLI_ARGS_apply='-parallelism 24'
export TF_CLI_ARGS_plan='-parallelism 24'
export TF_CLI_ARGS_destroy='-parallelism 24'
export PSQL_PAGER="pspg -s 6"

# Ubuntu 24.04 gets uppity about pip installing in the system python env;
# but it's really not that dangerous if you keep it to ~/.local/lib.
alias pipinstall="pip3 install --break-system-packages --user"
alias xml=xmlstarlet
alias csvalign="column -t -s,"
alias pcsv="pspg -s 6 --csv -f"
alias bat=batcat
alias mysql="mysql --pager='pspg -s 6'"
alias renumber="tmux movew -r"
alias dive="sudo docker run -v /var/run/docker.sock:/var/run/docker.sock -it wagoodman/dive"
alias ll='ls -alh --file-type'
alias la='ls -a'
alias l='ls -CF'
alias ltr='ls -Alhrt --file-type'
alias s3=s5cmd
alias gl='git log'
alias gg='git graph'
alias reset='tput reset' # removes unnecessary delay
alias fd=fdfind
alias mm=micromamba
alias v=nvim
alias d=deactivate
alias comp='docker compose'
alias rgg='rg --no-ignore'
alias xo=xdg-open
alias ur='uv run'


function jat {
    jq . "$@" | bat -l json
}

function lsd {
    if [ -z "$1" ]; then
        pf=""
    elif [[ "$1" == */ ]]; then
        pf="$1"
    else
        pf="$1/"
    fi
    ls -d "$pf".*/ "$pf"*/
}

# start fugitive in fullscreen, optionally with a git command
function fug {
    if [ -z "$1" ]; then
        nvim +'call GFull()'
    else
        nvim +":G $*" +":normal o"
    fi
}

# paged pretty ripgrep
function rg {
    command rg -p "$@" | less -RF
}

function keep_trying {
    while ! "$@"; do sleep 1; done
}

function duh {
    du -ha "$@" | sort -h
}

function ripsed {
    pattern="$1"
    replacement="$2"
    mapfile -t files < <(command rg --files-with-matches "$pattern")
    count=${#files[@]}
    if [ "$count" == 0 ]; then
        >&2 echo "No matches found."
    else
        command rg "$pattern" -r "$replacement"
        >&2 echo -n "Perform above replacements on all $count files [y/n]? "
        read answer
        if [[ "${answer^}" =~ ^Y ]]; then
            for x in "${files[@]}"; do
                sed -i "s|$pattern|$replacement|g" "$x"
            done
            >&2 echo "Done."
        else
            >&2 echo "Cancelling."
        fi
    fi
}

function get_aws_secret {
    aws secretsmanager get-secret-value --secret-id "$@" | jq -r '.SecretString'
}

gcd() {
    cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)"/"$1"
}

# smart git alias:
# - just g gives git status
# - with args, passes through to git
g() {
    if [ -z "$1" ]; then
        git status
    else
        git "$@"
    fi
}
# enable completion for g:
if [ -f /usr/share/bash-completion/completions/git ]; then
    . /usr/share/bash-completion/completions/git
    ___git_complete g __git_main
fi


function privateip {
    ip a show dev "${1:-eth0}" | perl -ne '/^\s*inet ([\d\.]+)\// and print $1'
}
function publicip {
    curl https://checkip.amazonaws.com
}


function tmux {
    if [ "$1" == "" ]; then
        "$(which tmux)" new-session -A -s anthony
    else
        "$(which tmux)" "$@"
    fi
}

function docker-rmi {
    docker image ls --format '{{.Repository}}:{{.Tag}}' "$@" | xargs docker rmi
}

function ecr-delete-untagged {
    local repo=$1
    local region=${2-ap-southeast-2}
    local images
    images=$(aws ecr list-images --region "$region" --repository-name "$repo" --filter "tagStatus=UNTAGGED" --query 'imageIds[*]' --max-items 100 --output json)
    if [ "$images" == "[]" ]; then
        >&2 echo "No untagged images in ECR repo $repo"
    else
        aws ecr batch-delete-image --region "$region" --repository-name "$repo" --image-ids "$images"
    fi
}

eval "$(fzf --bash)"
eval "$(starship init bash)"

function a {
    for d in .venv venv env .env; do
        if [ -e $d/bin/activate ]; then
            . $d/bin/activate
            return
        fi
    done
    >&2 echo "Could not find a virtualenv in ./[.][v]env."
}
