# Super.cshrc
[ -f /tools/stbflow/iot/bashrc.iot ] && source /tools/stabflow/iot/bashrc.iot;

########################################
# General
########################################
  export HOME2=/projects/work/ansn
  if [ "$COLORTERM" = "gnome-terminal" ] || [ "$COLORTERM" = "xfce4-terminal" ];then
      export TERM=xterm-256color
  elif [ "$COLORTERM" = "rxvt-xpm" ];then
      export TERM=rxvt-256color
  fi  
  unset GREP_OPTIONS
  unset GREP_COLOR
  alias vi='vim'
  alias g='gvim -geometry 1336x744'
  alias src='source ~/.bashrc'
  alias grep="grep --color=auto"
  alias gg='grep -iPrn  "\!:1" \!:2' #comprehensive and faster grep
  alias mailjob='echo "command_done in `pwd`" | mailx -S command_done_at__`pwd` ansn@cypress.com'
  alias hgrep="history | grep"
  ff() { find . -iname "$1"; }
  sf() { find `pwd` -type f -iname "$1" -print; }
  sd() { find `pwd` -type d -iname "$1" -print; }
  alias l="ls -altrh"
  alias g="gvim -geometry 1336x744 "
  alias h="history | tail"
  alias h20="history | tail -20"
  alias h40="history | tail -40"
  alias c=clear
  alias rm="rm -i"
  lpwd() { ls -ltrah `pwd`/$1; }
  export http_proxy=corp-webw105.cysemi.com:74 
  export https_proxy=corp-webw105.cysemi.com:74 
  alias untar='tar -xvf'

########################################
# Prompt
########################################
  function tab_title {
    echo -n -e "\033]0;`pwd | rev | cut -d/ -f1,2,3 | rev`\007";
  }
  PROMPT_COMMAND="tab_title ; $PROMPT_COMMAND";

  source ~/bashGitPrompt.sh

########################################
# Git
########################################
  alias gl="git lol"
  alias gis="git -c color.ui=always status  | more"
  alias gid="git difftool"
  gido()  { git difftool "$1~" "$1"; }
  mgiti() { bsub -I mgit clone wlangit@wlangit.aus.cypress.com:"$1"/"$1";}


########################################
# Tools
########################################
  export CDSVER=INCISIVE15.20.042
  export LM_LICENSE_FILE='
  /proj/lic_vault/golden/lic_vault/tmald-india-prod-wan/license.dat'
  export SNPSLMD_LICENSE_FILE='
  /proj/lic_vault/golden/lic_vault/snpslmd-design-prod-wan/license.dat'

  alias bjobs='bjobs -w'
  alias b128='bsub -I -R "rusage[mem=128000]"'
  alias b32i='bsub -q normal -Ip -R "rusage[mem=32000]"'
  alias b48i='bsub -q normal -Ip -R "rusage[mem=48000]"'
  alias b72i='bsub -q normal -Ip -R "rusage[mem=72000]"'
  alias b144i='bsub -q normal -Ip -R "rusage[mem=144000]"'
  alias lic_verdi='
  lmstat -a -c /proj/lic_vault/golden/lic_vault/snpslmd-design-prod-wan/license.dat -f Verdi'
  alias lic_syn='
  lmstat -a -c /proj/lic_vault/golden/lic_vault/snpslmd-aus-prod-wan/license.dat'
  alias lic_cdn='
  lmstat -a -c /proj/lic_vault/golden/lic_vault/cdslmd-aus-prod-wan/license.dat'
  alias lic_men='
  lmstat -a -c /proj/lic_vault/golden/lic_vault/mgcld-aus-prod-wan/license.dat'
  alias gpsy='bsub -I gmake RTL_TOOL=spyglass compile SPYGLASS_GOALS=initial_rtl/lint/lint_rtl 2>&1 | tee  gspy.log'
  alias gpsycdc='b128 make compile RTL_TOOL=spyglass SPYGLASS_GOALS=initial_rtl/cdc/clock_reset_integrity,initial_rtl/cdc/cdc_verify_struct 2>&1 | tee  gspycdc.log'
  alias open_spy='b144i gmake RTL_TOOL=spyglass configsum.gui &'
  alias gnc='bsub -I  gmake RTL_TOOL=ncsim compile COMP64=1 |& tee gnc.log'
  alias gncf='bsub -I  gmake RTL_TOOL=ncsim compile COMP64=1 NO_CORE_RECOMPILE=1 NO_RTL_RECOMPILE=1 && rm -rf tsmc28hpm_ncsim_INCISIVE15.20.042_64/cds.lib && gmake tsmc28hpm_ncsim_INCISIVE15.20.042_64/cds.lib |& tee gnc.log'
  alias gncf_bt='bsub -I  gmake RTL_TOOL=ncsim compile COMP64=1 NO_CORE_RECOMPILE=1 NO_RTL_RECOMPILE=1 STUB_BTFM=1 |& tee gnc.log'
  alias cverdi="b72i gmake compile RTL_TOOL=novas |& tee comp.verdi"
  alias open_verdi='b128 -q normal_35 gmake configsim.debussy RTL_TOOL=novas COMP64=1 &'
  alias open_verdi_play='b128 -q normal_35 gmake configsim.debussy RTL_TOOL=novas COMP64=1 '
  alias open_simv='b128 -q normal_35 gmake configsim.gui RTL_TOOL=ncsim COMP64=1 &'
  alias gmti="b128=gmake compile RTL_TOOL=mti MTI_USE_LATEST=1 COMP64=1 |& tee complog_mti_1.log "


########################################
# Paths
########################################
  export PATH=/tools/linux/local/bin:$PATH
  export PATH=/tools/stabflow/iot/bin/:$PATH
  export PATH=/tools/apps/local/vim/latest/bin:$PATH
  export PATH=/projects/CYW55560/work/scripts:$PATH
  export PATH=/projects/CYW55560/work/scripts/keep_copy_script:$PATH
  export PATH=$HOME2/.local/bin:$PATH;
  export g35="/projects/BCM4335/gallery" 
  export g45="/projects/BCM4345/gallery_frontend" 
  export g64="/projects/BCM4364/gallery_frontend" 
  export g12="/projects/BCM43012/gallery_frontend" 
  export g49="/projects/BCM4349/gallery_frontend" 
  export gal="/projects/BCM4349/gallery_frontend" 
  export galb="/projects/BCM4349/gallery_backend" 
  export g50="/projects/BCM4350/gallery_frontend" 
  export h2='/projects/CYW55560/users/ansn'
  export h2b='/projects/CYW55560'
  export svv='/projects/BCM4350/work/anand'


########################################
# Work specific
########################################
  cdebug() { 
    fromelf -a -c -d "$1.exe" > "$1.diss";
    ~ayko/new_scripts/debug_tarmac.pl "$1.diss" "$1.eis" > "$1.debug";
    g "$1.debug"; 
  }

  gf() {
    bsub -I -q normal_35 gmake file_list FILELIST_PREFIX=../design/`basename $PWD` 2>&1 |  tee gf.log;
  }

  alias compare='git stash && clob && gf && keep cp && git stash apply && clob && gf && keep comp &'
    # Hatchet2
  alias tessent_vis='cd /projects/CYW55560/users/ansn/Tessent_top; b128 tessent -shell  -tesvis -dof run_tessent -log logfiles/1.log -replace'

########################################
# TMUX
########################################
  alias tma='tmux attach-session -t'
  alias tm='tmux'

########################################
# fzf
########################################
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash
  alias vf='vim -o `fzf`'
  export FZF_DEFAULT_COMMAND='find . -not -path "./.git/*" -not -path "./.snapshot/*"  -not -path "./.vim/*" '
