if status is-interactive
    # Commands to run in interactive sessions can go here
end

#general settings
set fish_greeting
#supressess the default fish greeting

# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end


#The bindings for !! and !$
if [ $fish_key_bindings = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end

##ALIASES
alias ls='exa -l --color=always --group-directories-first -I="#*" -I="*\~" | egrep -v "(*#|*~)"' # my preferred listing, ignore emacs backup files
alias l='ls'
alias unlock='sudo rm /var/lib/pacman/db.lck'    # remove pacman lock
#alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias grep='rg'
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'
alias br='brightnessctl set'
alias ..='cd ..'
alias ...='cd .. && cd ..'
alias extendhdmi='xrandr --output HDMI-A-0 --mode 1920x1080 && xrandr --output eDP --left-of HDMI-A-0 && xrandr --output HDMI-A-0 --mode 1920x1080 --rate 144.00 && nitrogen --restore'
alias ghc='ghc -dynamic'
alias pro='cd /home/michal/Programming/'
alias emacs="emacsclient -c -a 'emacs'"

## CUSTOM FUNCTIONS
function yt-downloader
    $HOME/Programming/Python/yt-downloader/yt-downloader.py
end

function pomodoro-cli
    $HOME/Programming/Python/pomodoro-cli/pomodorocli.py
end

function texnote
    $HOME/Programming/Bash_Scripts/texnote.sh $argv && exit
end

function exportnotes
    $HOME/Programming/Bash_Scripts/exportnotes.sh
end

function executable
    $HOME/Programming/Bash_Scripts/executable.sh $argv
end

function texedit
    $HOME/Programming/Bash_Scripts/texedit.sh $argv && exit
end

function autotest
    $HOME/Programming/Bash_Scripts/rustbench/autotest.sh $argv >> /dev/null
    echo "Done"
end

alias upscale-cli='$HOME/Programming/Python/upscale-cli/upscale_launcher.sh'

fish_add_path --path /home/michal/.local/bin/lvim /home/michal/.cargo/bin

# /usr/bin/xmodmap /home/michal/.Xmodmap 2> /dev/null &

# Start X at login
if status is-interactive
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
        xinput set-prop "MSFT0004:00 06CB:CD98 Touchpad" "libinput Tapping Enabled" 1
        rmdir /home/michal/Desktop
	xmodmap /home/michal/.Xmodmap
    end
end

function fish_title
	 true
end

rmdir ~/Desktop 2> /dev/null