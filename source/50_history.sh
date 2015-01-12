# History settings

# Allow use to re-edit a faild history substitution.
shopt -s histreedit
# History expansions will be verified before execution.
shopt -s histverify
# History will be appended, not overwritten.
shopt -s histappend

# Entries beginning with space aren't added into history, and duplicate
# entries will be erased (leaving the most recent entry).
export HISTCONTROL="ignorespace:erasedups"
# Give history timestamps.
export HISTTIMEFORMAT="[%F %T] "
# Lots o' history.
export HISTSIZE=100000
export HISTFILESIZE=100000

# Easily re-execute the last history command.
alias r="fc -s"

# history search
alias hist='history | grep'

# syncs history between all open windows; can be annoying
#export PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"
