#!/bin/bash

# You can set the env variable here instead of exporting it globally.
YOURKIT_MONITOR=$HOME/.youmonitor
LD_LIBRARY_PATH=$YOURKIT_MONITOR/current/32:$YOURKIT_MONITOR/current/64:$LD_LIBRARY_PATH

echo Preparing to execute Maven with profiler
echo "Searching for projects in $YOURKIT_MONITOR"

declare -a PROJECTS

for f in `find $YOURKIT_MONITOR -type f -name repository.json -print `; do
    PROJECT_ID=`jq -r '.guid' $f`
    PROJECT_NAME=`jq -r '.displayName' $f`
    echo " - Found project($PROJECT_ID): $PROJECT_NAME"
    PROJECTS+=("$PROJECT_ID" "$PROJECT_NAME")
done

if [[ ${#PROJECTS[@]} -eq "0" ]]; then
    echo "No projects found in $YOURKIT_MONITOR. Exiting!"
    exit 1
fi

# Avoid redirection issues when running script in different terminal context.
TERMINAL=$(tty)
SELECTED_PROJECT=$(dialog --backtitle "YourKit YouMonitor Project Select" --title "Choose" --menu "" 15 80 4 "${PROJECTS[@]}" 2>&1 >$TERMINAL)

clear

if [[ -z "$SELECTED_PROJECT" ]]; then
    echo "Nothing selected - exiting..."
    exit 0
fi

echo "Starting build using YouMonitor project: $SELECTED_PROJECT"

MAVEN_OPTS="$MAVEN_OPTS -agentlib:youmonitor=repository=$YOURKIT_MONITOR/repositories/$SELECTED_PROJECT"

set -x
env LD_LIBRARY_PATH="$LD_LIBRARY_PATH" MAVEN_OPTS="$MAVEN_OPTS" MAVEN_DEBUG_OPTS="$MAVEN_DEBUG_OPTS" mvn "$@"
