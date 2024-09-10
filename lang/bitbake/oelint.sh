#!/bin/env bash

# The `sed` removes the '[...]' at the end of a message since it might contain a ':' and break the parser
"$HOME/miniconda3/bin/oelint-adv" \
    "$@" \
    2>&1 | sed 's/\[.*\]//g' 1>&2
