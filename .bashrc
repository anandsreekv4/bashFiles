# Super.cshrc
[ -f /tools/stbflow/iot/bashrc.iot ] && source /tools/stabflow/iot/bashrc.iot;

########################################
# General
########################################
  # return value of a pipeline is the status of the last cmd
  # with non 0 exit, else if all are good, exit 0
  set -o pipefail
  export HOME2=/projects/work/ansn
  if [ "$COLORTERM" = "gnome-terminal" ] || [ "$COLORTERM" = "xfce4-terminal" ];then
      export TERM=xterm-256color
  elif [ "$COLORTERM" = "rxvt-xpm" ];then
      export TERM=rxvt-256color
  fi  
  export EDITOR='vim'
  export VISUAL='vim'
  unset GREP_OPTIONS
  unset GREP_COLOR
  alias vi='vim'
  alias g='gvim -geometry 1336x744'
  alias gvimdiff='gvimdiff -geometry 1336x744'
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
  alias gt="git_treeconfig"
  lpwd() { ls -ltrah `pwd`/$1; }
  export http_proxy=corp-webw105.cysemi.com:74 
  export https_proxy=corp-webw105.cysemi.com:74 
  alias untar='tar -xvf'
  alias clob='gmake clobber'

########################################
# Prompt
########################################
  function tab_title {
    echo -n -e "\033]0;`pwd | rev | cut -d/ -f1,2,3 | rev`\007";
  }
  # PROMPT_COMMAND=""
  # PROMPT_COMMAND="tab_title ; $PROMPT_COMMAND";
  PROMPT_COMMAND="tab_title ; printf "\""\e[?2004l"\"""

  source ~/bashGitPrompt.sh

########################################
# Git
########################################
  alias gl="git lol"
  alias gis="git -c color.ui=always status  | more"
  alias gid="git difftool"
  gido()  { 
      echo git difftool "$1~" "$*";
      git difftool "$1~" "$*";
  }
  gidof()  { git difftool "$1~" "$1" $2; }
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
  alias gnc='bsub -I  gmake RTL_TOOL=ncsim compile COMP64=1 2>&1 | tee gnc.log'
  alias gncbt='bsub -I  gmake RTL_TOOL=ncsim compile COMP64=1 STUB_BTFM=1 |& tee gnc.log'
  alias gncf='bsub -I  gmake RTL_TOOL=ncsim compile COMP64=1 NO_CORE_RECOMPILE=1 NO_RTL_RECOMPILE=1 && rm -rf tsmc28hpm_ncsim_INCISIVE15.20.042_64/cds.lib && gmake tsmc28hpm_ncsim_INCISIVE15.20.042_64/cds.lib 2>&1 | tee gnc.log'
alias gne='bsub -I gmake RTL_TOOL=ncsim force-elab COMP64=1 |& tee gne.log'
  alias gncf_bt='bsub -I  gmake RTL_TOOL=ncsim compile COMP64=1 NO_CORE_RECOMPILE=1 NO_RTL_RECOMPILE=1 STUB_BTFM=1 |& tee gnc.log'
  alias cverdi="b72i gmake compile RTL_TOOL=novas |& tee comp.verdi"
  alias open_verdi='b128 -q normal gmake configsim.debussy RTL_TOOL=novas COMP64=1 &'
  alias open_verdi_play='b128 -q normal gmake configsim.debussy RTL_TOOL=novas COMP64=1 '
  alias open_simv='b128 -q normal gmake configsim.gui RTL_TOOL=ncsim COMP64=1 &'
  alias gmti="b128 gmake compile RTL_TOOL=mti MTI_USE_LATEST=1 COMP64=1 |& tee complog_mti_1.log "
  alias test='b128 -q normal gmake RTL_TOOL=ncsim COMP64=1 '
  alias testm='gmake RTL_TOOL=ncsim COMP64=1 MAILLIST=ansn@cypress.com QUEUE=normal'


########################################
# Paths
########################################
  export PATH=/tools/linux/local/bin:$PATH
  export PATH=/tools/stabflow/iot/bin/:$PATH
  export PATH=/tools/apps/local/vim/latest/bin:$PATH
  export PATH=/projects/CYW55560/work/scripts:$PATH
  export PATH=/projects/CYW55560/work/scripts/keep_copy_script:$PATH
  export PATH=$HOME2/.local/bin:$PATH;
  export PATH=$HOME/scripts:$PATH;
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
  export h2a0='/projects/CYW55560/CYW55560YA0/'
  export svv='/projects/BCM4350/work/anand'
  export status='/projects/BCM4350_ext/work/ansn/status'


########################################
# Work specific
########################################
  cdebug() { 
    fromelf -a -c -d "$1.exe" > "$1.diss";
    ~ayko/new_scripts/debug_tarmac.pl "$1.diss" "$1.eis" > "$1.debug";
    g "$1.debug"; 
  }

  gf() {
    bsub -I -q normal gmake file_list FILELIST_PREFIX=../design/`basename $PWD` 2>&1 |  tee gf.log;
  }

  memCp () {
  start=`fromelf $1.exe -a -c -d -z | grep buffer | awk '{print $1}'`;
  fromelf $1.exe -a -c -d -z > $1.diss;
  echo $start;
  cp "$1.mem" "${1}_${start}.mem";
  cp "$1.diss" "${1}_${start}.diss";
  mkdir -p trng_chara/$2;
  cp -rf $1.* trng_chara/$2;
  ssh ansn@iremote15.india.cypress.com "mkdir -p /projects/BCM4373/work/ansn/src_sdiod/tools/47xxtcl/trng/$2";
  scp "$1_${start}.mem" "$1_${start}.diss" ansn@iremote15.india.cypress.com:/projects/BCM4373/work/ansn/src_sdiod/tools/47xxtcl/trng/$2;
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



########################################
# cd & bd
########################################
function cd() {
  if [ "$#" = "0" ]
  then
  pushd ${HOME} > /dev/null
  elif [ -f "${1}" ]
  then
    ${EDITOR} ${1}
  else
  pushd "$1" > /dev/null
  fi
}

function bd(){
  if [ "$#" = "0" ]
  then
    popd > /dev/null
  else
    for i in $(seq ${1})
    do
      popd > /dev/null
    done
  fi
}


########################################
# shopt
########################################
shopt -s cdspell

########################################
# TEMP
########################################
# alias vcs='/tools/apps/synopsys/vcsmx_vO-2018.09-SP1-1/bin/vcs'
# alias verdi='/tools/apps/synopsys/verdi3-L-2016.06-SP1-1/bin/verdi'
# export VCS_HOME='/tools/apps/synopsys/vcsmx_vO-2018.09-SP1-1/'
# export VERDI_HOME='/tools/apps/synopsys/verdi3-L-2016.06-SP1-1'
# export NOVAS_HOME='/tools/apps/synopsys/verdi3-L-2016.06-SP1-1'
# export PATH=/tools/apps/synopsys:$PATH
unset VERDI_HOME
export  MODELVER=questasim_10.5c_5

########################################
# cr4 verdi
########################################
alias overcr4='bsub -Ip gmake armcr4_top.debussy RTL_TOOL=novas WORKINGLIBNAME="armcr4_top" VSIM_VLIBS="-L CORTEXR4 -L armcr4macro -L tcm -L etmr4 -L coresight600" NOVAS_USE_LATEST=1'
alias overotp='bsub -I gmake mxs28otpc_top.debussy COMP64=1 RTL_TOOL=ncsim NCSIM_USE_LATEST=1 WORKINGLIBNAME="mxs28otpc_top" VSIM_VLIBS="-L mxambatk -L mxs28otpc_hnd_macros -L sc_8 -L mxs28otpc_macro -L mxs28otpc_otp28 -L h00_tsmc28hpl"'


########################################
# emacs version
########################################
# module load emacs/24.0 " Insert mode backspace mapping


########################################
# DVT eclipse
########################################
source ~/.dvt_settings

# Temp
function cpg {
    cp /projects/CYW54910/work/ansn/CR4_CHANGES/$1 $1;
}

# Add the git branch to commandline
# parse_git_branch() {
#     # Print red for meta repo - purple for normal repo
#     if [[ -f ./.mgit ]] ; then
#     print_color="\e[1;31m"
#     else
#     print_color="\e[1;35m"
#     fi
#     x=`mgit branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'`
#     y="$print_color$x\e[0m"
#     echo -ne $y
# }
# export PS1="\h:\w\$(parse_git_branch) $ "
