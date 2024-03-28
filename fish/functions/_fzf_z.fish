function _fzf_z --description "Search the current directory. Replace the current token with the selected file paths."
    # Directly use fd binary to avoid output buffering delay caused by a fd alias, if any.
    # Debian-based distros install fd as fdfind and the fd package is something else, so
    # check for fdfind first. Fall back to "fd" for a clear error message.
    set -f fd_cmd (command -v fdfind || command -v fd  || echo "fd")
    set -f --append fd_cmd --color=always $fzf_fd_opts

    set -f fzf_arguments --multi --ansi $fzf_directory_opts
    set -f token (commandline --current-token)
    # expand any variables or leading tilde (~) in the token
    set -f expanded_token (eval echo -- $token)
    # unescape token because it's already quoted so backslashes will mess up the path
    set -f unescaped_exp_token (string unescape -- $expanded_token)

    set --export FZF_FISH_USE_Z $unescaped_expanded_token

    set --prepend fzf_arguments --prompt="Directory> " --query="$unescaped_exp_token" --preview="ls --color=auto"
    set -f file_paths_selected (/home/dylan/.scripts/fzfz.sh $unescaped_exp_token | _fzf_wrapper $fzf_arguments --bind "change:reload(/home/dylan/.scripts/fzfz.sh {q})" --preview-window="hidden" --scheme=path --tiebreak=index)


    if test $status -eq 0
        commandline --current-token --replace -- (string escape -- $file_paths_selected | string join ' ')
    end

    commandline --function repaint
end
