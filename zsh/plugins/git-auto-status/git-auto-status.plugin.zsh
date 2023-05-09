# -*- mode: sh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# According to the Zsh Plugin Standard:
# https://wiki.zshell.dev/community/zsh_plugin_standard
0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"
# Then ${0:h} to get plugin's directory
if [[ ${zsh_loaded_plugins[-1]} != */git-auto-status && -z ${fpath[(r)${0:h}]} ]] {
  fpath+=( "${0:h}" )
}
# Standard hash for plugins, to not pollute the namespace
typeset -gA Plugins
Plugins[GIT_AUTO_STATUS_DIR]="${0:h}"
autoload -Uz example-script
# Use alternate vim marks [[[ and ]]] as the original ones can
# confuse nested substitutions, e.g.: ${${${VAR}}}
# vim:ft=zsh:tw=120:sw=2:sts=2:et:foldmarker=[[[,]]]
