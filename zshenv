# brew
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

# rbenv
PATH="$HOME/.rbenv/bin:$PATH"
PATH="$HOME/.rbenv/shims:$PATH"

# executable scripts
export PATH=$PATH:/home/fiedl/.exec

# java
# export JAVA_HOME=`/usr/libexec/java_home`
[[ -f /Library/Java/Home ]] && export JAVA_HOME="/Library/Java/Home"
[[ -f /usr/libexec/java_home ]] && export JAVA_HOME=`/usr/libexec/java_home -v 1.7`

# icecube
export ICECUBE_SOFTWARE="$HOME/icecube/software"   # modify this to your needs!
export SVN="http://code.icecube.wisc.edu/svn"
export PYTHONPATH="/usr/local/lib/root/:/usr/local/lib/python2.7/site-packages:$PYTHONPATH"
export I3_PORTS="$ICECUBE_SOFTWARE/ports"
export SIM="$ICECUBE_SOFTWARE/simulation-trunk-2014-05-12/debug_build"
export GENIE='/usr/local/Cellar/genie/2.8.0'
