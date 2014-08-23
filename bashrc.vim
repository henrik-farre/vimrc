#!/bin/bash

export VIMPROMPT=[VIM]

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

export PS1=${VIMPROMPT}${PS1}
