#!/bin/bash

#
# You can set the env variables here instead of exporting them globally if you want.
#
#YOUMONITOR_HOME=$HOME/.youmonitor
#YOUMONITOR_REPOSITORIES=$YOUMONITOR_HOME/repositories

# Fallback defaults for YOUMONITOR_HOME and YOUMONITOR_REPOSITORIES.
if [ -z "$YOUMONITOR_HOME" ]; then
    YOUMONITOR_HOME=$HOME/.youmonitor
fi

if [ -z "$YOUMONITOR_REPOSITORIES" ]; then
    YOUMONITOR_REPOSITORIES=$YOUMONITOR_HOME/repositories
fi

# Dependency check
if ! type dialog &> /dev/null || ! type jq &> /dev/null; then
    echo "This script depends on dialog and jq."
    echo "Please ensure you have both of them installed and available in your PATH!"
    exit 1
fi

echo "Searching for projects in $YOUMONITOR_REPOSITORIES"

declare -a PROJECTS

for f in `find $YOUMONITOR_REPOSITORIES -type f -name repository.json -print `; do
    PROJECT_ID=`jq -r '.guid' $f`
    PROJECT_NAME=`jq -r '.displayName' $f`
    echo " - Found project($PROJECT_ID): $PROJECT_NAME"
    PROJECTS+=("$PROJECT_ID" "$PROJECT_NAME")
done

if [[ ${#PROJECTS[@]} -eq "0" ]]; then
    echo "No projects found in $YOUMONITOR_REPOSITORIES. Exiting!"
    exit 1
fi

# Avoid redirection issues when running script in different terminal context.
TERMINAL=$(tty)
SELECTED_PROJECT=$(dialog --backtitle "Select YouMonitor project" --title "Select a project" --menu "" 15 80 4 "${PROJECTS[@]}" 2>&1 >$TERMINAL)

clear

echo ""
echo "YouMonitor installed at: $YOUMONITOR_HOME"
echo "YouMonitor repositories path: $YOUMONITOR_REPOSITORIES"
echo -n "YouMonitor selected project: "

if [[ -z "$SELECTED_PROJECT" ]]; then
    echo "No project selected"
    echo "Nothing more to do - exiting."
    echo ""
    exit 0
else
    echo $YOUMONITOR_REPOSITORIES/$SELECTED_PROJECT
fi
echo ""

set -x
LD_LIBRARY_PATH=$YOUMONITOR_HOME/current/32:$YOUMONITOR_HOME/current/64:$LD_LIBRARY_PATH
MAVEN_OPTS="$MAVEN_OPTS -agentlib:youmonitor=repository=$YOUMONITOR_REPOSITORIES/$SELECTED_PROJECT"
env LD_LIBRARY_PATH="$LD_LIBRARY_PATH" MAVEN_OPTS="$MAVEN_OPTS" MAVEN_DEBUG_OPTS="$MAVEN_DEBUG_OPTS" mvn "$@"
