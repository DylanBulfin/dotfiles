#!/bin/bash
zoxide query --score --list $1 | sort -r -n -k 1 | awk -F ' ' '{print $2}'
