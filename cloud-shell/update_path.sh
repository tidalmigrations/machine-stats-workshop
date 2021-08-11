#!/bin/bash

# Add ~/.local/bin to PATH
if [[ "$PATH" =~ (^|:)"${HOME}/.local/bin"(:|$) ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Add ~/bin to PATH
if [[ "$PATH" =~ (^|:)"${HOME}/bin"(:|$) ]]; then
    PATH="$HOME/bin:$PATH"
fi