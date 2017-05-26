calculate_concurrency() {
  MEMORY_AVAILABLE=${MEMORY_AVAILABLE-$(detect_memory 512)}
  WEB_MEMORY=${WEB_MEMORY-512}
  WEB_CONCURRENCY=${WEB_CONCURRENCY-$((MEMORY_AVAILABLE/WEB_MEMORY))}
  if (( WEB_CONCURRENCY < 1 )); then
    WEB_CONCURRENCY=1
  fi
  WEB_CONCURRENCY=$WEB_CONCURRENCY
}

log_concurrency() {
  echo "Detected $MEMORY_AVAILABLE MB available memory, $WEB_MEMORY MB limit per process (WEB_MEMORY)"
  echo "Recommending WEB_CONCURRENCY=$WEB_CONCURRENCY"
}

detect_memory() {
  local default=$1
  local limit=$(ulimit -u)

  case $limit in
    256) echo "512";;      # Standard-1X
    512) echo "1024";;     # Standard-2X
    16384) echo "2560";;   # Performance-M
    32768) echo "14336";;  # Performance-L
    *) echo "$default";;
  esac
}

export PATH="$HOME/.heroku/node/bin:$PATH:$HOME/bin:$HOME/node_modules/.bin:/usr/local/bin"
export NODE_HOME="$HOME/.heroku/node"
export NODE_ENV=${NODE_ENV:-production}
export ELECTRON_ENABLE_LOGGING=true
export ELECTRON_ENABLE_STACK_DUMPING=true

echo " "
echo "nodejs.sh path= $PATH" 
echo " "
 if grep -q 'if ! which xauth >\/dev\/null; then error "xauth command not found" exit 3 fi' "/home/vcap/app/xvfb/usr/bin/xvfb-run"; then
   echo "WHOLE THING IN HERE"
 fi
  if grep -q 'error "xauth command not found"' "/home/vcap/app/xvfb/usr/bin/xvfb-run"; then
   echo "ERROR IN HERE"
 fi
  if grep -q 'exit 3' "/home/vcap/app/xvfb/usr/bin/xvfb-run"; then
   echo "EXIT IN HERE"
 fi
echo "----"
# sed -i'' -e 's/if ! which xauth >\/dev\/null; then error "xauth command not found" exit 3 fi//g' "/home/vcap/app/xvfb/usr/bin/xvfb-run"
# sed -i'' -e 's/exit 3//g' "/home/vcap/app/xvfb/usr/bin/xvfb-run"
# sed -i'' -e 's/error "xauth command not found"/echo "DO NOTHING IN HERE"/g' "/home/vcap/app/xvfb/usr/bin/xvfb-run"

echo $(cat /home/vcap/app/xvfb/usr/bin/xvfb-run)
echo "----"
echo $(cat /home/vcap/app/xauth/usr/bin/xauth)
echo "----"
cd /home/vcap/app/bin
echo " contents of /home/vcap/app/bin is: $(ls)"
echo "------------------"
calculate_concurrency

export MEMORY_AVAILABLE=$MEMORY_AVAILABLE
export WEB_MEMORY=$WEB_MEMORY
export WEB_CONCURRENCY=$WEB_CONCURRENCY

if [ "$LOG_CONCURRENCY" = "true" ]; then
  log_concurrency
fi
