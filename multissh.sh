#!/bin/bash
# Written by J.T. Buice - KainosBP
# a script to ssh multiple servers over multiple tmux panes
# Open tmux first, then run the script from the inital tmux pane.

starttmux() {
    if [ -z "$HOSTS" ]; then
       echo -n "Please provide of list of hosts separated by spaces [ENTER]: "
       read HOSTS
    fi

    local hosts=( $HOSTS )
    echo -n "Please provide the username you want to log into the servers with [ENTER]: "
    read USER
    local user=( $USER )

    tmux new-window "ssh -l "$USER" ${hosts[0]}"
    unset hosts[0];
    for i in "${hosts[@]}"; do
        tmux split-window -h  "ssh -l "$USER" $i"
        tmux select-layout tiled > /dev/null
    done
    tmux select-pane -t 0
    tmux set-window-option synchronize-panes on > /dev/null

}

HOSTS=${HOSTS:=$*}

starttmux
